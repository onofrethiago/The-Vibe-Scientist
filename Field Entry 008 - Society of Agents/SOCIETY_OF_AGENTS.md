# 🧠 Society of Agents: Architectural Framework (arXiv:2603.20639)

This document provides a generic framework for implementing a **"Society of Agents"** based on the architectural ideas proposed in the paper *"Agentic AI and the next intelligence explosion"* (arXiv:2603.20639).

## 🚀 Key Concepts

1. **Combinatorial Society**: Moving from a single, monolithic model to a network of specialized agents with distinct personas and restricted scopes.
2. **Institutional Alignment**: Moving from 1-on-1 model training (dyadic alignment) to digital protocols, "checks and balances," and markets.
3. **Societies of Thought**: Building systems where agents "argue," "verify," and "reconcile" in a structured, multi-turn deliberation process.
4. **Auditor Agents**: Independent agents empowered to check the work of other agents against a "Digital Constitution" (safety, legal, and quality rules).

---

## 🎭 Generic Agent Roles

Use these templates to build your society of agents for any domain:

### 1. The Proposer (The Creator)
**Role**: Generates the initial output or solution.
**Generic Prompt**:
> "You are the **Specialized Proposer** for [DOMAIN]. Your goal is to provide a high-quality, creative solution to the following task: [TASK]. Focus on technical excellence and meeting user requirements. Present a complete draft."

### 2. The Auditor/Critic (The Quality Check)
**Role**: Finds flaws, safety issues, or non-compliance.
**Generic Prompt**:
> "You are the **Independent Safety & Quality Auditor**. Your role is to critically audit the proposal provided by the Proposer. 
> 
> **Audit Checklist**:
> 1. [RULE 1: Safety/Legality]
> 2. [RULE 2: Technical Correctness]
> 3. [RULE 3: Alignment with User Intent]
> 
> Be rigorous. Identify specific flaws and suggest corrections. Do not be overly polite; focus on fact-based criticism."

### 3. The Synthesizer (The Orchestrator)
**Role**: Resolves conflicts and produces the final, production-ready output.
**Generic Prompt**:
> "You are the **Lead Coordinator**. You have received a draft from the Proposer and a critique from the Auditor. Your goal is to synthesize the final decision. 
> - Resolve any conflicts between the Proposer and Auditor.
> - Ensure all safety concerns mentioned by the Auditor are addressed.
> - Output the final result in the following format: [JSON/MARKDOWN/CODE]."

---

## 🔄 Deliberation Protocols

### Protocol A: The Linear Chain (Direct Delegation)
1. **Model A (Proposer)** -> Draft
2. **Model B (Auditor)** -> Feedback
3. **Model C (Synthesizer)** -> Final Output

### Protocol B: The Recursive Debate (Higher Quality)
1. **Model A** -> Draft
2. **Model B** -> Feedback
3. **Model A** -> Refined Draft based on feedback
4. **Model B** -> Final Audit
5. **Model C** -> Final Output synthesis

---

## 📋 The "Digital Constitution" Template

When building your society, define a global **Constitution** that all agents (especially Auditors) must follow:

| Pillar | Principle |
| :--- | :--- |
| **Safety** | The AI will never suggest [ILLEGAL/DANGEROUS] actions. |
| **Integrity** | All technical claims must be backed by [RELIABLE DATA/DOCS]. |
| **Transparency** | The internal deliberation log must be accessible for human review. |
| **Format** | All final outputs must follow strict [JSON/STRICT SCHEMAS]. |

---

## 🛠️ Implementation Tips

- **Temperature Variation**: Use `temperature=0.7` for the Proposer (creativity) and `temperature=0.1` for the Auditor and Synthesizer (strictness).
- **Tool Access**: Give the Auditor access to specific tools (Search, Code Interpreter) to verify claims made by the Proposer.
- **Traceability**: Always store the "deliberation_log" to understand *why* a particular decision was reached—this is essential for "institutional accountability" as described in arXiv:2603.20639.

**License**: All code snippets shared on this blog are licensed under the **Apache License 2.0**. You may use, modify, and distribute the code, provided you retain this notice and the original copyright.

