"""Deterministic, evidence-aware graph planning. No student state is persisted."""
import os;
import json;
import hashlib;
import threading;

glob _catalogues: dict[str, Catalogue] = {};
glob _catalogue_lock = threading.RLock();
glob _base_dir: str = os.path.dirname(os.path.dirname(os.path.abspath(__file__)));

node Catalogue {
    has mode: str, version: str, data: dict;
}
node Offering {
    has record: dict;
}
edge ProgressesTo {
    has record: dict;
}

def _load_catalogue(mode: str) -> Catalogue {
    if mode not in ["demo", "real"] { raise ValueError("Choose a supported catalogue."); }
    with _catalogue_lock {
        if mode in _catalogues { return _catalogues[mode]; }
        with open(os.path.join(_base_dir, "data", mode, "catalogue.json"), "r", encoding="utf-8") as source {
            raw = json.load(source) as dict;
        }
        graph = Catalogue(mode=mode, version=str(raw["version"]), data=raw);
        by_id: dict[str, Offering] = {};
        for record in (raw["offerings"] as list[dict]) {
            if record["id"] in by_id { raise ValueError("Duplicate catalogue ID."); }
            by_id[record["id"]] = (graph ++> Offering(record=record))[0] as Offering;
        }
        for transition in (raw["transitions"] as list[dict]) {
            if transition["from_id"] not in by_id or transition["to_id"] not in by_id {
                raise ValueError("Catalogue contains a dangling transition.");
            }
            by_id[transition["from_id"]] +>: ProgressesTo(record=transition) :+> by_id[transition["to_id"]];
        }
        _catalogues[mode] = graph;
        return graph;
    }
}

def _validate_profile(raw: dict) -> dict {
    defaults = {
        "catalogue_mode": "real", "domain_id": "it", "career_goal": "",
        "al_stream": "unknown", "al_year": None, "al_subjects": [], "al_passes": None,
        "ol_maths_grade": "unknown", "ol_english_grade": "unknown", "z_score": None,
        "savings_lkr": 2000, "monthly_budget_lkr": 5000, "home_district": "Galle",
        "study_mode": "any", "can_relocate": None, "existing_qualifications": [],
        "has_maths_credit": None, "preference": "lowest_cost", "profile_revision": 1,
        "enable_ai": True
    };
    for key in raw {
        if key not in defaults { raise ValueError(f"Unsupported profile field: {key}"); }
    }
    profile = dict(defaults);
    profile.update(raw);
    if profile["catalogue_mode"] not in ["demo", "real"] { raise ValueError("Invalid catalogue mode."); }
    domains = _load_catalogue(str(profile["catalogue_mode"])).data["domains"];
    if profile["domain_id"] not in [d["id"] for d in domains] { raise ValueError("Choose a listed field of interest."); }
    for key in ["savings_lkr", "monthly_budget_lkr", "profile_revision"] {
        value = profile[key];
        if type(value) != int or value < 0 or value > 100000000 {
            raise ValueError(f"{key} must be a non-negative whole number within the supported range.");
        }
    }
    if profile["al_passes"] is not None and (type(profile["al_passes"]) != int or profile["al_passes"] < 0 or profile["al_passes"] > 3) {
        raise ValueError("A/L passes must be between 0 and 3, or unknown.");
    }
    if profile["can_relocate"] is not None and type(profile["can_relocate"]) != bool { raise ValueError("Relocation must be yes, no, or unknown."); }
    if profile["has_maths_credit"] is not None and type(profile["has_maths_credit"]) != bool { raise ValueError("Maths credit must be yes, no, or unknown."); }
    if type(profile["enable_ai"]) != bool { raise ValueError("AI preference must be true or false."); }
    if profile["study_mode"] not in ["any", "full_time", "part_time", "distance", "blended"] { raise ValueError("Invalid study mode."); }
    if profile["preference"] not in ["lowest_cost", "shortest_duration", "study_fit"] { raise ValueError("Invalid preference."); }
    if type(profile["career_goal"]) != str or len(profile["career_goal"] as str) > 160 { raise ValueError("Keep your career goal within 160 characters."); }
    if type(profile["home_district"]) != str or len(profile["home_district"] as str) > 60 { raise ValueError("Invalid home district."); }
    if profile["al_stream"] not in ["unknown", "physical_science", "biological_science", "commerce", "arts", "technology", "other"] { raise ValueError("Invalid A/L stream."); }
    for key in ["ol_maths_grade", "ol_english_grade"] {
        if profile[key] not in ["unknown", "A", "B", "C", "S", "F"] { raise ValueError("Invalid O/L grade."); }
    }
    if profile["al_year"] is not None and (type(profile["al_year"]) != int or profile["al_year"] < 2000 or profile["al_year"] > 2030) { raise ValueError("Invalid A/L year."); }
    if profile["z_score"] is not None and (type(profile["z_score"]) not in [int, float] or not -5 <= profile["z_score"] <= 5) { raise ValueError("Invalid Z-score."); }
    if type(profile["al_subjects"]) != list or len(profile["al_subjects"] as list) > 3 { raise ValueError("Provide up to three A/L subjects."); }
    passes = 0;
    for subject in (profile["al_subjects"] as list[dict]) {
        if type(subject) != dict or type(subject.get("name")) != str or len(subject["name"] as str) > 80 or subject.get("grade") not in ["A", "B", "C", "S", "F", "unknown"] {
            raise ValueError("Each A/L subject needs a name and a valid grade.");
        }
        if subject["grade"] in ["A", "B", "C", "S"] { passes = passes + 1; }
    }
    if len(profile["al_subjects"] as list) == 3 and all([s["grade"] != "unknown" for s in (profile["al_subjects"] as list[dict])]) {
        if profile["al_passes"] is not None and profile["al_passes"] != passes { raise ValueError("A/L pass count does not match the supplied grades."); }
        profile["al_passes"] = passes;
    }
    if profile["has_maths_credit"] is None and profile["ol_maths_grade"] != "unknown" {
        profile["has_maths_credit"] = profile["ol_maths_grade"] in ["A", "B", "C"];
    }
    if type(profile["existing_qualifications"]) != list or len(profile["existing_qualifications"] as list) > 20 { raise ValueError("Invalid qualifications."); }
    catalogue_data = _load_catalogue(str(profile["catalogue_mode"])).data;
    valid_quals = [o["award_id"] for o in (catalogue_data["offerings"] as list[dict])];
    valid_quals.extend([q["id"] for q in (catalogue_data.get("qualifications", []) as list[dict])]);
    for qualification in (profile["existing_qualifications"] as list[str]) {
        if qualification not in valid_quals { raise ValueError("Unrecognised qualification ID. Choose from the catalogue."); }
    }
    return profile;
}

