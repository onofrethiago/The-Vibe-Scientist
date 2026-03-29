# Field Entry 008: Society of Agents Framework

This folder contains a generic architectural framework for implementing a **"Society of Agents"** based on the concepts proposed in the paper *"Agentic AI and the next intelligence explosion"* (arXiv:2603.20639). It provides a structured methodology for transitioning from monolithic AI models to collaborative, multi-agent systems.

## 1. Core Architectural Pillars
The framework is built on four fundamental concepts to achieve "Institutional Alignment":
- **Combinatorial Society**: Moving from a single, monolithic model to a network of specialized agents with distinct personas and restricted scopes.
- **Institutional Alignment**: Shifting from 1-on-1 model training (dyadic alignment) to digital protocols, "checks and balances," and markets.
- **Societies of Thought**: Building systems where agents "argue," "verify," and "reconcile" in a structured, multi-turn deliberation process.
- **Auditor Agents**: Independent agents empowered to check the work of other agents against a **"Digital Constitution"** (safety, legal, and quality rules).

## 2. Generic Agent Roles 🎭
The framework defines three primary roles that can be adapted for any domain:
1. **The Proposer (The Creator)**: Responsible for generating initial outputs or solutions. Focused on technical excellence and creativity.
2. **The Auditor/Critic (The Quality Check)**: Tasked with finding flaws, safety issues, or non-compliance. Operates with a low temperature for maximum consistency.
3. **The Synthesizer (The Orchestrator)**: Resolves conflicts between the Proposer and Auditor, producing the final, production-ready output.

## 3. Deliberation Protocols 🔄
The framework supports multiple interaction patterns depending on the required quality:
- **Protocol A (The Linear Chain)**: A direct path from Proposal → Audit → Synthesis. Best for low-to-medium complexity tasks.
- **Protocol B (The Recursive Debate)**: An iterative process where the Proposer refines their draft based on the Auditor's feedback before the final synthesis. Ideal for high-stakes decisions and complex problem-solving.

## 4. The Digital Constitution 📋
A critical component of this framework is the **Digital Constitution**. It serves as the steady-state ground truth for the Auditor Agent, defining principles across:
- **Safety**: Preventing illegal or dangerous outputs.
- **Integrity**: Ensuring all claims are grounded in reliable data.
- **Transparency**: Maintaining a "deliberation_log" for human-in-the-loop oversight.
- **Format**: Enforcing strict output schemas (e.g., JSON) for downstream processing.

---

## 🛠️ Implementation & Usage
To implement this framework in your own project:
1. Review the generic prompts provided in [SOCIETY_OF_AGENTS.md](./SOCIETY_OF_AGENTS.md).
2. Define your domain-specific **Digital Constitution**.
3. Initialize your agents using recommended parameters (e.g., `temp=0.7` for Proposers, `temp=0.1` for Auditors).
4. Select the **Deliberation Protocol** that matches your latency and quality requirements.

---
© 2026 The Vibe Scientist™. All Rights Reserved. Licensed under Apache 2.0. "Vibe Engineering™" and "The Vibe Scientist™" are trademarks of the author.
