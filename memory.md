# 🧠 MEMORY & CONTEXT TRACKER - UNIPATH LK

## 🏆 Event Identity & Official Hackathon Rules
- **Event**: AI Hackathon 2026 – Powered by Jaseci Labs
- **Date & Location**: Saturday, 17 October 2026 | 8:00 AM – 8:00 PM | Measurements Laboratory, Dept. of Electrical Engineering, University of Moratuwa.
- **Official Hacking Time**: 9:30 AM – 5:30 PM (Strict submission cutoff: 5:30 PM sharp). Late submissions disqualified.
- **Team**: 3 members per team.
- **Prizes**: $1,000 Total ($500 for 1st, $300 for 2nd, $200 for 3rd; Top 6 pitch on stage after 5:30 PM).

---

## ⚖️ Hackathon Compliance Checklist (Non-Negotiable)
1. **≥ 80% Jac Code Rule**: The core engine, graph topology, walkers, and agent logic MUST be in native Jac (`.jac`).
2. **Object-Spatial Programming (OSP)**: Genuine use of Nodes, Edges, Walkers, graph traversal (`[-->]`, `[->:Edge:->]`), and walker dispatch (`root spawn`).
3. **Meaning-Typed Programming (MTP)**: Genuine use of `by llm()` with typed schemas/enums for LLM decision-making.
4. **All Coding During Hacking Hours**: Brainstorming and architecture docs allowed prior to hacking; repos are audited for commit timestamps.
5. **Final Deliverables due at 5:30 PM**:
   - GitHub Repository URL (≥ 80% Jac).
   - Starred Jac repository (`https://github.com/jaseci-labs/jac`).
   - Demo video of the working product.
   - Pitch deck presentation.
   - Written description explaining how Jac & Jaseci tools were used.
   - Sandbox deployment on Jac Hammer (`https://jachammer.ai`).

---

## 🎯 Chosen Product: UniPath LK
- **Concept**: Post-A/L Higher Education Alternative Pathway Navigator.
- **The Problem in Sri Lanka**: Over 300,000 students sit G.C.E. Advanced Level exams annually; fewer than 45,000 gain admission to state universities through Z-Score cutoffs. Over 250,000 students are stranded without clear, trustworthy guidance on alternative higher education pathways, private degrees, NVQ/SLQF frameworks, foreign top-ups, and the government Interest-Free Student Loan Scheme (IFSLS). Unaccredited institutes exploit this confusion.
- **The Jac Solution**: A multi-agent graph navigation engine. Higher education in Sri Lanka is fundamentally an Object-Spatial Graph (Streams → Z-Scores → NVQ/Diplomas → SLQF Level 4/5/6 Degrees → IFSLS Eligibility → Job Roles).
- **The 4 Agentic Mechanics**:
  1. **Spatial Blackboard**: Nodes hold `deliberation_board` where walkers write `AgentCritique` objects without message passing.
  2. **Dynamic Graph Metamorphosis**: `BridgeSynthesizer` uses `by llm(method="Reasoning")` to spawn synthetic nodes (`here ++> ...`) and bridge edges live into the graph.
  3. **Ghost Simulation**: `GhostWalker` projects 4 years ahead with economic shocks (inflation, transport, delays) computing Pathway Resilience Score.
  4. **Spatial Dead-End Backtracking**: `visit [<--]` backtracking to junctions.
- **The 3 Winning Features**:
  1. **Gap Finder (`GapAnalyzerWalker`)**: Current state vs Career Goal gap analysis.
  2. **Minimum Change Finder**: Sensitivity analysis ("+LKR 4,500 budget" or "Home commute" unlocks path).
  3. **Action Plan Generator**: 5-step concrete checklist for tomorrow morning.

---

## 🛠️ Technology Stack & Environment
- **Core Engine**: Jac Language v0.16.7 (Python 3.14.6 AMD64 runtime).
- **Architecture**:
  - Backend: Jac Walkers exposed via `jac start main.jac` (REST API).
  - Graph Topology: In-memory & persistent Jac Object-Spatial graph.
  - LLM Integration: `by llm()` with meaning-typed signatures for reasoning.
  - Frontend: Responsive Web UI / Jac client (`cl{}`) / Jac Hammer sandbox.
