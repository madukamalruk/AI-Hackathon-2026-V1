# Multi-Agent Specifications: Council of Four Lens Walkers & Planner — UniPath LK

## 1. Overview (Practical + Winning Edition)
UniPath LK uses a **request-scoped, stateless** multi-agent architecture in Jac v0.16.7:
1. **`AspirationLensWalker`** (Deterministic)
2. **`FiscalLensWalker`** (Deterministic Monthly Cash-Flow Engine)
3. **`GatekeeperLensWalker`** (Deterministic Three-Valued Logic Evaluator)
4. **`BridgeLensWalker`** (Validated Multi-Step Route Ranker & Explainer)
5. **`BranchSearchWalker`** (Branch-Isolated, Cycle-Safe Graph Search with Backtracking Events)
6. **`PlannerAgent`** (Bounded 4-Action Agent with Honest Rules Fallback)

Each lens emits request-scoped `Finding` objects rather than mutating shared graph nodes, guaranteeing zero cross-request state contamination.

---

## 2. The Four Lens Walkers

| Lens Walker | Question Answered | Verdict Values |
|---|---|---|
| `AspirationLensWalker` | Does this offering support the student's target goal, award level (SLQF/NVQ), and delivery mode? | `strong_fit` \| `partial_fit` |
| `FiscalLensWalker` | Can the student fund this given initial savings and monthly budget? Computes `minimum_balance_lkr` and `shortfall_lkr`. | `cash_ok` \| `shortfall` \| `unknown_cost` |
| `GatekeeperLensWalker` | Do entry requirements (`all` / `any`) pass, fail, or remain unknown? What is the evidence status? | `pass` \| `fail` \| `unknown` |
| `BridgeLensWalker` | When direct entry is blocked, which catalogue-verified multi-step routes repair the plan? | `valid_bridge` (rejects any non-catalogue route) |

---

## 3. Search & Planner Walkers

- **`BranchSearchWalker`**:
  - Expands paths up to `max_steps = 4` and `max_states = 100`.
  - Copies `SearchState` (`path_ids`, `accumulated_quals`) per branch so branches never contaminate each other (`T08`).
  - Logs `DecisionEvent(event_type="backtrack")` whenever an incoming `ProgressesTo` edge fails a target node's `all` prerequisite (`T02`).
- **`PlannerAgent`**:
  - Chooses from 4 allowlisted actions: `ask_student`, `search_alternatives`, `evaluate_candidates`, `finish`.
  - Emits a `Question` when an unknown profile field (e.g. `can_relocate`) blocks a candidate route (`T03`).
  - Reports `planner_mode: live_ai | rules_fallback` honestly (`T11`).

---

## 4. Claude Council Deliberation & A/L Shy Strategic Synthesis

UniPath LK incorporates multi-perspective Council Deliberation methods:
- **`Aspiration Scout`**: Deliberates on academic qualifications (SLQF Level 6 Bachelor's Degree vs SLQF Level 4/5 Higher Diploma) and career ceiling mobility.
- **`Fiscal Guardian`**: Evaluates student liquid capital against upfront enrollment fees, monthly recurring costs, travel inflation, and IFSLS loan subsidies.
- **`Gatekeeper Lens`**: Strictly verifies statutory regulatory compliance under the Sri Lanka Qualifications Framework (SLQF) and TVEC Act No. 29 of 1995.
- **`Bridge Synthesizer` (Sri Lankan Student Reality Engine)**:
  - Specifically addresses the real-world dilemma faced by Sri Lankan post-A/L students with low passes or insufficient Z-scores.
  - Generates a direct side-by-side trade-off matrix:
    1. **Option A: G.C.E. A/L 2nd / 3rd Shy Strategic Retake**:
       - *Timeline*: 12 Months.
       - *Estimated Cost*: ~LKR 3,500/month (Total ~LKR 47,000).
       - *Core Value*: Lowest financial cost; preserves eligibility for 100% Free State University degree (UGC merit seat) or direct UCSC BIT / OUSL admission without foundation stages.
    2. **Option B: Immediate TVEC Vocational Ladder (NVQ 4 -> SLIATE HNDIT -> UNIVOTEC B.Tech)**:
       - *Timeline*: 30 - 36 Months.
       - *Estimated Cost*: ~LKR 3,500/month (Total ~LKR 140,000).
       - *Core Value*: Starts immediately with zero study gap; guaranteed hands-on software development training, free government tuition at SLIATE, and a 6-month industry internship leading to NVQ 6.

---

## 5. Lightweight Production Security Hardening

In accordance with production webapp research guidelines (`production_webapp_research_2026-10-17.md`), UniPath LK enforces essential, high-impact safeguards:
1. **Server-Side Allowlisted Schema Validation**:
   - Strict bounds: `savings_lkr`, `monthly_budget_lkr` bounded to $[0, 100,000,000]$.
   - Allowlisted fields only; any unsupported payload key raises a strict `ValueError`.
   - String sanitization: `career_goal` and `home_district` are cleansed of script and HTML tags (`<`, `>`).
2. **Zero Personal Data Persistence**:
   - Request-scoped execution; no student personal identity, contact details, or session cookies are written to disk or sqlite databases.
3. **Graph Search Protection**:
   - Explicit bounds: `max_steps = 4`, `max_states = 100`, `max_candidates = 20`.
   - Cycle detection and pruning (`cycle_pruned`) prevents denial-of-service from looping edges.
4. **AI Guardrails & Rate Budgets**:
   - Student profile data is passed as untrusted observation data, never executed as instruction.
   - Concurrency bounded to 2 workers; rate-limited to $\le 30$ calls per minute with a strict 5.0-second timeout.
   - Guaranteed honest fallback to deterministic rules whenever model times out or returns out-of-schema actions.
5. **Sanitized Error Reporting**:
   - API endpoints catch all runtime exceptions and return sanitized client messages without leaking server stack traces or directory paths.
