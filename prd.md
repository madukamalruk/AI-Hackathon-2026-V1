# 📄 Product Requirements Document (PRD) — UniPath LK

## 1. Product Title & Tagline
- **Title**: **UniPath LK**
- **Tagline**: *Post-A/L Higher Education Alternative Pathway Navigator*
- **Target Event**: AI Hackathon 2026 (Jaseci Labs / University of Moratuwa)

---

## 2. Problem Statement (Sri Lankan Context)
Every year in Sri Lanka:
1. **The Bottleneck**: ~300,000 students sit the G.C.E. Advanced Level (A/L) examinations. Only ~42,000–45,000 gain admission to state universities based on district quotas and Z-score cutoffs.
2. **The Vacuum**: Over 250,000 qualified students are left stranded without transparent, objective guidance on alternative higher education pathways (Non-State universities, External degrees like BIT/BCS, HNDs, SLQF Levels, NVQ ladders).
3. **Financial Misdirection**: Middle-income families fall prey to unaccredited degree mills or predatory fees, unaware of state-backed initiatives like the Interest-Free Student Loan Scheme (IFSLS) from the Ministry of Higher Education, or cost-saving lateral transfer models (e.g., SLIATE HND → 1-year Top-up degree).
4. **Lack of Personalization**: Existing options are either aggressive private institute advertisements or static PDF handbooks. No tool models the student's personal constraints (budget, district, AL stream, career ambitions, living costs) against a dynamic qualification topology.

---

## 3. Product Vision & Value Proposition
**UniPath LK** is an AI-native educational graph navigator built entirely in **Jac**. It models the Sri Lankan tertiary education ecosystem as an Object-Spatial Graph where autonomous Walkers explore, evaluate, and debate viable alternative pathways for a student based on:
- Academic stream (Physical Science, Bio Science, Commerce, Technology, Arts) & Z-score.
- Financial reality (Cash budget, IFSLS eligibility, monthly living expenses).
- Accreditation standards (SLQF Level 5, 6, 7 and TVEC NVQ equivalence).
- Career aspiration & market demand.

---

## 4. User Personas
### Persona 1: Dinuka (A/L Physical Science Student, Matara District)
- **Profile**: 3 S's in Maths stream, missed state engineering cutoff (Z-score 0.82). Family budget is tight (< LKR 600,000).
- **Goal**: Wants a software engineering career without bankrupting his family.
- **Outcome via UniPath LK**: Discovers UCSC External BIT or SLIATE HNDIT + top-up option eligible for IFSLS, saving LKR 2.5 Million compared to private campus upfront tuition.

### Persona 2: Kaveesha (A/L Bio Science Student, Gampaha District)
- **Profile**: 2 C's and an S in Bio, missed MBBS/BDS cutoff. Budget LKR 1.8M.
- **Goal**: Biomedical science or Biotechnology degree with genuine research or industry placement.
- **Outcome via UniPath LK**: Mapped to Ministry-accredited Non-State University degrees with SLQF Level 6 certification and industrial internship links.

---

## 5. Functional Requirements
### FR-1: Student Profile Intake
- Capture A/L Stream, Subjects, Grades (A, B, C, S, F), District, Max Total Budget, and Target Career / Sector.

### FR-2: Object-Spatial Qualification Graph
- Model Nodes: `StudentProfile`, `Aspiration`, `AcademicStream`, `Institution`, `Program` (with SLQF level, duration, fees, accreditation), `CareerPathway`.
- Model Edges: `QualifiesFor`, `RequiresBudget`, `LateralTransfer`, `LeadsToCareer`.

