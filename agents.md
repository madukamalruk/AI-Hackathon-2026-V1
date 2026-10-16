# 🤖 Multi-Agent Specifications: Council of Walkers — UniPath LK

## 1. Multi-Agent System Overview
In **UniPath LK**, intelligent agentic behavior is not implemented as arbitrary prompt chains. Instead, it is orchestrated as a collaborative **Council of Walkers** in Jac. Each Walker is a specialized autonomous agent with:
- A specific role and goal.
- Isolated state variables (`has` fields).
- Graph traversal abilities (`can ... with ... entry`).
- Formal contracts for handoffs and reporting.
- Interaction via a **Spatial Blackboard** (`deliberation_board`) directly attached to graph nodes.

---

## 2. Core Agentic Architecture: Spatial Blackboard & Graph Metamorphosis

```jac
obj AgentCritique {
    has agent_name: str;
    has is_viable: bool;
    has confidence: float;
    has reason: str;
    has financial_gap_lkr: float = 0.0;
    has timestamp_step: int = 1;
}

node InstituteCourse {
    has code: str;
    has name: str;
    has institution: str;
    has slqf_level: int; # Level 4: HND, Level 5: Bachelor's General, Level 6: Bachelor's Honours
    has duration_years: float;
    has annual_tuition_lkr: float;
    has upfront_admission_fee: float;
    has monthly_living_lkr: float;
    has ifsls_eligible: bool;
    has allows_work: bool;
    has location_city: str;
    has deliberation_board: list[AgentCritique] = [];
}

edge BridgePathway {
    has credits_transferred: int;
    has bridge_fee_lkr: float = 0.0;
    has is_synthetic: bool = False;
    has rationale: str = "";
}
```

---

## 3. Agent Catalog & Detailed Specifications

### 3.1 Agent 1: `AspirationScout`
- **Role**: Career Ambition & Academic Eligibility Explorer.
- **Goal**: Scans the academic graph starting from the student's A/L stream (Physical Science, Bio, Tech, Commerce, Arts) and traverses toward programs connecting to the student's target career.
- **State Fields**:
  - `has target_career: str;`
  - `has stream: str;`
  - `has min_al_passes: int;`
  - `has discovered_programs: list[dict] = [];`
- **Behavior / Ability**:
  - Visits `Root` → traverses `[-->](?:AcademicStream, name == self.stream)`.
  - Traverses `[->:RequiresStream:->]` to find connected `InstituteCourse` nodes.
  - Checks if program leads to `Career` with semantic match.
  - Adds initial candidate records.

---

### 3.2 Agent 2: `FiscalSurvivalGuard`
- **Role**: Financial Reality Checker & IFSLS Loan Strategist.
- **Goal**: Evaluates upfront tuition, hidden living expenses (boarding, food, travel in Colombo vs. outstation vs. home commute), and calculates exact gaps against the student's family budget. Injects state loan subsidies.
- **State Fields**:
  - `has total_budget_lkr: float;`
  - `has student_district: str;`
  - `has monthly_allowance_lkr: float;`
  - `has can_commute_from_home: bool = False;`
- **Behavior / Ability**:
  - Visits candidate `InstituteCourse` nodes.
  - Computes `Monthly Burn Rate = accommodation + food + transport`.
  - If student commutes from home, boarding drops to 0 (bus/train LKR 8k-12k).
  - Injects IFSLS rules: If `ifsls_eligible == True` and A/L passes $\ge 3$, subtracts government interest-free loan entitlement (up to LKR 1.5M for tuition + LKR 300,000 stipend).
  - Writes typed `AgentCritique` directly to `here.deliberation_board`. If budget fails, sets `is_viable = False` with exact shortfall.

---

### 3.3 Agent 3: `SLQFGatekeeper`
- **Role**: Regulatory Compliance, Accreditation & Degree Quality Verifier.
- **Goal**: Protects Sri Lankan families from bogus degrees and unaccredited degree mills.
- **State Fields**:
  - `has min_required_slqf: int = 5;`
  - `has validated_programs: list[dict] = [];`
- **Behavior / Ability**:
  - Inspects `InstituteCourse` node and linked `Institution`.
  - Verifies UGC Recognition (Ministry of Education Non-State Higher Education Division gazetted list).
  - Validates SLQF Levels:
    - SLQF Level 4: Higher Diploma / Foundation (2–2.5 years, NVQ 6 equivalent).
    - SLQF Level 5: Bachelor's Degree General (3 years / 90 credits).
    - SLQF Level 6: Bachelor's Honours Degree (4 years / 120 credits).
    - SLQF Level 7+: Postgraduate / Master's Degree.
  - Ensures TVEC NVQ Level 5/6 mapping for technical pathways.
  - Writes typed `AgentCritique` to `here.deliberation_board`.

---

