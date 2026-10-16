# 🎓 UniPath LK — Post-A/L Higher Education Alternative Pathway Navigator

> **AI Hackathon 2026 Sri Lanka** | Powered by Jaseci Labs & University of Moratuwa  
> Built with **Jac Language v0.16.7** (Object-Spatial Programming & Meaning-Typed AI)

---

## 🌟 The Sri Lankan Problem
Every year in Sri Lanka, ~300,000 students sit the G.C.E. Advanced Level (A/L) examinations. Only ~42,000 gain admission to state universities through Z-Score cutoffs. **Over 250,000 qualified students are left stranded** without transparent, objective guidance on alternative higher education pathways (SLIATE, UCSC BIT, UNIVOTEC, NVQ frameworks, Non-State university degrees, and the government Interest-Free Student Loan Scheme - IFSLS).

---

## 💡 The Solution: Council of Walkers in Jac
**UniPath LK** models the Sri Lankan tertiary education ecosystem as an accredited **Object-Spatial Graph**. When a student is caught in a deadlock (Z-score insufficient for state intake and family budget insufficient for direct private campus), autonomous **Walkers** debate on a **Spatial Blackboard**, and the **BridgeSynthesizer** performs **Dynamic Graph Metamorphosis** to inject accredited synthetic pathway nodes live into the graph topology.

### 🤖 The Walkers:
1. **`AspirationScout`**: Career ambition & academic eligibility explorer.
2. **`FiscalSurvivalGuard`**: Real-world living cost modeler (Colombo vs Outstation vs Home commute) & IFSLS state loan subsidizer.
3. **`SLQFGatekeeper`**: Regulatory compliance officer (UGC & TVEC SLQF 4/5/6 enforcement).
4. **`BridgeSynthesizer` (The Hero AI Brain)**: Dynamically synthesizes accredited lateral bridges (`by llm(method="Reasoning")`) and spawns synthetic nodes into the graph (`here ++> InstituteCourse(...)`).
5. **`PathwayEvaluator`**: End-to-end validator checking complete multi-year pathways, prerequisite transfer validity, and calendar overlaps.
6. **`GhostWalker`**: Future scenario stress tester simulating 4 years ahead (15% inflation, +40% bus fare, 6-mo delay, Year 2 internship) to calculate a **Pathway Resilience Score (0–100%)**.
7. **`GapAnalyzerWalker`**: Identifies structural credit and credential gaps between student status and target career.
8. **`MinimumChangeFinder`**: Calculates the minimum parameter delta (+LKR 4,500 budget or home commute) needed to unlock red options.
9. **`ActionPlanGenerator`**: Outputs a 5-step concrete actionable checklist for tomorrow morning.

---

## 🏗️ System Architecture & Mechanics
- **Spatial Blackboard**: Nodes hold `deliberation_board: list[AgentCritique]`.
- **Dynamic Graph Metamorphosis**: Real-time runtime node/edge injection.
- **Evidence-Backed Edges**: Transitions backed by UGC Circulars, Gazette regulations, and TVEC equivalence.
- **2-Stage Scoring**: Binary Feasibility Gate followed by Multi-Objective Preference Ranking (Lowest Cost, Fastest, Best Fit).
- **Structured Decision Log**: Transparent audit trail of all agent decisions for judges.

---

## 📂 Repository Structure
```text
├── memory.md          # Hackathon rules, compliance tracker, judging criteria
├── prd.md             # Product Requirements Document
├── architecture.md    # Object-Spatial Architecture, Sequence Diagrams, Node Archetypes
├── agents.md          # Multi-Agent Walker specifications & abilities
├── skills.md          # Real Sri Lankan Data, SLQF/NVQ matrices, 8 test profiles
├── decisions.md       # ADR 001 to ADR 014 (Architectural Decision Records)
├── tasks.md           # Time-boxed execution roadmap (Phases 1-7)
├── CLAUDE.md          # Jac v0.16.7 syntax reference & guardrails
└── reference_materials/ # Official PDFs, agendas, and background research
```

---

## 🚀 Getting Started

### Prerequisites
- Python 3.12+ (or Python 3.14)
- Jac Language 0.16.7 (`pip install jaclang`)

### Running Locally
```powershell
# Run the test graph and council of walkers
jac run main.jac

# Start the Jac backend daemon
jac start main.jac --port 8000
```
