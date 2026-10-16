# 📋 Time-Boxed Execution Tasks — UniPath LK

> **දවසේ කාලසටහන**: 2026 ඔක්තෝබර් 17 (සෙනසුරාදා) | 09:00 AM – 05:30 PM (Deadline strict!)  
> **නිරීක්ෂණය**: සෑම කාර්යයක්ම අවසන් වූ පසු `[x]` ලෙස සලකුණු කර, `test` command එක run කර තහවුරු කළ යුතුය.

---

## Phase 1: Workspace Setup & Core Knowledge Graph (09:00 AM – 10:30 AM)
- [x] **Task 1.1**: Antigravity IDE / Terminal තුළ `jac --version` පරීක්ෂා කර පරිසරය තහවුරු කිරීම. (Done: Jac v0.16.7 verified).
- [ ] **Task 1.2**: `main.jac` ගොනුව නිර්මාණය කර Core Data Archetypes ලිවීම:
  - `enum SLQFLevel` (Level 3 - Diploma, Level 4 - HND, Level 5 - Bachelor, Level 6 - Honours).
  - `node InstituteCourse` (name, institution, slqf_level, nvq_level, upfront_fee, monthly_tuition, location, is_ifsls_eligible, source_url).
  - `edge BridgePathway` (from_course, to_course, credit_transfer_ratio, is_verified, notes).
- [ ] **Task 1.3**: `walker SeedCourseCatalogue` නිර්මාණය කර ශ්රී ලංකාවේ IT පාඨමාලා 12ක් (UCSC BIT, Moratuwa NDT, SLIATE HNDIT, UNIVOTEC, SLIIT, NSBM) spawn කිරීම.
- [ ] **Task 1.4**: `jac run main.jac` මඟින් graph එක කිසිදු error එකක් නැතුව spawn වන බව terminal එකෙන් තහවුරු කිරීම.

---

## Phase 2: Spatial Blackboard, Council of Walkers & Metamorphosis (10:30 AM – 01:00 PM)
- [ ] **Task 2.1**: Spatial Blackboard Architecture:
  - `obj AgentCritique` (agent_name, is_viable, confidence, reason, financial_gap_lkr).
  - `deliberation_board: list[AgentCritique]` attached to `InstituteCourse` nodes.
- [ ] **Task 2.2**: `walker AspirationScout` & `EligibilityCheckerWalker`:
  - Stream & Z-score filtering against career aspirations.
- [ ] **Task 2.3**: `walker FiscalSurvivalGuard`:
  - Upfront admission + (Monthly living * Duration) with Colombo vs Outstation vs Home commute.
  - IFSLS Loan offset deduction (up to LKR 1.5M tuition + 300k stipend).
  - Writes typed `AgentCritique` to node `deliberation_board`.
- [ ] **Task 2.4**: `walker SLQFGatekeeper`:
  - TVEC NVQ 5/6 and UGC SLQF Level 4/5/6 accreditation validation on Blackboard.
- [ ] **Task 2.5**: `walker BridgeSynthesizer` (Dynamic Graph Metamorphosis):
  - On deadlock, calls `by llm(method="Reasoning")` to inject synthetic `InstituteCourse` node (`here ++> ...`) and `BridgePathway` edge into live graph.

---

## Phase 3: AI Brain, Ghost Simulation & Winning Features (01:00 PM – 02:30 PM)
- [ ] **Task 3.1**: Meaning-Typed LLM Synthesis (`by llm(method="Reasoning")`):
  - Outputs 3 distinct pillars (Direct Non-State via IFSLS, Free Lateral Ladder SLIATE -> BIT, External Work-Study).
- [ ] **Task 3.2**: `walker GhostWalker` (4-Year Future Shock Simulation):
  - Simulates 3 shocks: Inflation/transport hike (+40%), Exam delay (+6 mo), Year 2 internship (+50k LKR/mo).
  - Calculates Pathway Resilience Score (0-100%).
- [ ] **Task 3.3**: The 3 Winning Features:
  - `GapAnalyzerWalker`: Visual/semantic discrepancy between student standing and career goal.
  - `MinimumChangeFinder`: Minimum budget increase or home commute sensitivity unlocking red nodes.
  - `ActionPlanGenerator`: 5-step concrete actionable checklist for tomorrow morning.
- [ ] **Task 3.4**: Terminal verification: Run full council and verify JSON output.

---

## Phase 4: Full-Stack UI & Jac Hammer Deployment (02:30 PM – 03:30 PM)
- [ ] **Task 4.1**: Interactive Dashboard නිර්මාණය කිරීම (Streamlit හෝ Jac native `cl{}` UI):
  - වම් පස: Student inputs (Z-score slider, District dropdown, Budget input).
  - මැද: Interactive Graph Representation (Visualizing nodes and pathways).
  - දකුණු පස: Top 3 Recommended Pathways Card View (with Sinhala rationale).
- [ ] **Task 4.2**: GitHub Repo එකට code push කිරීම (Commit timestamp verified).
- [ ] **Task 4.3**: Jac Hammer (`https://jachammer.ai`) sandbox එකට repo එක connect කර live URL එක ලබාගැනීම.

---

## Phase 5: Feature Freeze & Demo Video Production (03:30 PM – 05:00 PM)
- [ ] **Task 5.1 (HARD FREEZE)**: කිසිදු අලුත් feature එකක් නොලියා කෝඩින් නතර කිරීම.
- [ ] **Task 5.2**: Test cases 3ක් (Galle student, Colombo student, Jaffna student) run කර live demo එකක් සූදානම් කිරීම.
- [ ] **Task 5.3**: Loom / OBS මඟින් විනාඩි 2.5 ක High-Impact Demo Video එකක් record කිරීම:
  - 0:00 - 0:30: Problem Hook & Sri Lankan context.
  - 0:30 - 01:45: Live working demo (Z-score 1.12 Galle student input, Council of Walkers execution, 3 Pathways generated).
  - 01:45 - 02:15: Realistic 3-Scenario Stress Test visualization.
  - 02:15 - 02:45: Jac code under the hood (`main.jac`, nodes, walkers, `by llm()`).
  - 02:45 - 03:00: Jac Hammer live deployment & closing.
- [ ] **Task 5.4**: Demo video එක YouTube / Google Drive / Loom එකට upload කර public view link එකක් ලබාගැනීම.

---

## Phase 6: Final Submission Window (05:00 PM – 05:15 PM)
- [ ] **Task 6.1**: Official Submission Form එක විවෘත කිරීම (5:30 PM ට පෙර!).
- [ ] **Task 6.2**: GitHub Repo Link ඇතුළත් කිරීම (≥ 80% Jac code verified).
- [ ] **Task 6.3**: Official Jac repo එක Star ⭐ කර ඇති බව තහවුරු කිරීම (`github.com/jaseci-labs/jac`).
- [ ] **Task 6.4**: Demo Video Link සහ Jac Hammer Live URL ඇතුළත් කිරීම.
- [ ] **Task 6.5**: Written Description එක (Jac භාවිතය පැහැදිලි කරමින්) copy-paste කර Submit කිරීම.

---

## Phase 7: Stage Pitch Deck (06:00 PM – 07:30 PM)
- [ ] **Task 7.1**: Top 6 කණ්ඩායම් අතරට තේරුණහොත් stage එකේ ඉදිරිපත් කිරීමට Slide 5ක pitch deck එක ලෑස්ති කරගැනීම.