def _condition(condition: dict, profile: dict, qualifications: list) -> str {
    field = condition.get("field", "");
    target = condition.get("value");
    if field == "qualification" { return "pass" if target in qualifications else "fail"; }
    if field == "institution_confirmation" { return "unknown"; }
    if field == "subject" {
        matches = [s for s in (profile["al_subjects"] as list[dict]) if s["name"].strip().lower() == str(target).lower()];
        if not matches or matches[0]["grade"] == "unknown" { return "unknown"; }
        return "pass" if matches[0]["grade"] in ["A", "B", "C", "S"] else "fail";
    }
    actual = profile.get(field);
    if actual is None or actual == "unknown" { return "unknown"; }
    operator = condition.get("cmp", "==");
    if operator == ">=" { return "pass" if actual >= target else "fail"; }
    if operator == "==" { return "pass" if actual == target else "fail"; }
    if operator == "in" { return "pass" if actual in target else "fail"; }
    return "unknown";
}

def _requirements(expression: dict, profile: dict, qualifications: list) -> dict {
    if "field" in expression {
        verdict = _condition(expression, profile, qualifications);
        return {"verdict": verdict, "unknowns": [expression["field"]] if verdict == "unknown" else []};
    }
    results: list[dict] = [_requirements(c, profile, qualifications) for c in (expression.get("conditions", []) as list[dict])];
    values = [r["verdict"] for r in results];
    unknowns = [];
    for item in results {
        for field in (item["unknowns"] as list[str]) {
            if field not in unknowns { unknowns.append(field); }
        }
    }
    if not values { return {"verdict": "pass", "unknowns": []}; }
    if expression.get("op", "all") == "any" {
        verdict = "pass" if "pass" in values else ("unknown" if "unknown" in values else "fail");
    } else {
        verdict = "fail" if "fail" in values else ("unknown" if "unknown" in values else "pass");
    }
    return {"verdict": verdict, "unknowns": [] if verdict == "pass" else unknowns};
}

