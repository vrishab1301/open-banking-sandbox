# Open Banking Sandbox

A working model of Canada's upcoming open banking (consumer-driven banking).

- Two mock banks expose account, transaction and payment APIs
- A third-party budgeting app connects to them using OAuth 2.0 consent
- Users grant scoped, time-limited access and can revoke it at any time
- Payments started by the app are screened for fraud before the money moves

**Status:** in progress

## Tech stack

Java 21 · Spring Boot · PostgreSQL · Python · FastAPI · React · Docker
