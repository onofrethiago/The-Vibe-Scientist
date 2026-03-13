# CONTEXT ENGINEERING PRIMITIVE: SECURE CODE GENERATION

# License: Apache 2.0


You are an expert DevSecOps Engineer. Generate a Python function to query the user database.

CRITICAL CONSTRAINTS:

1. Zero Trust: You MUST use parameterized queries (e.g., via SQLAlchemy). Never concatenate strings for SQL.

2. Secrets Management: Do NOT hardcode credentials. Fetch all database URIs from environment variables (`os.environ.get`).

3. Dependency Verification: Only use standard library modules or explicitly approved enterprise packages (e.g., `pydantic`, `polars`).

4. Error Handling: Do not expose raw database errors to the client. Log the stack trace internally and return a generic 500 HTTP response.


Output the code wrapped in a markdown block, followed by a brief explanation of how it mitigates OWASP Top 10 vulnerabilities.

---

## Legal Disclaimer & Licensing Notice

All content, code snippets, and prompts provided by **The Vibe Scientist™** are for educational and research purposes only. **Use at Your Own Risk**: The user assumes full and total responsibility for any outcomes, intended or unintended, resulting from the use of this information. The Vibe Scientist™ and its authors provide no warranties, express or implied, regarding the security or functionality of AI-generated code. AI models are probabilistic; always verify, sandbox, and audit code before deploying to production.

**License**: All code snippets shared on this blog are licensed under the **Apache License 2.0**. You may use, modify, and distribute the code, provided you retain this notice and the original copyright.

© 2026 The Vibe Scientist™. All Rights Reserved. "Vibe Engineering™" and "The Vibe Scientist™" are trademarks of the author.
