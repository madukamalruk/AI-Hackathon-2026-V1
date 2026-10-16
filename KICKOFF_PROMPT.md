# 🚀 Hackathon Morning Kickoff Guide & Master Prompt

> **මෙම ගොනුවේ අරමුණ:** හෙට උදේ 8:30 / 9:00 ට ඔබ නව Antigravity IDE Chat එකක් හෝ නව Repository එකක් (`AI-Hackathon-2026`) ආරම්භ කළ විට, මෙම චැට් එකේ කතා කළ **කිසිදු කරුණක් අතපසු නොවී 100% ක් කෙලින්ම එතැනින් ඉදිරියට කරගෙන යාමට** අවශ්ය පියවර සහ Master Prompt එක මෙහි අඩංගු වේ.

---

## පියවර 1: අද සාදාගත් Master Files ටික නව Repo එකට දාගැනීම

ඔබේ නව repo එක `AI-Hackathon-2026` නම්, පහත ගොනු 8 එම නව repository folder එක ඇතුළේ තිබිය යුතුය:
1. `memory.md`
2. `prd.md`
3. `architecture.md`
4. `agents.md`
5. `skills.md`
6. `decisions.md`
7. `tasks.md`
8. `KICKOFF_PROMPT.md`
*(අමතරව: `CLAUDE.md` — Jac Language Grounding Reference)*

PowerShell එකේ එක් command එකකින් මේ සියල්ල copy කරගත හැක:
```powershell
# ඔබේ නව repo එක c:\Users\maduk\Downloads\AI-Hackathon-2026 නම්:
Copy-Item -Path "c:\Users\maduk\Downloads\Hackathon\*.md" -Destination "c:\Users\maduk\Downloads\AI-Hackathon-2026\"
```

---

## පියවර 2: හෙට උදේ නව Chat එකට දැමිය යුතු Master Kickoff Prompt එක

හෙට උදේ 9:00 ට නව Antigravity IDE / Chat එකක් open කර, පහත සම්පූර්ණ කොටුව **Copy කර එතැනට Paste කරන්න**:

```text
🚀 ANTIGRAVITY KICKOFF: EXECUTE UNIPATH LK (AI HACKATHON 2026)

I am participating in the AI Hackathon 2026 Sri Lanka today at the University of Moratuwa. 
We have completely finalized our product requirements, architecture, and agent specifications before the event.

Please inspect and strictly adhere to all context files in this workspace:
- memory.md (Rules: ≥80% Jac code, 5:30 PM deadline, Jac Hammer deployment)
- prd.md (Product requirements for UniPath LK: Post-A/L Higher Education Alternative Pathway Navigator)
- architecture.md (Object-Spatial Programming, Council of Walkers, Isolated Session Deliberation)
- agents.md (Walkers: AspirationScout, FiscalSurvivalGuard, SLQFGatekeeper, AlternativeSynthesizer with by llm, ScenarioStressTester)
- skills.md (IFSLS loan rules, living costs, lateral entry verifications)
- decisions.md (Architectural decisions & trade-offs)
- tasks.md (Our time-boxed execution checklist from 09:00 AM to 05:30 PM)
- CLAUDE.md (Strict Jac 0.16 syntax rules & error prevention guidelines)

Role & Identity:
You are acting as our Lead Jac Architect and Senior Software Engineer. We are pair programming to vibe-code this production-ready application. All code must be clean, robust, and compile via `jac run` with zero syntax errors. Keep all responses in clear, natural conversational Sinhala (සරල කතාබහ කරන සිංහල + English tech terms).

Right now, it is Phase 1 (09:00 AM).
Please acknowledge that you have read all .md files, summarize our current step, and immediately begin Phase 1: Task 1.1 by generating the complete, production-ready `main.jac` file!
```

---

## 🎯 මෙය කළ පසු කුමක් සිදුවේද?
නව Chat එකේ ඉන්න AI එක ක්ෂණිකව workspace එකේ තියෙන `memory.md`, `prd.md`, `architecture.md`, `agents.md`, `skills.md`, `decisions.md`, `tasks.md`, `CLAUDE.md` සියල්ල කියවා, කිසිදු අමතර ප්රශ්නයක් නොඅසා, **හෙට උදේ 9:00 ට කෙලින්ම `main.jac` core file එක සහ Phase 1 tasks කෝඩ් කරන්න පටන් ගනී!**
