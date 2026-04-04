# DevOps Shield CLI

**DevOps Shield** is an institutional-grade, 100% local auditing platform designed for modern DevOps teams. It transforms fragmented security tools into a unified, plugin-based ecosystem for maintaining clean and secure infrastructure-as-code.

---

## Installation

The fastest way to install DevOps Shield is using our automated terminal installer:

```bash
curl -sSL https://raw.githubusercontent.com/SmtTheSE/shield-cli/main/install.sh | bash
```

**Windows (PowerShell or CMD):**
Run this command to download and install automatically:
```powershell
powershell -Command "iwr -useb https://raw.githubusercontent.com/SmtTheSE/shield-cli/main/install.ps1 | iex"
```
*Note: If you use regular PowerShell, you can also just use `iwr -useb ... | iex` directly. Using `powershell -Command` ensures it works even if you accidentally paste it into a standard Command Prompt (cmd.exe).*

Alternatively, you can download the latest binary from the [Releases](https://github.com/SmtTheSE/shield-cli/releases) page.

---

## Core Features

-   **Dead Config Hunter** — Standardized scanner for orphaned configuration keys within repository files.
-   **K8s YAML Linter** — Security-focused linter for Kubernetes manifests, checking for privilege escalation and misconfigurations.
-   **Docker Image Diff** — Deep layer inspection and layer-by-layer security risk scoring for comparing different container versions.
-   **Hardcoded Secret Scanner** — Entropy-based leakage detection obeying `.shieldignore` whitelisting constraints to find API keys and tokens.
-   **Cloud IAM Validator** — Offline structural policy enforcer analyzing AWS JSON and Terraform HCL for security breaches.
-   **Dependency OSV Scanner** — Analyzes `requirements.txt` and `package.json` for known vulnerabilities against the OSV database.
-   **Git History Forensics** — Deep scan of all git objects (blobs, stash, reflog) for leaked secrets using entropy + regex detection.
-   **API Contract Linter** — Security-focused linter for OpenAPI 3.x and GraphQL SDL specifications.
-   **TLS Auditor** — Full certificate chain and cipher suite auditor (A–F grading).
-   **IAM Escalation Analyzer** — Map privilege escalation paths in AWS/Terraform IAM using graph analysis.
-   **SBOM Generator** — Generate CycloneDX 1.6 or SPDX 2.3 bill of materials with license risk scoring.
-   **Container Syscall Policy (Capsule)** — Build minimal seccomp/AppArmor security profiles using static analysis or eBPF tracing.
-   **100% Local & Private** — No external API calls are made for code analysis, ensuring zero data leakage.

---

## Quick Usage

Once installed, you can run `shield` from any directory:

```bash
# 1. Unified repository scan (runs all modules)
shield scan .

# 2. Dead config hunter
shield hunt .

# 3. K8s manifest linter
shield lint k8s/

# 4. Docker image diff
shield diff python:3.11-slim python:3.12-slim

# 5. Secret leakage scanner
shield secrets .

# 6. IAM policy validator
shield iam terraform/

# 7. Git history forensics
shield forensics .

# 8. API contract linter
shield apilint openapi.yaml

# 9. TLS auditor
shield tlsaudit example.com

# 10. IAM escalation path mapping
shield escalation iam_policy.json

# 11. SBOM generation
shield sbom .

# 12. Container syscall generator
shield capsule --analyze python:3.11-slim
```

For more details, run `shield --help`.

---

## Security & Data Privacy

- **Data Locality**: The CLI executes 100% locally. Code contents and configurations are **never** transmitted.
- **Secret Protections**: Values are deliberately obscured from console output to prevent credential leakage in logs.

---

## License
MIT License
SittMinThar @2026
