# ⚖️ Architectural Decision Records (ADRs) — UniPath LK

මෙම ලේඛනයෙහි UniPath LK නිර්මාණයේදී ගනු ලැබූ සියලුම තාක්ෂණික තීරණ, විකල්පයන් (Alternatives), සහ ඒවා තෝරාගැනීමට හේතු (Rationale) වාර්තා කර ඇත.

---

## ADR 001: Object-Spatial Programming (Jac Graph) භාවිතය
- **තත්ත්වය (Context)**: ශ්රී ලංකාවේ උසස් අධ්යාපන පාඨමාලා, පිවිසුම් සුදුසුකම් (Prerequisites), ණය ක්රම, සහ රැකියා එකිනෙකට සම්බන්ධ වී ඇත්තේ සංකීර්ණ ජාලයක් (Network) ලෙසය.
- **තීරණය (Decision)**: සාම්ප්රදායික SQL/Relational Database හෝ Flat Prompting වෙනුවට Jac හි native **Object-Spatial Programming (OSP)** තෝරාගන්නා ලදී.
- **හේතුව (Rationale)**: 
  - `node` සහ `edge` මඟින් සැබෑ ලෝකයේ අධ්යාපනික මංසන්ධි නිරූපණය වේ.
  - `walker` මඟින් තීරණ ගැනීමේ logic එක දත්ත තිබෙන ස්ථානයටම ගමන් කරයි (Code moves to data).
  - Hackathon හි ≥ 80% Jac code කොන්දේසිය 100% ක් සපුරයි.

---

## ADR 002: Shared Course Graph එක සහ Student Planning Session එක වෙන් කිරීම (State Isolation)
- **තත්ත්වය (Context)**: මුල් ආකෘතියෙහි `deliberation_board` එක තබා තිබුණේ `InstituteCourse` (Shared Node) එක උඩය. මෙහිදී Student A වෙනුවෙන් ලියූ "Too expensive" සටහන Student B ගේ තීරණයටත් වැරදි ලෙස බලපෑම් කළේය (Shared State Pollution).
- **තීරණය (Decision)**: 
  - **Tier 1 (Course Catalogue)**: ආයතන සහ පාඨමාලා පිළිබඳ නිල කරුණු (Tuition, SLQF, Location) පමණක් අඩංගු Shared Static Graph එකක් ලෙස පවතී.
  - **Tier 2 (PlanningSession)**: සෑම ශිෂ්යයෙකුටම වෙනම `PlanningSession` node එකක් සහ session-specific subgraph එකක් නිර්මාණය වේ.
- **ප්රතිඵලය (Consequence)**: Multi-user concurrency වලදී දත්ත දූෂණය වීම (Data pollution) සහ memory leaks 100% ක් වැළකේ.

---

## ADR 003: LLM Hallucinations පාලනය සහ Verified Lateral Entry නීති පමණක් භාවිතය
- **තත්ත්වය (Context)**: AI එකට හිතුමතේ අලුත් pathways හදන්න දුනහොත්, ලංකාවේ විශ්වවිද්යාල අනුමත නොකරන ව්යාජ credit transfers (උදා: HNDE → UCSC BIT 2nd year) නිර්මාණය විය හැක.
- **තීරණය (Decision)**: 
  - AI (`by llm`) එකට අත්තනෝමතික transfers හැදීමට ඉඩ නොදේ.
  - රජයේ නිල ගැසට් සහ UGC/TVEC මඟින් තහවුරු කළ lateral entries පමණක් `BridgePathway` ලෙස Graph එකේ සම්බන්ධ කෙරේ.
  - යම් අලුත් සංයෝජනයක් යෝජනා වන්නේ නම්, එය "Needs Institutional Confirmation" ලේබලය සහිතව ඉදිරිපත් කෙරේ.
- **ප්රතිඵලය (Consequence)**: ශිෂ්යයන් නොමඟ යැවීම වැළකෙන අතර, විනිශ්චය මණ්ඩලයේ මොරටු ලෙක්චරර්ස්ලාට කිසිදු තාක්ෂණික හෝ නීතිමය දෝෂයක් පෙන්විය නොහැක.

---