### FR-3: The "Council of Walkers" & 4 Agentic Mechanics
- **Walker 1: AspirationScout**: Explores graph nodes matching the student's career dream and minimum academic thresholds.
- **Walker 2: FiscalSurvivalGuard**: Evaluates upfront tuition, monthly living expenses (Colombo boarding vs outstation vs home commute), and calculates IFSLS loan entitlement (up to LKR 1.5M tuition + 300k stipend).
- **Walker 3: SLQFGatekeeper**: Enforces TVEC and UGC regulatory compliance (SLQF Level 4 HND vs Level 5/6 Bachelors) and prunes unaccredited degree mills.
- **Walker 4: BridgeSynthesizer (`by llm(method="Reasoning")`)**: The Hero AI Brain that detects deadlocks and performs **Dynamic Graph Metamorphosis** by injecting synthetic nodes and lateral bridge edges live into the graph (e.g. SLIATE HNDIT -> NVQ 6 -> UCSC BIT 2nd year).
- **Walker 5: GhostWalker (Scenario Stress Tester)**: Runs **Ghost Simulation** 4 years into the future simulating realistic shocks (15% inflation, +40% bus fare, 6-month exam delay, Year 2 internship +50k) to output a **Pathway Resilience Score** (0–100%).

### 4 Core Agentic Mechanics:
1. **Spatial Blackboard**: Nodes hold `deliberation_board: list[AgentCritique] = [];` where walkers post typed evaluations without out-of-band message passing.
2. **Dynamic Graph Metamorphosis**: Runtime synthesis of `InstituteCourse` nodes and `BridgePathway` edges directly into the graph topology (`here ++> ...`).
3. **Ghost Simulation**: Deep future trajectory projection with economic shocks calculating resilience scores.
4. **Spatial Dead-End Backtracking**: Jac `visit [<--]` backtracking to junctions to explore alternative regional or modular options.

### FR-4: The 3 Winning Product Features
- **Feature 1: Gap Finder (`GapAnalyzerWalker`)**: Visually contrasts current student standing (Z-score, stream, budget) against the target career destination node, isolating missing credits and prerequisite qualifications.
- **Feature 2: Minimum Change Finder**: Computes the exact minimum constraint delta (e.g. "+LKR 4,500/mo budget" or "Home commute instead of boarding") that instantly flips a red/rejected pathway to active green.
- **Feature 3: Action Plan Generator (`ActionPlanGeneratorAgent`)**: Automatically outputs a 5-step concrete actionable checklist for tomorrow morning (download application, prepare Grama Niladhari cert, track exam registration, upfront cost breakdown).

### FR-5: Real Sri Lankan Higher Education Data Spectrum
- **IFSLS 16 Non-State Universities (DAIs)**: SLIIT, NSBM, CINEC, SLTC, ICBT, ESOFT, Horizon, KIU, Saegis, Aquinas, IChemC, BCI, etc.
- **National Colleges of Education (Vidya Peeta - NCoE)**: 100% free residential diplomas with guaranteed government teaching appointments.
- **Bilateral Foreign Scholarships (MOHE)**: Full/partial scholarships to China (CSC), Russia, India (ICCR), Cuba, Hungary, Japan (MEXT).
- **Free State Technical Institutes**: SLIATE (HNDE, HNDIT across 16 centers), ITUM NDT (Moratuwa/Diyagama), German Tech (CGTTI).
- **External & Work-Study Degrees**: UCSC BIT (under LKR 300k total), UNIVOTEC B.Tech (lateral entry for NVQ 5/6), Open University (OUSL).
- **Vocational TVEC Ladder**: NVQ Level 4 -> NVQ Level 5/6 Diploma -> UNIVOTEC B.Tech Degree.

---

## 6. Output & Report Specification
- Structured JSON and visual report returning:
  - Pathway name and qualification milestone sequence.
  - Cost breakdown (Tuition, Upfront Admission, Monthly Living Burn Rate, IFSLS Loan offset).
  - SLQF & NVQ Level equivalence and UGC accreditation status.
  - Ghost Simulation Resilience Score (%) and vulnerability warnings.
  - Minimum Change recommendation to unlock alternative paths.
  - 5-step tomorrow-morning Action Checklist in conversational Sinhala + English terms.

---

## 7. Non-Functional Requirements
- **Performance**: Graph search & walker execution within 2 seconds.
- **Codebase Compliance**: ≥ 80% written in Jac.
- **Robustness**: 100% type-safe Meaning-Typed execution with strict fallback if LLM is unavailable.
- **Deployment**: Seamless single-command startup via `jac start main.jac` and Jac Hammer compatibility.

