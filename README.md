# DevOps Shield CLI

**DevOps Shield** is an institutional-grade, 100% local auditing platform designed for modern DevOps teams. It transforms fragmented security tools into a unified, plugin-based ecosystem for maintaining clean and secure infrastructure-as-code.

---

## Installation

The fastest way to install DevOps Shield is using our automated terminal installer:

```bash
curl -sSL https://raw.githubusercontent.com/SmtTheSE/shield-cli/main/install.sh | bash
```

**Windows (PowerShell):**
```powershell
iwr -useb https://raw.githubusercontent.com/SmtTheSE/shield-cli/main/install.ps1 | iex
```

Alternatively, you can download the latest binary from the [Releases](https://github.com/SmtTheSE/shield-cli/releases) page.

---

## Features

- **Unified Platform Audit**: Run a full repository scan, Kubernetes linting, and Docker image diffing in one command.
- **Hardcoded Secret Scanner**: Entropy-based leakage detection obeying `.shieldignore` constraints.
- **Cloud IAM Validator**: Offline structural policy enforcer for AWS JSON and Terraform HCL.
- **Dependency OSV Scanner**: Security analysis for `requirements.txt` and `package.json` locking systems.
- **Docker Image Diff**: Deep layer inspection and layer-by-layer security risk scoring.
- **100% Local**: No external API calls, zero data leakage.

---

## Quick Usage

Once installed, you can run `shield` from any directory:

```bash
# 1. Unified repository scan (runs all of the following)
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

# 7. Dependency vulnerability scanner
shield deps .
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
