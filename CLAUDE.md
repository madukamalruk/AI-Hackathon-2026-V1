# CLAUDE.md — UniPath LK (Practical + Winning Edition)

This document is the primary reference for Claude (Claude Code / Cursor) when working on **UniPath LK**.

---

## 1. Core Pitch & Architecture (Practical + Winning Edition)

UniPath LK finds **multi-step education routes** for Sri Lankan post-A/L students.
- **Four Request-Scoped Lens Walkers** (`AspirationLensWalker`, `FiscalLensWalker`, `GatekeeperLensWalker`, `BridgeLensWalker`) search a typed Object-Spatial Graph of programmes (`CourseOffering` nodes + `ProgressesTo` edges) and evaluate every route against the student's `StudentProfile`.
- **Bounded Planner (`PlannerAgent`)** picks from 4 allowlisted actions (`ask_student`, `search_alternatives`, `evaluate_candidates`, `finish`) and asks a clarifying question when an essential field (e.g. `can_relocate`) evaluates to `unknown`.
- **Three-Valued Logic (`pass / fail / unknown`)** + **Monthly Cash-Flow Ledger (`minimum_balance_lkr`, `shortfall_lkr`)** validate everything deterministically so nothing is fabricated.

---

## 2. Hard Rules (NEVER Break These)

1. **100% Professional English Only**: No Sinhala text anywhere in code, data, logs, or UI.
2. **Minimal, Non-Vibe-Coded, User-Friendly UI (`index.html`)**: Clean light neutral aesthetic (`#f8fafc` background, `#ffffff` cards, `1px` `#e2e8f0` borders, `#0f172a` text). No neon gradients, no glowing shadows, no fake survival probability bars.
3. **No Hallucinations**:
   - No invented institutions, exemptions, fees, or bridges outside the loaded catalogue.
   - No fake "survival rate" or "89% confidence" numbers. Stress tests (`run_stress_test`) show **absolute deltas** in cost, shortfall, and duration.
   - `None` (`null` in JSON) means `unknown`, never free or zero.
   - Demo fixture (`data/demo/catalogue.json`) and Real IT data (`data/real/catalogue.json`) are visibly labelled in the UI banner.

---

## 3. Repository Structure & Commands

```text
├── main.jac                  # Complete Jac v0.16.7 OSP Graph, 4 Lens Walkers, Planner & T01-T13 Tests
├── index.html                # Minimal, non-vibe-coded English UI with Graph, Question Card & Stress Deltas
├── data/
│   ├── demo/catalogue.json   # Fictional fixture (84,000 direct / -22,000 min balance vs 54,000 3-step / 0 shortfall)
│   └── real/catalogue.json   # Real Sri Lankan IT offerings (SLIATE, UCSC, UoM, UNIVOTEC, VTA) with evidence status
├── architecture.md           # Practical + Winning Edition Architecture Specification
├── agents.md                 # Specifications for the 4 Lens Walkers, BranchSearchWalker & PlannerAgent
├── rules.md                  # Jac v0.16.7 Syntax, OSP, MTP & Engineering Rules
├── run_project.bat           # One-click Windows launcher
├── run_project.ps1           # PowerShell launcher
└── requirements.txt          # jaclang==0.16.7
```

### Commands
```powershell
# Run automated verification test suite (T01, T02, T03, T05, T08, T11, T13)
jac run main.jac

# Start Jac REST API server on port 8000
jac start main.jac --port 8000
```

---

## 4. Jac v0.16.7 Golden Syntax Rules

- **Booleans & Null**: Always uppercase `True`, `False`, `None` in `.jac` code.
- **Entry Points**: Always use `with entry { ... }` or `with entry:__main__ { ... }`.
- **Attribute Ordering**: Non-default `has` fields MUST precede default `has` fields in every `node`, `edge`, `walker`, or `obj`.
- **Graph Operators**:
  - Create node: `created = here ++> CourseOffering(...);`
  - Connect edge: `src +>: ProgressesTo(...) :+> dst;`
  - Traverse edge: `[o ->:ProgressesTo:->](?:CourseOffering)`
  - Filter nodes: `[-->](?:CourseOffering, catalogue_mode == self.mode)`
  - Spawn walker: `w = root spawn plan_pathways(...);`
  - Read report: `w.reports[-1]`
