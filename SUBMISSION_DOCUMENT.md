# 📝 Official Hackathon Submission Document — UniPath LK

> **Event**: AI Hackathon 2026 Sri Lanka (University of Moratuwa & Jaseci Labs)  
> **Team Repository**: [https://github.com/madukamalruk/AI-Hackathon-2026-V1.git](https://github.com/madukamalruk/AI-Hackathon-2026-V1.git)  
> **Jac Compliance**: ≥ 80% Native Jac Code (`main.jac`)

---

## 1. Project Title & Tagline
- **Project Title**: **UniPath LK**
- **Tagline**: *Post-A/L Higher Education Alternative Pathway Navigator powered by a Council of Walkers in Jac*

---

## 2. Executive Summary & The Sri Lankan Problem
In Sri Lanka, approximately 300,000 students sit the G.C.E. Advanced Level (A/L) examinations annually. Only ~42,000–45,000 gain admission to state universities through Z-Score cutoffs. **Over 250,000 qualified students are stranded every year** without clear, trustworthy guidance on alternative higher education pathways (SLIATE, UCSC BIT, UNIVOTEC, NVQ ladders, Non-State degree awarding institutes, and the government Interest-Free Student Loan Scheme - IFSLS). Middle-income families fall prey to unaccredited degree mills or predatory fees, unaware of state-backed lateral transfers or cost-saving progression models.

---

## 3. The Jac Solution: Object-Spatial Intelligence
UniPath LK rejects shallow if-else filtering. Instead, it models the Sri Lankan tertiary education ecosystem as an accredited **Object-Spatial Graph** where autonomous **Walkers** deliberate on a **Spatial Blackboard**, perform **Dynamic Graph Metamorphosis**, and project 4 years into the future using a **Ghost Simulation**:

1. **Spatial Blackboard (`deliberation_board`)**: Walkers visit graph nodes and write typed `AgentCritique` objects directly onto `node InstituteCourse`.
2. **Dynamic Graph Metamorphosis**: When a student is deadlocked (state university cutoff missed + private campus cash budget insufficient), `BridgeSynthesizer` dynamically spawns a synthetic course node (`SYNTH-SLIATE-BIT-BRIDGE`) and lateral bridge edge (`BridgePathway`) live into the graph topology at runtime (`here ++> ...`).
3. **Evidence-Backed Edges**: Transitions between institutions carry formal legal citations (`source_id` from UGC Circulars, Government Gazettes, TVEC NVQ framework).
4. **2-Stage Scoring**: Hard constraints (minimum passes, accreditation) are filtered via a Feasibility Binary Gate, followed by Multi-Objective Preference Ranking (Lowest Cost, Fastest/IFSLS, Best Work-Study Fit).
5. **Ghost Simulation (`GhostWalker`)**: Projects 4 years ahead, testing pathways against real Sri Lankan economic shocks (15% inflation, +40% bus fare hike, 6-month national exam delay, Year 2 internship income) to output a **Pathway Resilience Score (0–100%)**.
6. **The 3 Winning Features**:
   - **Gap Finder (`GapAnalyzerWalker`)**: Identifies qualification and credit gaps between current student status and target career.
   - **Minimum Change Finder**: Calculates the exact minimal constraint shift (+LKR 4,500/mo or home commute) that turns red rejected nodes into green viable nodes.
   - **Action Plan Generator**: Produces a 5-step concrete actionable checklist for tomorrow morning.

---

## 4. How Jac & Jaseci Tools Were Used
- **Native Jac Constructs**: `node InstituteCourse`, `edge BridgePathway`, `obj AgentCritique`, `obj Pathway`.
- **Walker Archetypes**: `SeedGraph`, `AspirationScout`, `FiscalSurvivalGuard`, `SLQFGatekeeper`, `BridgeSynthesizer`, `PathwayEvaluator`, `GhostWalker`, `GapAnalyzerWalker`, `MinimumChangeFinder`, `ActionPlanGenerator`, `RunPathwayCouncil`.
- **Graph Mutation & Traversal**: Native `[-->]`, `[-->](?:InstituteCourse)`, and runtime mutation via `here ++> InstituteCourse(...)` and `+>: BridgePathway(...) :+>`.
- **REST Service**: Exposed seamlessly via `jac start main.jac --port 8000` for public HTTP POST walker endpoints.
- **Meaning-Typed AI**: Reasoning and lateral bridge synthesis via `by llm()`.

---

## 5. Live Links & Deliverables Checklist
- [x] **GitHub Repository**: [https://github.com/madukamalruk/AI-Hackathon-2026-V1.git](https://github.com/madukamalruk/AI-Hackathon-2026-V1.git)
- [x] **Starred Jac Repo**: [https://github.com/jaseci-labs/jac](https://github.com/jaseci-labs/jac)
- [ ] **Jac Hammer Sandbox URL**: [Insert your Jac Hammer Live URL here]
- [ ] **Demo Video URL (YouTube / Loom)**: [Insert video URL here]