def _cashflow(steps: list[dict], profile: dict, scenario: str = "baseline") -> dict {
    balance = int(profile["savings_lkr"]);
    minimum = balance;
    total = 0;
    duration = 0;
    ledger = [];
    for (index, step) in enumerate(steps) {
        months = step.get("duration_months");
        upfront = step.get("upfront_cost_lkr");
        recurring = step.get("monthly_cost_lkr");
        travel = step.get("travel_monthly_lkr");
        if months is None or upfront is None or recurring is None or (scenario != "baseline" and travel is None) {
            return {"status": "unknown_cost", "total_cost_lkr": None, "minimum_balance_lkr": None,
                "shortfall_lkr": None, "duration_months": None, "ledger": [], "cost_complete": False};
        }
        upfront = int(upfront); recurring = int(recurring); months = int(months);
        if scenario == "travel_plus_40_and_delay_6m" {
            recurring = recurring + int(round(int(travel) * 0.4));
            if index == 0 { months = months + 6; }
        }
        balance = balance - upfront;
        minimum = min(minimum, balance);
        total = total + upfront;
        ledger.append({"month": duration, "kind": "upfront", "amount_lkr": upfront, "balance_lkr": balance});
        for month in range(months) {
            balance = balance + int(profile["monthly_budget_lkr"]) - recurring;
            minimum = min(minimum, balance);
            total = total + recurring;
        }
        duration = duration + months;
        ledger.append({"month": duration, "kind": "stage_end", "amount_lkr": recurring, "balance_lkr": balance});
    }
    shortfall = max(0, -minimum);
    return {"status": "cash_ok" if shortfall == 0 else "shortfall", "total_cost_lkr": total,
        "minimum_balance_lkr": minimum, "shortfall_lkr": shortfall, "duration_months": duration,
        "ledger": ledger, "cost_complete": True};
}

def _evidence_state(claims: list[dict]) -> str {
    statuses = [c.get("status", "unreviewed") for c in claims];
    for status in ["rejected", "stale", "unreviewed", "fixture"] {
        if status in statuses { return status; }
    }
    return "verified" if statuses else "unreviewed";
}

def _candidate(path: list[dict], transitions: list[dict], profile: dict) -> dict {
    qualifications = list(profile["existing_qualifications"] as list[str]);
    verdict = "pass";
    unknowns = [];
    claims: list[dict] = [];
    conditions = [];
    for (index, step) in enumerate(path) {
        expressions: list[dict] = [step["requirements"] as dict];
        if index > 0 {
            expressions.append(transitions[index - 1].get("requirements", {}) as dict);
            claims.extend(transitions[index - 1].get("claims", []) as list[dict]);
            conditions.append("Complete " + str(path[index - 1]["title"]) + " before progressing.");
        }
        for expression in expressions {
            result = _requirements(expression, profile, qualifications);
            if result["verdict"] == "fail" { verdict = "fail"; }
            elif result["verdict"] == "unknown" and verdict != "fail" { verdict = "unknown"; }
            for field in (result["unknowns"] as list[str]) {
                if field not in unknowns { unknowns.append(field); }
            }
        }
        if profile["study_mode"] != "any" and step["delivery_mode"] not in [profile["study_mode"], "unknown"] {
            verdict = "fail";
            conditions.append("This stage does not match your selected study mode.");
        }
        qualifications.append(str(step["award_id"]));
        claims.extend(step.get("claims", []) as list[dict]);
    }
    cash = _cashflow(path, profile);
    evidence = _evidence_state(claims);
    status = "feasible_under_stated_assumptions";
    if verdict == "fail" or cash["status"] == "shortfall" or evidence == "rejected" {
        status = "not_feasible_under_current_inputs";
    } elif verdict == "unknown" or cash["status"] == "unknown_cost" or evidence in ["unreviewed", "stale"] {
        status = "needs_confirmation";
    } elif len(path) > 1 { status = "conditional"; }
    path_ids = [str(step["id"]) for step in path];
    route_id = "route-" + hashlib.sha256((str(profile["catalogue_mode"]) + ":" + ">".join(path_ids)).encode()).hexdigest()[:16];
    explanation = "Fits the supplied rules and cash-flow assumptions; admission is not guaranteed.";
    if status == "needs_confirmation" { explanation = "A possible route to explore. Confirm missing entry, fee or progression information before deciding."; }
    elif status == "conditional" { explanation = "The cash-flow example fits, conditional on successfully completing every preceding stage."; }
    elif status == "not_feasible_under_current_inputs" {
        explanation = "A known requirement or study preference is not met.";
        if cash["status"] == "shortfall" { explanation = f"The cash-flow estimate needs LKR {cash['shortfall_lkr']:,} more initial savings."; }
    }
    unique_claims = [];
    seen_claims = [];
    for claim in claims {
        if claim["id"] not in seen_claims { unique_claims.append(claim); seen_claims.append(claim["id"]); }
    }
    route_duration = sum([int(step["duration_months"]) for step in path]) if all([step.get("duration_months") is not None for step in path]) else None;
    return {"route_id": route_id, "title": " -> ".join([str(s["title"]) for s in path]), "step_ids": path_ids,
        "steps": path, "transitions": transitions, "route_status": status, "gatekeeper_verdict": verdict,
        "evidence_status": evidence, "claims": unique_claims, "unknowns": unknowns, "conditions": conditions,
        "cashflow": cash, "explanation": explanation, "duration_months": route_duration,
        "next_actions": ["Read the official programme and entry information.", "Confirm the next intake and selection process with the institution.",
            "Request a current fee and payment schedule, including living and travel costs."]};
}

