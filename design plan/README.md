# IoTBay Design Plan Library

**Project**: IoTBay E-commerce Platform  
**Course**: 41025 Information Systems Development (ISD)  
**Assignment**: A2 – Autumn 2025, University of Technology Sydney

> Curated like a 30-year technical writer: every artifact has a defined home, owner, and relationship to the rest of the system.

---

## 1. Directory Map

```
design plan/
├── README.md                        ← You are here
├── DIRECTORY_STRUCTURE_REVIEW.md    ← Audit log of structural decisions
├── en/                              ← Primary language (detailed)
│   ├── 1_strategy/                  ← Roadmaps & intent
│   ├── 2_architecture/              ← Systems, specs, tokens
│   ├── 3_execution/                 ← Migration logs & outcomes
│   ├── 4_reviews/                   ← Audits & findings
│   └── 5_reference/                 ← Source references (assignment brief, etc.)
├── ja/                              ← Japanese summaries
└── ko/                              ← Korean summaries
```

### English Collections

| Folder | Purpose | Representative Documents |
|--------|---------|--------------------------|
| `1_strategy/` | Vision, refactoring intent, UX playbooks | `UX_IMPROVEMENT_PLAN.en.md`, `FRONTEND_REFACTORING_EXECUTION.en.md`, `FRONTEND_REFACTORING_SESSION_SUMMARY.en.md`, `ATOMIC_DESIGN_IMPLEMENTATION_PLAN.en.md`, `41025_ISD_TEST01.md` |
| `2_architecture/` | Source-of-truth specs (design tokens, APIs, DB) | `DESIGN_SYSTEM.en.md`, `MODERN_DESIGN_SYSTEM.en.md`, `COMPONENT_ARCHITECTURE.en.md`, `API_DOCUMENTATION.en.md`, `DATABASE_DESIGN.en.md`, `COLOR_REFACTORING_GUIDE.en.md`, `UI_UX_DOCUMENTATION.en.md`, `41025_ISD_TEST02.md` |
| `3_execution/` | What actually shipped—migration guides, completion memos | `ATOMIC_DESIGN_EXECUTION_SUMMARY.en.md`, `ATOMIC_DESIGN_MIGRATION_GUIDE.en.md`, `FRONTEND_REFACTORING_COMPLETE.en.md`, `MIGRATION_COMPLETE.en.md`, `DEDUPLICATION_SUMMARY.en.md`, `CLEANUP_SUMMARY.en.md` |
| `4_reviews/` | Independent assessments and QA | `CSS_REVIEW_REPORT.en.md`, `FRONTEND_REVIEW_REPORT.en.md`, `ATOMIC_COMPONENTS_CSS_REVIEW.en.md` |
| `5_reference/` | Canonical references | `41025 ISD Assignment 2 Autumn 2025.pdf` |

### Localised Sets
- `ja/` and `ko/` mirror the architectural essentials (design system, developer guides, UX plan).  
- Naming policy: `DOCUMENT_NAME.en.md` for English, `DOCUMENT_NAME.md` for translations inside their locale.

---

## 2. How to Use This Library

| Role | Read This First | Then... |
|------|-----------------|---------|
| **Product / UX** | `1_strategy/UX_IMPROVEMENT_PLAN.en.md` | `2_architecture/UI_UX_DOCUMENTATION.en.md`, `2_architecture/DESIGN_SYSTEM.en.md` |
| **Front-end Dev** | `2_architecture/COMPONENT_ARCHITECTURE.en.md` | `2_architecture/JSP_DEVELOPER_DOCUMENTATION.en.md`, `3_execution/FRONTEND_REFACTORING_COMPLETE.en.md`, `4_reviews/CSS_REVIEW_REPORT.en.md` |
| **Back-end / API** | `2_architecture/API_DOCUMENTATION.en.md` | `2_architecture/DATABASE_DESIGN.en.md`, `1_strategy/FRONTEND_REFACTORING_EXECUTION.en.md` |
| **Program Manager** | `1_strategy/FRONTEND_REFACTORING_SESSION_SUMMARY.en.md` | `3_execution/MIGRATION_COMPLETE.en.md`, `4_reviews/FRONTEND_REVIEW_REPORT.en.md` |

---

## 3. Maintenance Protocol

1. **Authoring** – Draft in English (`*.en.md`).  
2. **Categorise** – Place under the correct `en/<n_category>/` folder.  
3. **Cross-link** – Reference related docs in the “Related Work” section of each file.  
4. **Translate** (if required) – Drop language-specific copies into `ja/` or `ko/`.  
5. **Log Changes** – Update `DIRECTORY_STRUCTURE_REVIEW.md` when the information architecture changes.

Update cadence:
- Major roadmap/design shifts → immediately
- Execution logs → at project closure
- Reviews → per audit cycle

---

## 4. Related Resources
- `DIRECTORY_STRUCTURE_REVIEW.md` – historical rationale for the current layout.
- `design plan/en/5_reference/` – assignment brief and any source mandates.

---

**Maintainer**: IoTBay Documentation Team  
**Last reorganised**: 2025-?? (see git history for precise timestamp)

