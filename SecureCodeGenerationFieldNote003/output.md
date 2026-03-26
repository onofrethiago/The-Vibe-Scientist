```python
import os
import logging
from sqlalchemy import create_engine, text
from sqlalchemy.orm import sessionmaker
from typing import Dict, Any, List

# Configure internal logging - ensuring raw errors are not exposed to users
logger = logging.getLogger(__name__)

def query_user_database(user_id: str) -> Dict[str, Any]:
    """
    Queries the user database for a specific user ID using secure primitives.
    
    Args:
        user_id: The unique identifier for the user.
        
    Returns:
        A dictionary containing user details or a generic error response.
    """
    # SECRETS MANAGEMENT: Fetch URI from environment variables
    db_uri = os.environ.get("DATABASE_URL")
    
    if not db_uri:
        logger.error("Environment variable 'DATABASE_URL' is missing.")
        return {"error": "Internal Server Error", "status_code": 500}

    try:
        # DB Initialization
        engine = create_engine(db_uri)
        Session = sessionmaker(bind=engine)
        session = Session()

        # ZERO TRUST: Using parameterized queries via SQLAlchemy text()
        # This prevents SQL Injection by design.
        query = text("SELECT id, username, email FROM users WHERE id = :user_id")
        result = session.execute(query, {"user_id": user_id}).fetchone()

        if result:
            return {
                "id": result.id,
                "username": result.username,
                "email": result.email,
                "status_code": 200
            }
        else:
            return {"error": "User not found", "status_code": 404}

    except Exception as e:
        # ERROR HANDLING: Log the stack trace internally
        logger.exception("Database query failed for user_id: %s", user_id)
        
        # ERROR HANDLING: Return a generic 500 error to the client
        return {"error": "Internal Server Error", "status_code": 500}
    finally:
        if 'session' in locals():
            session.close()
```

### Mitigation of OWASP Top 10 Vulnerabilities

1.  **A03:2021-Injection**: By using SQLAlchemy's `text()` with a parameter dictionary, we ensure that the database driver handles escaping. String concatenation is avoided entirely, nullifying SQL Injection risks.
2.  **A01:2021-Broken Access Control**: While this function focuses on the query, it utilizes environment variables for database URIs, ensuring that database credentials are not hardcoded or exposed in the codebase.
3.  **A04:2021-Insecure Design**: The implementation of generic error messages prevents "information leakage." Attackers cannot use raw stack traces or database errors to map the internal schema or identify specific database versions.
4.  **A09:2021-Security Logging and Monitoring Failures**: The use of `logger.exception` ensures that every failure is recorded with a full stack trace internally, enabling DevSecOps teams to monitor and respond to anomalous patterns without exposing the same data to the end user.

---

## Legal Disclaimer & Licensing Notice

All content, code snippets, and prompts provided by **The Vibe Scientist™** are for educational and research purposes only. **Use at Your Own Risk**: The user assumes full and total responsibility for any outcomes, intended or unintended, resulting from the use of this information. The Vibe Scientist™ and its authors provide no warranties, express or implied, regarding the security or functionality of AI-generated code. AI models are probabilistic; always verify, sandbox, and audit code before deploying to production.

**License**: All code snippets shared on this blog are licensed under the **Apache License 2.0**. You may use, modify, and distribute the code, provided you retain this notice and the original copyright.