## ADR 004: SLQF සහ NVQ රාමු නිවැරදිව වෙන් කිරීම
- **තත්ත්වය (Context)**: මුල් සටහන් වල Bachelor's උපාධිය SLQF Level 7 ලෙස වැරදියට සටහන් වී තිබුණි. තවද NVQ සහ SLQF පටලවා තිබුණි.
- **තීරණය (Decision)**: 
  - Bachelor's General = SLQF Level 5
  - Bachelor's Honours = SLQF Level 6
  - Higher Diploma = SLQF Level 4
  - `slqf_level` සහ `nvq_level` වෙන වෙනම attributes ලෙස Node එකේ තැබීම.

---

## ADR 005: Orchestrated Sequential Council (Race Conditions වැළැක්වීම)
- **තත්ත්වය (Context)**: Walkers 4 දෙනෙකු එකවර parallel ලෙස ධාවනය කළහොත්, මුදල් ගණනය කිරීමට පෙර AI Synthesizer එක අවසන් තීරණ ගැනීමට ඉඩ තිබුණි (Race condition).
- **තීරණය (Decision)**: 
  - `PathwayOrchestrator` walker එකක් මඟින් අනුපිළිවෙල පාලනය කරයි:
    1. `EligibilityCheckerWalker` (Academic filters)
    2. `CostAndFundingWalker` (Financial calculation)
    3. `AlternativeSynthesizer` (`by llm` decision engine)
    4. `ScenarioStressTester` (Robustness audit)

---

## ADR 006: සැබෑ මුදල් ප්රවාහය (Cash Flow) ආකෘතිකරණය කිරීම
- **තත්ත්වය (Context)**: "Part-time allowed" වූ පමණින් ශිෂ්යයෙකුට රැකියාවක් හෝ ආදායමක් සහතික නොවේ.
- **තීරණය (Decision)**: 
  - Course cost එක "වාර්ෂික ගාස්තුව ÷ 12" ලෙස නොගෙන, මුලින්ම ගෙවිය යුතු ලොකු මුදල (`upfront_admission_fee`) සහ මාසික ජීවන වියදම (`monthly_burn_rate`) වෙන් කර ගණනය කෙරේ.
  - IFSLS ණය මුදලින් ආවරණය වන ප්රමාණය නිවැරදිව අඩු කර පෙන්වයි.

---

## ADR 007: අතාර්කික සම්භාවිතා වෙනුවට Scenarios 3ක ආතති පරීක්ෂාව
- **තත්ත්වය (Context)**: "89% survival rate" වැනි අහඹු ප්රතිශත විනිශ්චයකරුවන් ප්රශ්න කරනු ඇත.
- **තීරණය (Decision)**: 
  - **Scenario A (Baseline)**: සාමාන්ය තත්ත්වය යටතේ වියදම.
  - **Scenario B (Inflation & Delay)**: බස් ගාස්තු +40% සහ විභාග මාස 6ක් ප්රමාද වීම.
  - **Scenario C (No External Job)**: අමතර රැකියා ආදායම් නොලැබුණහොත් වියදම.

---

## ADR 008: Scope Control — IT & Technology ක්ෂේත්රය කෙරෙහි පමණක් අවධානය යොමු කිරීම
- **තත්ත්වය (Context)**: පැය 6.5ක් තුළ මුළු ලංකාවේම සියලුම විෂය ධාරාවන් (Arts, Bio, Commerce) ආවරණය කිරීමට ගියහොත් data collection එක අසීරු වේ.
- **තීරණය (Decision)**: Hackathon MVP එක සඳහා **IT & Computing** ක්ෂේත්රය (UCSC BIT, Moratuwa NDT, SLIATE HNDIT, UNIVOTEC, SLIIT, NSBM) තෝරාගන්නා ලදී. මෙය ලංකාවේ ඉහළම රැකියා ඉල්ලුම සහ විකල්ප මාර්ග ඇති ක්ෂේත්රයයි.

---

## ADR 009: Spatial Blackboard Pattern (`deliberation_board` on Nodes)
- **තත්ත්වය (Context)**: බහු ඒජන්තයින් (Multi-agent) අතර සන්නිවේදනය chat messages හෝ large central prompt එකක් හරහා සිදුකළහොත්, context window පිරී යාම සහ synchronization issues ඇති වේ.
- **තීරණය (Decision)**: Jac හි Object-Spatial හැකියාව භාවිතා කර, සෑම පාඨමාලා Node එකක් උඩම `deliberation_board: list[AgentCritique]` තබා, Walkers ලා එම Node එකට ගොස් (visit) තම critique එක Node එක උඩම සටහන් කිරීම.
- **ප්‍රතිඵලය (Consequence)**: Token efficiency උපරිම වන අතර, කිසිදු message race condition එකක් ඇති නොවේ.

