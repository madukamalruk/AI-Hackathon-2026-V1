# Jac Language (v0.16.7) & UniPath LK — Complete Rules (`rules.md`)

This document defines the syntax, architectural, and UI rules for **UniPath LK (Practical + Winning Edition)**.

---

## 1. Hard Architectural & Honesty Rules

1. **100% Professional English Only**: All code, comments, data files, walker outputs, and UI elements must be in clear, professional English.
2. **Minimal, Non-Vibe-Coded UI**: Keep `index.html` clean, high-contrast, light-themed (`#f8fafc` background, `#ffffff` cards, `1px` `#e2e8f0` borders), and free of neon gradients or decorative clutter.
3. **Deterministic Validation Over LLM Suggestions**:
   - The LLM (`PlannerAgent` / `BridgeLensWalker`) may rank catalogue routes, explain trade-offs, and choose from 4 allowlisted actions (`ask_student`, `search_alternatives`, `evaluate_candidates`, `finish`).
   - It NEVER invents institutions, fees, exemptions, or non-catalogue bridges.
   - Always label `planner_mode: live_ai | rules_fallback` honestly.
4. **Three-Valued Logic (`pass / fail / unknown`)**:
   - Missing student inputs (`None` / `null`) evaluate to `unknown`, triggering `needs_confirmation` status and a clarifying question (`ask_student`).
5. **Monthly Cash-Flow Ledger**:
   - Upfront fees are deducted at the start of a course step; monthly budget contributions and recurring costs are applied at month-end.
   - `shortfall_lkr = max(0, -minimum_balance_lkr)`.
   -Fixture oracle (`T05`): At `savings=2000, monthly_budget=5000`, Direct Degree (`DEMO-DIRECT-DEG`) costs `84,000` with `minimum_balance = -22,000` (`shortfall = 22,000`), while the 3-step route (`DEMO-FOUNDATION -> DEMO-DIPLOMA -> DEMO-TOPUP`) costs `54,000` with `minimum_balance = 0` (`shortfall = 0`). At `savings=24000`, Direct Degree shortfall becomes `0`.

---

## 2. Jac v0.16.7 Syntax Rules

1. **Capitalized Literals**: Always use `True`, `False`, `None`.
2. **Attribute Ordering**: Non-default `has` attributes MUST come before default `has` attributes in all `node`, `edge`, `walker`, and `obj` declarations.
3. **Top-Level Scope**: Only declarations (`import`, `node`, `edge`, `walker`, `obj`, `def`, `glob`) and `with entry` blocks are allowed at top level.
4. **Control Flow**:
   - Inline conditional: `("pass") if cond else ("fail")`
   - Loops: `for item in items { ... }` or `for (idx, item) in enumerate(items) { ... }`
   - Exception handling: `try { ... } except Exception as e { ... }` (never `catch`, and do not leave bare `{}` expression statements without `;`).
5. **Object-Spatial Graph Operations**:
   - Node creation: `created = here ++> CourseOffering(...);`
   - Edge connection: `node_a +>: ProgressesTo(...) :+> node_b;`
   - Typed edge traversal: `neighbors = [node_a ->:ProgressesTo:->](?:CourseOffering);`
   - Walker spawning & reports: `w = root spawn plan_pathways(...); result = w.reports[-1];`

---

## 3. Running & Verifying

```powershell
# 1. Run the 7 Core Architecture Tests (T01, T02, T03, T05, T08, T11, T13)
jac run main.jac

# 2. Start the Jac REST API Server on Port 8000
jac start main.jac --port 8000
```
Public endpoints exposed by `main.jac`:
- `POST /walker/plan_pathways`
- `POST /walker/run_stress_test`
- `POST /walker/get_app_info`
- `POST /walker/health`
- `POST /walker/LoadCatalogue`
