# 🚀 Jac Hammer AI — Master Project Initialization Prompt (UniPath LK)

Copy the entire prompt inside the code block below and paste it directly into **Jac Hammer AI (`https://jachammer.ai`)** to initialize the project:

```text
Build a complete, production-ready full-stack Jac application called "UniPath LK" — The Post-A/L Higher Education Alternative Pathway Navigator for Sri Lanka.

### 1. CORE COMPLIANCE & TECH STACK
- ≥ 80% of the codebase MUST be written in native Jac (.jac).
- Strictly follow valid Jac syntax:
  - Capitalized `True`, `False`, `None` (never lowercase `true`/`false`).
  - Non-default `has` attributes MUST be declared before default `has` attributes inside every `node`, `edge`, `obj`, and `walker`.
  - Use `can <name> with <NodeType> entry { ... }` for walker and node abilities.
  - Use `root spawn <WalkerName>(...)` to dispatch walkers and `report <payload>;` to return JSON responses.
  - Use `+>: EdgeType(...) :+>` for typed edges and `++>` for untyped edges.
  - Never use reserved keywords (`obj`, `node`, `edge`, `walker`, `can`, `has`, `report`) as variable names.
  - Use `by llm()` with deterministic try/except fallback so the system never crashes if an API key is missing or rate-limited.

---

### 2. THE PROBLEM & BIG IDEA
Every year in Sri Lanka, 300,000 students sit the G.C.E. A/L exam, but only 45,000 enter state universities. Over 250,000 students face a deadlock: Z-score is too low for free state university intake, and family budget is too low for direct private university tuition.
Instead of a shallow If-Else filter that says "No courses found", UniPath LK uses an Object-Spatial Graph and a "Council of Walkers" that deliberate on a Spatial Blackboard (`deliberation_board`), perform Dynamic Graph Metamorphosis (spawning new synthetic bridge nodes and edges at runtime), evaluate complete multi-step pathways, run a 4-year Ghost Simulation with economic shocks, and output a 5-step tomorrow-morning Action Plan.

---

### 3. OBJECT-SPATIAL GRAPH ARCHETYPES (NODES, EDGES & OBJECTS)

1. `obj AgentCritique` (Spatial Blackboard Entry):
   - `has agent_name: str;`
   - `has is_viable: bool;`
   - `has confidence: float;`
   - `has reason: str;`
   - `has financial_gap_lkr: float = 0.0;`
   - `has timestamp_step: int = 1;`

2. `node InstituteCourse`:
   - `has code: str;`
   - `has name: str;`
   - `has institution: str;`
   - `has sector_type: str;` # 'State_Free_Tech', 'IFSLS_Private', 'External_Degree', 'Vidya_Peeta', 'Foreign_Scholarship', 'Vocational_NVQ'
   - `has slqf_level: int;` # Level 3: Diploma, Level 4: HND, Level 5: Bachelor's General, Level 6: Bachelor's Honours
   - `has nvq_level: int;` # 0 if N/A, 4, 5, 6, or 7
   - `has allowed_streams: list[str];` # ['Maths', 'Bio', 'Tech', 'Commerce', 'Arts', 'Any']
   - `has min_al_passes: int;`
   - `has min_z_score: float;`
   - `has duration_years: float;`
   - `has annual_tuition_lkr: float;`
   - `has upfront_admission_fee: float;`
   - `has monthly_living_lkr: float;`
   - `has ifsls_eligible: bool;`
   - `has allows_work: bool;`
   - `has location_city: str;`
   - `has career_tags: list[str];`
   - `has source_url: str = "https://ugc.ac.lk";`
   - `has ugc_recognized: bool = True;`
   - `has is_synthetic: bool = False;`
   - `has node_status: str = "neutral";` # 'neutral', 'viable_green', 'rejected_red', 'synthetic_gold', 'unlocked_cyan'
   - `has deliberation_board: list[AgentCritique] = [];`

3. `edge BridgePathway` (Evidence-Backed Transition Edge):
   - `has transition_type: str = "lateral_entry";` # 'admission', 'exemption', 'progression', 'lateral_entry'
   - `has requirements: list[str] = [];`
   - `has source_id: str = "UGC_CIRCULAR_2024";`
   - `has valid_for_intake: str = "2026/2027";`
   - `has verification_status: str = "verified";` # 'verified', 'unverified', 'needs_confirmation'
   - `has added_duration_months: int = 0;`
   - `has added_cost_lkr: float = 0.0;`
   - `has credits_transferred: int = 60;`
   - `has is_synthetic: bool = False;`
   - `has rationale: str = "";`

4. `obj Pathway` (First-Class Composite End-to-End Pathway):
   - `has pathway_id: str;`
   - `has title: str;`
   - `has pillar: str;` # 'Lowest Cost Pathway', 'Fastest Completion Pathway', 'Best Career & Work-Study Fit'
   - `has course_sequence: list[str];`
   - `has target_slqf_level: int;`
   - `has total_cost_lkr: float;`
   - `has upfront_cost_lkr: float;`
   - `has monthly_burn_lkr: float;`
   - `has total_duration_years: float;`
   - `has ifsls_covered_lkr: float = 0.0;`
   - `has out_of_pocket_lkr: float = 0.0;`
   - `has funding_gap_lkr: float = 0.0;`
   - `has is_feasible: bool = True;`
   - `has feasibility_failures: list[str] = [];`
   - `has verification_status: str = "verified";`
   - `has source_evidence: str = "UGC / TVEC Verified";`
   - `has resilience_score: float = 0.0;`
   - `has shock_survival_notes: list[str] = [];`
   - `has tradeoff_note_sinhala: str = "";`

---

### 4. REAL SRI LANKAN HIGHER EDUCATION SEED GRAPH (`walker :pub SeedGraph`)
Populate the graph with real Sri Lankan institutions and evidence-backed `BridgePathway` edges:
1. `SLIATE-HNDIT-GALLE`: SLIATE HND in Information Technology (Labuduwa, Galle) | Free Tuition (0 LKR), Upfront 2,500 LKR, SLQF 4 / NVQ 6, 2.5 yrs, Any Stream (3 Passes), City: Galle.
2. `SLIATE-HNDE-COLOMBO`: SLIATE HND in Engineering (Mattakkuliya, Colombo) | Free Tuition (0 LKR), Upfront 3,000 LKR, SLQF 4 / NVQ 6, 3.5 yrs, Maths Stream (3 Passes).
3. `ITUM-NDT-MORATUWA`: Institute of Technology University of Moratuwa (NDT Engineering) | Free Tuition (0 LKR), Upfront 5,000 LKR, SLQF 4, 3.0 yrs, Maths Stream (Z >= 1.05).
4. `UCSC-BIT-EXT`: University of Colombo (UCSC) BIT External Degree | Annual Tuition 85,000 LKR, Upfront 15,000 LKR, SLQF 5/6, 3.0 yrs, Any Stream (3 Passes), Allows Work = True.
5. `UNIVOTEC-BTECH-SW`: University of Vocational Technology (UNIVOTEC) B.Tech in Software Technology | Tuition 0 LKR (State), Upfront 10,000 LKR, SLQF 6 / NVQ 7, 3.0 yrs, Lateral Entry from NVQ 5/6.
6. `SLIIT-SE-HONOURS`: SLIIT BSc (Hons) in Software Engineering (Malabe) | Annual Tuition 650,000 LKR, Upfront 75,000 LKR, SLQF 6, 4.0 yrs, IFSLS Loan Eligible = True, City: Colombo.
7. `NSBM-CS-DEGREE`: NSBM Green University BSc in Computer Science (Homagama) | Annual Tuition 550,000 LKR, Upfront 60,000 LKR, SLQF 6, 4.0 yrs, IFSLS Loan Eligible = True, City: Colombo.
8. `KIU-BIOTECH-HONOURS`: KIU / SLIIT BSc (Hons) in Biotechnology (Malabe) | Annual Tuition 580,000 LKR, Upfront 50,000 LKR, SLQF 6, 4.0 yrs, Bio Stream, IFSLS Loan Eligible = True, City: Colombo.
9. `NCOE-VIDYAPEETA`: National College of Education (Vidya Peeta - Teaching Diploma) | Free Tuition (0 LKR), Free Boarding + 5,000 LKR Stipend, SLQF 4, 3.0 yrs, Any Stream (Z >= 1.10), 100% Guaranteed Govt Teacher Job.
10. `MOHE-CSC-SCHOLARSHIP`: MOHE Bilateral Full Scholarship (China CSC / India ICCR Engineering & IT) | Tuition 0 LKR, Stipend Included, SLQF 6, 4.0 yrs, Maths/Bio (Z >= 1.55).
11. `VTA-NVQ4-IT`: VTA / NAITA National Certificate in ICT (NVQ Level 4) | Tuition 15,000 LKR, Upfront 2,000 LKR, SLQF 2 / NVQ 4, 1.0 yr, Min Passes: 0 (Open to A/L failed students).
12. `OUSL-BSE-HONOURS`: Open University of Sri Lanka (OUSL) BSc Hons in Software Engineering | Annual Tuition 140,000 LKR, Upfront 20,000 LKR, SLQF 6, 4.0 yrs, Allows Work = True.

Connect verified `BridgePathway` edges:
- `VTA-NVQ4-IT` -> `SLIATE-HNDIT-GALLE` (NVQ 4 to NVQ 6 progression, verified by TVEC).
- `SLIATE-HNDIT-GALLE` -> `UNIVOTEC-BTECH-SW` (NVQ 6 lateral entry to Year 2 B.Tech, verified by UNIVOTEC Act).
- `SLIATE-HNDIT-GALLE` -> `UCSC-BIT-EXT` (Parallel/Lateral progression to External Degree).
- `ITUM-NDT-MORATUWA` -> `OUSL-BSE-HONOURS` (Credit exemption pathway, verified).

---

### 5. THE COUNCIL OF WALKERS, 4 MECHANICS & 9 ARCHITECTURAL UPGRADES

Implement the complete multi-agent workflow orchestrated by `walker :pub RunPathwayCouncil`:

1. **Agent 1: `AspirationScout`**
   - Filters courses matching `stream`, `min_al_passes`, and `target_career`.
   - Logs action `search_courses` into `decision_log`.

2. **Agent 2: `FiscalSurvivalGuard` (Writes to Spatial Blackboard)**
   - Living Cost Matrix (2026 Sri Lanka Baseline):
     - Colombo Metro Boarding: LKR 38,000/month
     - Outstation Boarding (Galle/Kandy/Kurunegala): LKR 26,000/month
     - Home Commute (same district or `can_commute=True`): LKR 10,000/month (boarding drops to 0!).
   - IFSLS State Loan Calculation:
     - If `ifsls_eligible == True` and `al_passes >= 3`, deducts up to LKR 1,500,000 tuition loan + LKR 300,000 stipend (LKR 75,000/yr).
   - Evaluates Upfront Admission Fee AND Monthly Burn Rate against `monthly_budget_lkr` and `total_savings_lkr`.
   - Posts typed `AgentCritique` onto each node's `deliberation_board`. Marks unaffordable nodes as `rejected_red`.

3. **Agent 3: `SLQFGatekeeper` (Enforces UGC/TVEC on Blackboard)**
   - Validates UGC Recognition and SLQF Level >= 4 (or NVQ progression ladder for <3 passes).
   - Checks transition edge `verification_status` ('verified' vs 'needs_confirmation') and `source_id`.
   - Posts typed `AgentCritique` onto `deliberation_board`.

4. **Agent 4: `BridgeSynthesizer` (The Hero AI Brain — Dynamic Graph Metamorphosis)**
   - Uses `by llm()` (with deterministic fallback) when a student is deadlocked (e.g., Z-score < 1.3 for state uni AND budget < LKR 40,000/mo for Colombo private uni).
   - Performs **Dynamic Graph Metamorphosis** at runtime: spawns a new synthetic `InstituteCourse` node (`SYNTH-SLIATE-BIT-BRIDGE`: SLIATE HNDIT + UCSC BIT Work-Study Hybrid Bridge, SLQF 6, Monthly Cost LKR 14,500, Allows Work = True, `node_status="synthetic_gold"`) and connects it with a `BridgePathway(is_synthetic=True, credits_transferred=60)` edge!

5. **Agent 5: `PathwayEvaluator` & 2-Stage Scoring Engine**
   - Evaluates complete multi-step `Pathway` objects (not just isolated courses).
   - **Stage 1 (Feasibility Binary Gate)**: Eliminates any pathway violating hard constraints (A/L passes, upfront cash limit, monthly burn gap) with 0% constraint violations.
   - **Stage 2 (Preference Ranking)**: Categorizes feasible pathways into 3 distinct pillars with Sinhala trade-off explanations:
     - Pillar 1: **Lowest Cost Pathway** (Free Diploma / Bridge Ladder)
     - Pillar 2: **Fastest / Govt Loan Pathway** (Direct Honours via IFSLS Interest-Free Loan)
     - Pillar 3: **Best Work-Study Fit** (External Degree + Industry Earner)

6. **Agent 6: `GhostWalker` (4-Year Future Shock Simulation)**
   - Simulates 3 real-world Sri Lankan shocks on each recommended pathway:
     - Shock 1: +15% living inflation & +40% bus/transport fare hike.
     - Shock 2: 6-month exam/academic delay.
     - Shock 3: Year 2 industry internship income (+LKR 50,000/month for work-friendly paths).
   - Computes `resilience_score` (0–100%) and shock survival advisories.

7. **Winning Feature 1: `GapAnalyzerWalker` (Gap Finder)**
   - Contrasts the student's Current State (A/L Z-score, passes, budget) against the Target Career Goal (SLQF 6, 120 credits, industry portfolio) and outputs structured gap milestones.

8. **Winning Feature 2: `MinimumChangeFinder` (Sensitivity Unlocker)**
   - For rejected (`rejected_red`) nodes, calculates the exact single minimum change that unlocks them:
     - E.g., "Increase monthly budget by +LKR 4,500/month" OR "Switch to Home Commute (saves LKR 28,000/month boarding)" OR "Apply for IFSLS Interest-Free Loan".

9. **Winning Feature 3: `ActionPlanGenerator` (Tomorrow Morning 5-Step Checklist)**
   - Generates a concrete 5-step checklist in conversational Sinhala + English (application link, Grama Niladhari & A/L certificate prep, intake registration deadline, exact upfront deposit in LKR, and specific question to confirm with the institute registrar).

---

### 6. PRE-CRAFTED 8 STUDENT TEST PROFILES & BASELINE COMPARISON
Include an endpoint/preset selector with 8 real Sri Lankan test profiles:
- `TP-1: Dinuka (Galle)` | Maths, Z: 1.12, 3 Passes, Monthly Budget: LKR 25,000, Career: Software Engineer (Triggers Deadlock -> Dynamic Bridge Synthesis!).
- `TP-2: Kaveesha (Gampaha)` | Bio, Z: 1.35, 3 Passes, Monthly Budget: LKR 55,000, Career: Biotechnology Researcher (Unlocks IFSLS Loan Degree).
- `TP-3: Sithum (Kurunegala)` | Tech, Z: 0.85, 3 Passes, Monthly Budget: LKR 15,000, Career: Automation Engineer (Unlocks Free SLIATE/ITUM -> UNIVOTEC B.Tech).
- `TP-4: Fathima (Colombo)` | Commerce, Z: 1.20, 3 Passes, Monthly Budget: LKR 30,000, Home Commute: True, Career: FinTech / Business Analyst.
- `TP-5: Ravindu (Matara)` | Maths, Z: 0.45, 1 Pass (Failed A/L), Monthly Budget: LKR 12,000, Career: Full-Stack Developer (Unlocks VTA NVQ 4 -> NVQ 6 -> UNIVOTEC B.Tech).
- `TP-6: Anuki (Kandy)` | Bio, Z: 1.40, 3 Passes, Monthly Budget: LKR 18,000, Career: STEM Educator / Govt Teacher (Unlocks Free NCoE Vidya Peeta + Stipend).
- `TP-7: Tharindu (Jaffna)` | Maths, Z: 1.65, 3 Passes, Monthly Budget: LKR 15,000, Career: AI & Robotics Engineer (Unlocks MOHE Bilateral Foreign Scholarship).
- `TP-8: Nipuna (Kalutara)` | Arts, Z: 1.10, 3 Passes, Monthly Budget: LKR 35,000, Career: UI/UX & Software Engineer (Unlocks UCSC BIT External + Work-Study).

Also compute a `baseline_comparison` object comparing what a "Naive SQL/If-Else Filter" returns (often 0 results or unaffordable raw tuition) vs what "UniPath Council of Walkers" achieves.

---

### 7. INTERACTIVE FRONTEND UI REQUIREMENTS
Build a modern, visually stunning dark-mode dashboard (Cyber-Academic Emerald/Gold/Crimson theme) that connects to the Jac backend walkers:
1. **Top Bar**: Project branding ("UniPath LK — Council of Walkers"), Quick-Load Preset Selector for the 8 Student Test Profiles, and Evaluation Metrics badges (Constraint Violations: 0%, Evidence Coverage: 95%, Response Time).
2. **Left Panel (Student Constraints & Live Sliders)**:
   - Student Name, A/L Stream, Z-Score, A/L Passes (0–3), District, Target Career.
   - Monthly Budget Slider (LKR) & "Can Commute from Home" Toggle (changing these dynamically unlocks red nodes!).
   - "Run Council of Walkers" CTA button.
3. **Center Panel (Interactive Object-Spatial Graph & Spatial Blackboard)**:
   - Visual node-link graph showing `InstituteCourse` nodes color-coded live:
     - Red (`rejected_red`): Pruned by FiscalGuard / Gatekeeper.
     - Green (`viable_green`): Feasible & Accredited.
     - Gold Pulsing (`synthetic_gold`): Dynamically spawned `BridgeSynthesizer` node (`SYNTH-SLIATE-BIT-BRIDGE`)!
   - Clicking any node displays its **Spatial Blackboard (`deliberation_board`)** critiques from FiscalGuard and SLQFGatekeeper, plus edge `source_id` and `verification_status`.
4. **Right / Bottom Panels**:
   - **Structured Decision Log**: Step-by-step live audit trail (`✓`, `?`, `⚡`) for judges.
   - **3 Ranked Pathway Cards (2-Stage Scored)**: Showing Lowest Cost, Fastest/IFSLS, and Work-Study pillars with Upfront Fee, Monthly Burn, IFSLS Loan offset, and **Ghost Simulation Resilience Score (0-100%)** progress bar.
   - **Gap Finder & Minimum Change Unlocker**: Interactive card showing exact LKR delta or commute switch to unlock rejected campuses with a 1-click "Apply Minimum Change" button.
   - **Tomorrow Morning 5-Step Action Plan**: Conversational Sinhala + English checklist.
   - **Naive Filter vs UniPath AI Comparison Table**: Proving why multi-agent graph navigation beats static filtering.
```
