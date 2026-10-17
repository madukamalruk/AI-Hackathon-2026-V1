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
