# JAC PROGRAMMING LANGUAGE - LLM GROUNDING & CODE GENERATION RULES

This document serves as the single source of truth for generating valid, error-free Jac code.

## 1. Golden Syntax Rules & Common Hallucinations to AVOID
- **Booleans**: Always uppercase `True` and `False`. `true` and `false` will fail at runtime.
- **Entry Points**: Always use `with entry { ... }`. Never bare `entry { }` or top-level statements.
- **Top-Level Scope**: Only declarations (nodes, edges, walkers, functions, globals) are allowed at top level. All executable statements must be in functions or `with entry { }`.
- **Node Attribute Ordering**: Non-default attributes MUST precede default attributes in archetypes.
  - RIGHT: `has name: str; has active: bool = True;`
  - WRONG: `has active: bool = True; has name: str;`
- **Imports**:
  - Python stdlib: `import from os { path }` or `import os;` (DO NOT use `import:py from ...`).
  - Selective import: NO trailing semicolon after the curly brace `}`.
- **Control Flow**:
  - Match/Case: `case 1: print("one");` (colon after case, NO braces per case).
  - Conditionals: No ternary `?:`. Use `result = ("val1") if cond else ("val2");`.
  - Loops: `for item in items { }` or `for (i, x) in enumerate(items) { }`.
  - Exception Handling: `try { } except Exception as e { } finally { }` (NEVER `catch`).
  - No `pass` keyword: use `{}` or comments.
- **Functions & Lambdas**:
  - Lambda expression: `lambda x: int -> int : x * 2;`
  - Lambda block: `lambda x: int -> int { return x * 2; };`
  - Pipe operator: `"hello" |> print;`
  - f-strings: `f"Value: {x}"` (server-side).

## 2. Object-Spatial Programming (OSP)
- **Archetypes**:
  - Node: `node NodeName { has attr: type; }`
  - Edge: `edge EdgeName { has weight: float = 1.0; }`
  - Walker: `walker WalkerName { has state: type; can action with NodeName entry; }`
- **Graph Connection Operators**:
  - Connect node to node: `root ++> NodeName();`
  - Connect with custom typed edge: `nodeA +>: EdgeName(weight=2.0) :+> nodeB;`
  - Disconnect: `nodeA del--> nodeB;`
- **Graph Traversal Operators**:
  - Untyped forward lookup: `[-->]`
  - Untyped backward lookup: `[<--]`
  - Typed forward: `[->:EdgeName:->]`
  - Filtering by type: `[-->](?:NodeName)`
  - Filtering by attribute: `[-->](?:NodeName, attr == value)`
  - Chained typed: `[->:Edge1:->->:Edge2:->]`
- **Walker Lifecycle & Navigation**:
  - `visit [-->];` - Queues neighbors to be visited.
  - `here` - Refers to the current node being visited.
  - `report value;` - Emits a result into `response.reports`.
  - `disengage;` - Aborts further traversal immediately.
  - Spawning: `result = root spawn MyWalker(param="val");`
  - Accessing results: `result.reports[0]` (NEVER `result.returns`).

## 3. Meaning-Typed Programming (MTP) with `by llm()`
- Native LLM integration with strict type contracts:
  ```jac
  import from byllm { Model }
  glob llm: Model = Model(model_name="gpt-4o");

  enum RiskLevel { LOW, MEDIUM, HIGH, CRITICAL }

  sem analyze_risk = "Analyze the incident details and classify risk level with rationale.";
  def analyze_risk(description: str, metrics: dict) -> RiskLevel by llm();
  ```
- No prompt boilerplate needed; type signatures and docstrings/semantic strings define the contract.

## 4. API & Server Deployment
- Server command: `jac start main.jac` (NEVER `jac serve`).
- All walkers automatically register as `POST /walker/<WalkerName>`.
- Public endpoints: Declare with `:pub`, e.g., `walker :pub ListItems { }`.
- Request parameters: Any non-default `has` field in a walker becomes a required JSON body parameter.
- Walkers do NOT read HTTP headers or cookies directly; pass all data via body parameters.
- Response structure: `{"ok": true, "type": "response", "data": {"result": ..., "reports": [...]}}`.

## 5. Client / Frontend Architecture (cl{} Blocks)
- Hybrid full-stack: Server graph/walkers + `cl{}` block for reactive UI in a single file or `.cl.jac`.
- Client component: `def:pub app() -> JsxElement { ... }`
- State: `has count: int = 0;` inside components compiles to reactive React state.
- Calling backend walkers: `result = root spawn MyWalker();` inside `async def` or lifecycle functions.
- JSX conventions:
  - `className="x"` (NOT `class="x"`).
  - Iteration: `{[<div key={i}>{x}</div> for (i, x) in enumerate(items)]}`.
  - JS string functions: use `String(x)`, `items.length`, etc.
