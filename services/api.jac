"""The six public, anonymous operations. Inputs are recomputed server-side."""
import from .engine { _load_catalogue, _validate_profile, _stress, _base_dir }
import from .planner { _planning_session }

walker:pub get_app_info {
    can info with Root entry {
        real = _load_catalogue("real");
        demo = _load_catalogue("demo");
        report {"app_name": "UniPath LK", "version": "0.2.0", "jac_version": "0.16.7", "domains": real.data["domains"],
            "real_programmes": len(real.data["offerings"] as list), "catalogue_version": real.version,
            "demo_qualifications": [{"id": o["award_id"], "label": o["title"]} for o in (demo.data["offerings"] as list[dict])],
            "real_qualifications": [{"id": o["award_id"], "label": o["title"]} for o in (real.data["offerings"] as list[dict])] + (real.data.get("qualifications", []) as list[dict])};
    }
}

walker:pub plan_pathways {
    has profile: dict = {};
    can plan with Root entry {
        try { report _planning_session(_validate_profile(self.profile)); }
        except ValueError as error { report {"status": "invalid_input", "message": str(error)}; }
    }
}

walker:pub run_stress_test {
    has profile: dict = {}, scenario: str = "travel_plus_40_and_delay_6m";
    can stress with Root entry {
        try { report _stress(_validate_profile(self.profile), self.scenario); }
        except ValueError as error { report {"status": "invalid_input", "message": str(error)}; }
    }
}

walker:pub get_catalogue_projection {
    has catalogue_mode: str = "real";
    can project with Root entry {
        try {
            catalogue = _load_catalogue(self.catalogue_mode);
            report {"status": "ready", "catalogue_mode": catalogue.mode, "version": catalogue.version,
                "offerings": catalogue.data["offerings"], "transitions": catalogue.data["transitions"]};
        } except ValueError as error { report {"status": "invalid_input", "message": str(error)}; }
    }
}

walker:pub get_evidence {
    has catalogue_mode: str = "real", offering_id: str = "";
    can evidence with Root entry {
        try {
            catalogue = _load_catalogue(self.catalogue_mode);
            rows = [];
            for offering in (catalogue.data["offerings"] as list[dict]) {
                if not self.offering_id or offering["id"] == self.offering_id { rows.extend(offering.get("claims", []) as list[dict]); }
            }
            for transition in (catalogue.data["transitions"] as list[dict]) {
                if not self.offering_id or self.offering_id in [transition["from_id"], transition["to_id"]] { rows.extend(transition.get("claims", []) as list[dict]); }
            }
            report {"status": "ready", "claims": rows};
        } except ValueError as error { report {"status": "invalid_input", "message": str(error)}; }
    }
}

walker:pub health {
    can readiness with Root entry {
        try {
            real = _load_catalogue("real");
            demo = _load_catalogue("demo");
            report {"ok": True, "version": "0.2.0", "real_programmes": len(real.data["offerings"] as list),
                "demo_programmes": len(demo.data["offerings"] as list)};
        } except Exception { report {"ok": False, "message": "Catalogue readiness failed. Check the server configuration."}; }
    }
}