walker BranchSearchWalker {
    has profile: dict;
    has max_steps: int = 4, max_states: int = 100, max_candidates: int = 20;
    has candidates: list[dict] = [], blocked: list[dict] = [], events: list[dict] = [], truncated: bool = False;
    can search with Catalogue entry {
        frontier: list[dict] = [];
        domain = self.profile["domain_id"];
        offerings = [-->](?:Offering);
        for offering in (sorted(offerings, key=lambda item: str((item as Offering).record["id"])) as list[Offering]) {
            record: dict = offering.record;
            if domain not in record["domain_ids"] { continue; }
            requirement = _requirements(record["requirements"] as dict, self.profile, self.profile["existing_qualifications"] as list[str]);
            if requirement["verdict"] == "fail" {
                self.blocked.append({"offering_id": record["id"], "title": record["title"], "reason": "Known entry requirement not met."});
                continue;
            }
            frontier.append({"node": offering, "path": [record], "transitions": [],
                "qualifications": list(self.profile["existing_qualifications"] as list[str]) + [record["award_id"]]});
        }
        expanded = 0;
        while frontier {
            if expanded >= self.max_states or len(self.candidates) >= self.max_candidates {
                self.truncated = True;
                break;
            }
            state = frontier.pop(0);
            expanded = expanded + 1;
            current = state["node"] as Offering;
            if current.record.get("terminal", True) {
                self.candidates.append(_candidate(state["path"] as list[dict], state["transitions"] as list[dict], self.profile));
            }
            neighbours = [current ->:ProgressesTo:->](?:Offering);
            if len(state["path"] as list) >= self.max_steps {
                if neighbours { self.truncated = True; }
                continue;
            }
            for next_node in (sorted(neighbours, key=lambda item: str((item as Offering).record["id"])) as list[Offering]) {
                next_record: dict = next_node.record;
                if domain not in next_record["domain_ids"] { continue; }
                if next_record["id"] in [step["id"] for step in (state["path"] as list[dict])] {
                    self.events.append({"action": "cycle_pruned", "detail": "Skipped a repeated stage: " + str(next_record["title"])});
                    continue;
                }
                links = [edge current ->:ProgressesTo:-> next_node];
                transition = (links[0] as ProgressesTo).record;
                target_rules = _requirements(next_record["requirements"] as dict, self.profile, state["qualifications"] as list[str]);
                edge_rules = _requirements(transition.get("requirements", {}) as dict, self.profile, state["qualifications"] as list[str]);
                if "fail" in [target_rules["verdict"], edge_rules["verdict"]] or _evidence_state(transition.get("claims", []) as list[dict]) == "rejected" {
                    self.blocked.append({"offering_id": next_record["id"], "title": next_record["title"], "reason": "Progression or target requirement not met."});
                    self.events.append({"action": "backtrack", "detail": "Stopped at " + str(next_record["title"]) + "; exploring other branches from " + str(current.record["title"])});
                    continue;
                }
                frontier.append({"node": next_node, "path": list(state["path"] as list[dict]) + [next_record],
                    "transitions": list(state["transitions"] as list[dict]) + [transition],
                    "qualifications": list(state["qualifications"] as list[str]) + [str(next_record["award_id"])]});
            }
        }
    }
}

