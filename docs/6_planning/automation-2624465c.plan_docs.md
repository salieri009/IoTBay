<!-- 2624465c-d091-4a21-ad9e-ca03d2c081ce ef9aaf5b-d40b-4bd4-8fe5-fd369f41da5e -->
# Automation YAML Plans

## Plan Overview

We will introduce three GitHub Actions workflows to automate core lifecycle tasks for IoTBay: continuous integration, documentation validation, and deployment. Each workflow will live under `.github/workflows/`.

## Workflow 1 – CI Build & Test

- Trigger: `push`/`pull_request` on `main` and feature branches
- Jobs: checkout → Java setup (JDK 17) → cache Maven → `mvn -B clean verify`
- Artifacts: unit-test reports

## Workflow 2 – Documentation Validation

- Trigger: `push` to `design plan/**` and scheduled weekly run
- Jobs: markdown lint (e.g., `markdownlint-cli`), spell check, directory sanity check script (ensures required folders/files present)

## Workflow 3 – Deployment Pipeline

- Trigger: manual `workflow_dispatch` + tag on `release/*`
- Jobs: reuse CI build → build artifact (WAR) → upload to GitHub Releases or push to server via SCP (placeholder secrets `DEPLOY_HOST`, `DEPLOY_USER`, `DEPLOY_KEY`)
- Includes environment approvals (production)

---

**Document Version**: 1.0.0
**Status**: Published
**Last Updated**: 12�� 3, 2025
**Audience**: Developers, Stakeholders
**Maintained By**: IoT Bay Documentation Team