### 3.4 Agent 4: `BridgeSynthesizer` (The Hero AI Brain — Meaning-Typed Metamorphosis)
- **Role**: Chief Pathway Synthesizer & Dynamic Graph Metamorphosis Engine.
- **Goal**: Detects deadlocks where candidate programs were rejected (e.g. Z-score too low for state uni, and cash budget too low for direct private campus). Spawns dynamic synthetic nodes and bridge edges live into the graph.
- **Implementation**: Native Jac `by llm(method="Reasoning")` construct with strict dataclass output.
- **Behavior / Ability**:
  - Reads `here.deliberation_board` across candidate nodes.
  - If deadlocked, calls `by llm(method="Reasoning")` to synthesize an accredited lateral bridge (e.g. SLIATE HND free diploma $\rightarrow$ NVQ 6 $\rightarrow$ UCSC BIT 2nd year external degree).
  - Performs **Dynamic Graph Metamorphosis**:
    ```jac
    # Dynamically injects new synthetic bridge node into graph topology
    synthetic_course = here ++> InstituteCourse(
        code="SYNTH-SLIATE-BIT-BRIDGE",
        name="SLIATE HNDIT to UCSC BIT Lateral Bridge",
        institution="SLIATE + UCSC External",
        slqf_level=6,
        duration_years=3.5,
        annual_tuition_lkr=65000.0,
        upfront_admission_fee=7500.0,
        monthly_living_lkr=12000.0,
        ifsls_eligible=False,
        allows_work=True,
        location_city="Galle / Online"
    );
    here +>: BridgePathway(credits_transferred=60, is_synthetic=True, rationale="Accredited TVEC NVQ 6 lateral ladder") :+> synthetic_course;
    ```

---

### 3.5 Agent 5: `GhostWalker` (Scenario Stress Tester & Future Simulator)
- **Role**: Economic & Academic Risk Simulator (Ghost Simulation).
- **Goal**: Clones the student's profile and projects 4 years into the future, testing top candidate pathways against real-world Sri Lankan vulnerabilities.
- **State Fields**:
  - `has pathways_to_test: list[dict];`
  - `has stress_reports: list[dict] = [];`
- **Stress Scenarios Simulated**:
  1. **Living Cost Shock**: 15% inflation increase in boarding/food costs + 40% public transport hike.
  2. **Academic Delay Stumble**: 6-month national exam/session delay.
  3. **Work-Study Upside**: Year 2 student lands an industry internship/apprenticeship paying LKR 50,000/month.
- **Behavior / Ability**:
  - Generates a **Pathway Resilience Score** (0–100%) for each candidate pathway.

---

### 3.6 Agent 6: `GapAnalyzerWalker` (Gap Finder)
- **Role**: Structural Discrepancy & Prerequisite Analyzer.
- **Goal**: Visually and semantically contrasts the student's current status (A/L Z-score, passes, location, budget) against the target career destination node, isolating missing credits, prerequisites, and qualification deficits.

---

### 3.7 Agent 7: `MinimumChangeFinder`
- **Role**: Sensitivity & Constraint Relaxation Advisor.
- **Goal**: Calculates the absolute minimum parameter change (e.g., "+LKR 4,500/month budget" or "Commute from home instead of Colombo hostel") that will flip a failed/red course node to viable/green.

---

### 3.8 Agent 8: `ActionPlanGenerator`
- **Role**: Concrete Next-Step Checklist Producer.
- **Goal**: Converts the winning pathway into a 5-step actionable checklist for tomorrow morning in conversational Sinhala + English terms (e.g. download SLIATE application, track UCSC BIT registration window, obtain Grama Niladhari certificate, fee breakdown).

---

## 4. Master Orchestration Walker

```jac
walker :pub RunPathwayCouncil {
    has student_name: str;
    has stream: str;
    has z_score: float;
    has results: dict;
    has total_budget_lkr: float;
    has monthly_budget_lkr: float;
    has target_career: str;
    has district: str = "Western";
    has can_commute: bool = False;

    can coordinate with Root entry {
        # 1. Dispatch AspirationScout
        scout = root spawn AspirationScout(
            stream=self.stream,
            target_career=self.target_career
        );
        candidates = scout.discovered_programs;

        # 2. Dispatch FiscalSurvivalGuard (Writes to Spatial Blackboard)
        fiscal = root spawn FiscalSurvivalGuard(
            total_budget_lkr=self.total_budget_lkr,
            student_district=self.district,
            monthly_allowance_lkr=self.monthly_budget_lkr,
            can_commute_from_home=self.can_commute
        );

        # 3. Dispatch SLQFGatekeeper (Enforces UGC/TVEC on Blackboard)
        slqf = root spawn SLQFGatekeeper(min_required_slqf=5);

        # 4. Dispatch BridgeSynthesizer (Dynamic Graph Metamorphosis if deadlocked)
        synthesizer = root spawn BridgeSynthesizer(
            student_name=self.student_name,
            target_career=self.target_career
        );

        # 5. Dispatch GhostWalker (4-Year Future Shock Simulation)
        ghost = root spawn GhostWalker();

        # 6. Run Gap Finder & Minimum Change Finder
        gap_finder = root spawn GapAnalyzerWalker(target_career=self.target_career);
        min_change = root spawn MinimumChangeFinder();

        # 7. Generate 5-Step Action Plan
        action_plan = root spawn ActionPlanGenerator();

        report {
            "status": "success",
            "pathways": synthesizer.synthesized_pathways,
            "resilience_scores": ghost.stress_reports,
            "gaps": gap_finder.gaps_identified,
            "minimum_change": min_change.unlocked_options,
            "action_plan": action_plan.action_checklist
        };
    }
}
```