walker LensWalker {
    has profile: dict, lens: str;
    has findings: dict[str, dict] = {};
    can inspect with Catalogue entry { visit [-->](?:Offering); }
    can evaluate with Offering entry {
        record = here.record;
        if self.profile["domain_id"] not in record["domain_ids"] { return; }
        result: dict = {};
        if self.lens == "Aspiration" {
            result = {"verdict": "matched", "summary": "Catalogue field matches your selected area. Career outcomes require individual assessment."};
        } elif self.lens == "Fiscal" {
            cash = _cashflow([record], self.profile);
            result = {"verdict": cash["status"], "summary": "Costs need confirmation." if not cash["cost_complete"] else ("Cash-flow fits this stage." if cash["shortfall_lkr"] == 0 else "Initial savings are insufficient for this stage.")};
        } else {
            requirement = _requirements(record["requirements"] as dict, self.profile, self.profile["existing_qualifications"] as list[str]);
            result = {"verdict": requirement["verdict"], "summary": "Initial-entry check only. Later stages are rechecked using qualifications earned along the route."};
        }
        result["lens"] = self.lens;
        self.findings[record["id"]] = result;
    }
}

def _sort_candidates(candidates: list[dict], preference: str) -> list[dict] {
    statuses = {"feasible_under_stated_assumptions": 0, "conditional": 1, "needs_confirmation": 2, "not_feasible_under_current_inputs": 3};
    if preference == "shortest_duration" {
        return sorted(candidates, key=lambda item: (statuses[(item as dict)["route_status"]], (item as dict)["duration_months"] if (item as dict)["duration_months"] is not None else 99999, (item as dict)["route_id"]));
    }
    return sorted(candidates, key=lambda item: (statuses[(item as dict)["route_status"]], ((item as dict)["cashflow"] as dict)["total_cost_lkr"] if ((item as dict)["cashflow"] as dict)["total_cost_lkr"] is not None else 999999999, (item as dict)["route_id"]));
}

def _graph_projection(catalogue: Catalogue, profile: dict, candidates: list[dict]) -> dict {
    lenses = [];
    for name in ["Aspiration", "Fiscal", "Gatekeeper"] { lenses.append(catalogue spawn LensWalker(profile=profile, lens=name)); }
    nodes = [];
    edges = [];
    for offering in [catalogue -->](?:Offering) {
        record: dict = offering.record;
        if profile["domain_id"] not in record["domain_ids"] { continue; }
        findings = [lens.findings[record["id"]] for lens in lenses];
        bridge_routes = [route["route_id"] for route in candidates if len(route["steps"] as list) > 1 and record["id"] in route["step_ids"]];
        if bridge_routes { findings.append({"lens": "Bridge", "verdict": "catalogue_route", "summary": "Appears in a catalogue progression; see the complete route conditions."}); }
        nodes.append({"id": record["id"], "title": record["title"], "institution": record["institution"],
            "evidence_status": _evidence_state(record.get("claims", []) as list[dict]), "findings": findings});
        for next_node in [offering ->:ProgressesTo:->](?:Offering) {
            if profile["domain_id"] in next_node.record["domain_ids"] {
                links = [edge offering ->:ProgressesTo:-> next_node];
                edges.append({"from": record["id"], "to": next_node.record["id"], "evidence_status": _evidence_state((links[0] as ProgressesTo).record.get("claims", []) as list[dict])});
            }
        }
    }
    return {"nodes": sorted(nodes, key=lambda item: str((item as dict)["id"])), "edges": edges};
}

def _stress(profile: dict, scenario: str) -> dict {
    if scenario != "travel_plus_40_and_delay_6m" { raise ValueError("Choose a supported stress scenario."); }
    catalogue = _load_catalogue(str(profile["catalogue_mode"]));
    search = catalogue spawn BranchSearchWalker(profile=profile);
    deltas = [];
    for route in _sort_candidates(search.candidates, str(profile["preference"]))[:3] {
        base = route["cashflow"];
        stressed = _cashflow(route["steps"] as list[dict], profile, scenario);
        known = base["cost_complete"] and stressed["cost_complete"];
        deltas.append({"route_id": route["route_id"], "title": route["title"], "available": known,
            "delta_total_cost_lkr": int(stressed["total_cost_lkr"]) - int(base["total_cost_lkr"]) if known else None,
            "delta_shortfall_lkr": int(stressed["shortfall_lkr"]) - int(base["shortfall_lkr"]) if known else None,
            "delta_duration_months": int(stressed["duration_months"]) - int(base["duration_months"]) if known else None,
            "reason": "" if known else "A complete baseline cost and duration schedule is needed."});
    }
    return {"status": "ready", "profile_revision": profile["profile_revision"], "scenario": scenario,
        "assumptions": "Travel component +40%; first stage delayed six months with recurring costs continuing. Scenario, not a forecast.", "deltas": deltas};
}
