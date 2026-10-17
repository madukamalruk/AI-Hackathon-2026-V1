# 📜 Jac Language (v0.16.7) & UniPath LK — Complete Rules & Developer Guide (`rules.md`)

This document serves as the **Single Source of Truth** for developing, extending, and running the **UniPath LK (Council of Walkers)** project in **Jac v0.16.7**. Keep this file in the root directory so both developers and AI coding assistants (Claude, Cursor, Antigravity, Copilot) follow exact Jac v0.16.7 syntax and architectural rules.

---

## 1. Golden Jac v0.16.7 Syntax Rules (CRITICAL)

### 1.1 Booleans & Nulls
- **Always** use Python-style capitalized `True`, `False`, and `None`.
- Never use lowercase `true`, `false`, or `null` inside `.jac` server code.

### 1.2 Top-Level Scope & Entry Points
- Only declarations (`node`, `edge`, `walker`, `obj`, `enum`, `def`, `glob`, `import`) are permitted at the top level of a `.jac` file.
- Executable code must live inside `with entry { ... }` or `with entry:__main__ { ... }` or inside walker/function bodies.
- **Never** write bare `entry { ... }` without `with`.

### 1.3 Archetype Attribute Ordering (`has` Fields)
- **Non-default attributes MUST always come before default attributes** in any `node`, `edge`, `walker`, or `obj`.
  ```jac
  # ✅ CORRECT
  node Course {
      has code: str,
          name: str;
      has is_active: bool = True,
          credits: int = 3;
  }

  # ❌ WRONG (Syntax/Compile Error in Jac)
  node Course {
      has is_active: bool = True;
      has code: str;
  }
  ```

### 1.4 Imports
- Standard Python imports:
  ```jac
  import sys;
  import from os { path }
  ```
- **Never** use deprecated `import:py` syntax.
- Do **not** put a semicolon after closing curly brace `}` on selective imports (`import from module { Symbol }`).

### 1.5 Control Flow & Expressions
- **Conditionals**: `if cond { ... } elif cond2 { ... } else { ... }`
- **Inline Conditional (Ternary)**: Use Python-style `(val1) if cond else (val2)`. Never use `cond ? val1 : val2`.
- **Loops**: `for item in items { ... }` or `for (idx, item) in enumerate(items) { ... }`.
- **Exceptions**: `try { ... } except Exception as e { ... } finally { ... }` (Never `catch`).
- **No `pass` keyword**: Use an empty block `{}` instead of `pass`.

---

## 2. Object-Spatial Programming (OSP) Rules

### 2.1 Defining Graph Archetypes
- **`obj`**: Standard data class (not attached to graph edges).
- **`node`**: Graph vertex capable of holding state and a Spatial Blackboard (`deliberation_board`).
- **`edge`**: Directed/undirected typed connection holding transition metadata (e.g., `BridgePathway`).
- **`walker`**: Autonomous mobile agent that traverses nodes and edges (`can ability_name with NodeType entry { ... }`).

### 2.2 Graph Construction & Metamorphosis Operators
- **Create & Connect Node from current node (`here` or `root`)**:
  ```jac
  new_nodes = here ++> InstituteCourse(code="SLIATE-HNDIT", ...);
  ```
- **Connect Two Nodes with a Typed Edge**:
  ```jac
  node_a +>: BridgePathway(credits_transferred=60, is_synthetic=True) :+> node_b;
  ```
- **Delete Connection**:
  ```jac
  node_a del--> node_b;
  ```

### 2.3 Graph Traversal & Filtering Operators
- All outgoing nodes: `[-->]`
- Filter by node archetype: `[-->](?:InstituteCourse)`
- Filter by node attribute: `[-->](?:InstituteCourse, node_status == "viable_green")`
- Traverse via specific edge type: `[->:BridgePathway:->]`
- Queue nodes for walker visit: `visit [-->](?:InstituteCourse);`
- Stop walker immediately: `disengage;`

### 2.4 Spawning Walkers & Reading Reports
- Spawn a walker on `root` or any specific node `n`:
  ```jac
  w = root spawn RunPathwayCouncil(student_name="Dinuka", z_score=1.12);
  ```
- Emit data to API / caller inside walker:
  ```jac
  report {"status": "success", "data": result};
  ```
- Read reported output in CLI/test blocks:
  ```jac
  output = w.reports[-1]; # Always use .reports, NEVER .returns
  ```

---

## 3. Meaning-Typed Programming (MTP) — `by llm()` Rules

When connecting an LLM (`byllm` package) for dynamic reasoning:
```jac
import from byllm { Model }

glob llm: Model = Model(model_name="gpt-4o");

sem synthesize_bridge = "Synthesize a valid Sri Lankan SLQF/NVQ lateral bridge pathway for a deadlocked student.";
def synthesize_bridge(stream: str, z_score: float, budget_lkr: float) -> str by llm();
```
- **Rule**: Always keep a deterministic fallback in `main.jac` so the project runs 100% offline even on machines without an OpenAI/Gemini API key configured.

---

## 4. UniPath LK Multi-Agent Architecture Rules (Council of Walkers)

1. **No Monolithic Prompt Chains**: All pathway discovery, financial auditing, regulatory verification, deadlock synthesis, and stress testing MUST be executed via specialized Walkers (`AspirationScout`, `FiscalSurvivalGuard`, `SLQFGatekeeper`, `BridgeSynthesizer`, `PathwayEvaluator`, `GhostWalker`, `GapAnalyzerWalker`, `MinimumChangeFinder`, `ActionPlanGenerator`).
2. **Spatial Blackboard Pattern**: `FiscalSurvivalGuard`, `SLQFGatekeeper`, and `BridgeSynthesizer` must write structured `AgentCritique` objects directly onto `here.deliberation_board` on each `InstituteCourse` node.
3. **Dynamic Graph Metamorphosis**: When a student hits an Educational Deadlock (Z-score below state university cutoff AND monthly budget below direct private university living+tuition cost), `BridgeSynthesizer` dynamically injects `SYNTH-SLIATE-BIT-BRIDGE` into the graph topology and connects it via `BridgePathway`.
4. **Zero Constraint Violations**: Every recommended pathway must pass the 2-Stage Feasibility Gate (Academic stream & passes + Financial monthly burn & upfront fee + SLQF/UGC verification).
5. **Windows UTF-8 Compatibility**: Because UniPath LK includes Sinhala explanations (`tradeoff_note_sinhala`, `impact_sinhala`), `sys.stdout` and `sys.stderr` must always be reconfigured to `utf-8` at startup so Windows PowerShell/CMD never raises a `charmap` encoding error.

---

## 5. Running & Testing Commands

### 5.1 Run CLI Verification Test
```powershell
jac run main.jac
```

### 5.2 Start Jac REST API Server
```powershell
jac start main.jac --port 8000
```
- Walkers marked with `:pub` (`SeedGraph`, `RunPathwayCouncil`, `GetTestProfiles`) are exposed at:
  - `POST http://localhost:8000/walker/RunPathwayCouncil`
  - `POST http://localhost:8000/walker/GetTestProfiles`
  - `POST http://localhost:8000/walker/SeedGraph`

### 5.3 Launch Interactive Frontend UI
Open `index.html` in any modern browser (or run `run_project.bat`). It automatically connects to `http://localhost:8000/walker/RunPathwayCouncil` if the Jac server is running, and includes a built-in synchronized simulation engine if opened standalone.