---

## ADR 010: Dynamic Graph Metamorphosis (සජීවීව Graph එක විකෘති කිරීම)
- **තත්ත්වය (Context)**: ශිෂ්‍යයාගේ Z-Score එකෙන් රාජ්‍ය විශ්වවිද්‍යාල නොලැබෙන විට සහ පවුලේ මුදල් වලින් පෞද්ගලික විශ්වවිද්‍යාල නොලැබෙන විට පද්ධතිය Deadlock එකකට ලක්වේ.
- **තීරණය (Decision)**: `BridgeSynthesizer` Walker එක මඟින් `by llm(method="Reasoning")` ක්‍රියාත්මක කර, Runtime එකේදීම Graph එකට අලුත් `InstituteCourse` node එකක් (`here ++> ...`) සහ `BridgePathway` edge එකක් spawn කර Graph Topology එක වෙනස් කිරීම (Metamorphosis).
- **ප්‍රතිඵලය (Consequence)**: Judges ලා මවිත වන Jac native graph mutation ප්‍රදර්ශනය කළ හැක.

---

## ADR 011: The 3 Winning Pillars (Gap Finder, Minimum Change Finder, Action Plan)
- **තත්ත්වය (Context)**: නිකන්ම "Recommendation එකක්" ලබාදීමෙන් ශිෂ්‍යයා සවිබල ගැන්වීම (User Empowerment) සිදු නොවේ.
- **තීරණය (Decision)**: 
  1. `GapAnalyzerWalker`: ශිෂ්‍යයා ඉන්නා තැන සහ Career Goal එක අතර පරතරය Graph එකෙන් පෙන්වීම.
  2. `MinimumChangeFinder`: බජට් එක රු. 4,500කින් වැඩි කළහොත් හෝ ගෙදර සිට commute කළහොත් රතු Node එක කොළ පැහැයට හැරෙන සංවේදීතාව පෙන්වීම.
  3. `ActionPlanGenerator`: තෝරාගත් මාර්ගය වෙනුවෙන් හෙට උදේ කළ යුතු පියවර 5ක ප්‍රායෝගික Checklist එකක් ලබාදීම.

---

## ADR 012: Pathway-Level Evaluation (`PathwayEvaluator`)
- **තත්ත්වය (Context)**: තනි තනි පාඨමාලා (Course Nodes) වෙන වෙනම ඇගයීම ප්‍රමාණවත් නොවේ; මන්ද යත් Course A සහ B දෙකම සුදුසු වුවත්, A අවසන් වීමට පෙර B intake එක වැසී යාම හෝ Credit transfer ගිවිසුම් නොමැති වීම නිසා Pathway එක අසාර්ථක විය හැක.
- **තීරණය (Decision)**: සම්පූර්ණ මාර්ගය (`Pathway` object) තනි ඒකකයක් ලෙස ඇගයීමට `PathwayEvaluator` Walker නිර්මාණය කිරීම.

---

## ADR 013: 2-Stage Scoring Framework (Feasibility Gate -> Preference Ranking)
- **තත්ත්වය (Context)**: Budget, time, සහ career fit එක එකම weighted score එකකට දමා average කළහොත්, අත්‍යවශ්‍ය requirement එකක් (උදා: A/L passes 3) fail වුණු option එකක් ඉහළට පැමිණිය හැක.
- **තීරණය (Decision)**:
  - **Stage 1 (Feasibility Gate)**: අනිවාර්ය නීතිමය සහ මූල්‍ය සීමාවන් binary pass/fail ලෙස පරීක්ෂා කිරීම.
  - **Stage 2 (Preference Ranking)**: Feasible වූ pathways පමණක් Lowest Cost, Fastest Completion, සහ Best Fit ලෙස කාණ්ඩ 3කින් ඉදිරිපත් කිරීම.

---

## ADR 014: Evidence-Backed Edges & Structured Decision Log
- **තත්ත්වය (Context)**: Judges ලාට graph animation එකකින් පමණක් system reasoning එක තේරුම් ගත නොහැක. තවද unsubstantiated credit transfers විශ්වාස නොකරයි.
- **තීරණය (Decision)**: 
  - සෑම `BridgePathway` edge එකකටම `source_id` (UGC Circular / Gazette) සහ `verification_status` ඇතුළත් කිරීම.
  - සම්පූර්ණ agent workflow එක `decision_log: list[str]` ලෙස auditable trace එකක් බවට පත් කිරීම.


