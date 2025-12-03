# Documentation Refactoring Action Plan

**Date:** December 3, 2025  
**Reviewer:** Senior Technical Writer (20 Years Experience)  
**Project:** IoT Bay (v1.0.0)  
**Status:** In Progress

---

## Executive Summary

The `docs/` directory contains substantial, well-organized documentation but suffers from **structural redundancy, scattered legacy files, and inconsistent indexing**. This refactoring plan consolidates, curates, and reorganizes all documentation to achieve:

- ✅ Single source of truth for each document type
- ✅ Hierarchical accessibility for diverse audiences
- ✅ Version-consistent, actively maintained content
- ✅ Developer-friendly navigation and cross-references
- ✅ Clear deprecation paths for outdated files

---

## Phase 1: Audit & Classification

### Current State Analysis

#### ✅ Well-Organized Sections (Keep & Enhance)
- **1_getting-started/** (5 docs) - Clear, current, well-structured
- **2_architecture/** (3 docs) - Comprehensive, up-to-date
- **3_requirements/** (5 docs + acceptance-criteria/) - Feature-complete
- **4_development/** (8 docs) - Practical, developer-focused
- **5_testing/** (3 docs) - Robust testing guidance
- **6_planning/** (1 doc + subdirs) - Strategic planning

#### ⚠️ Problematic Areas (Require Action)

1. **Scattered Root-Level Files** (11 docs at `docs/`)
   - `QUICK_REFERENCE.md` - Good, keep, integrate into index
   - `README.en_docs.md`, `README.ja_docs.md`, `README.ko_docs.md` - Duplicate READMEs, consolidate
   - `REFACTORING_PLAN.md`, `REFACTORING_COMPLETION_REPORT.md` - Historical, should archive or consolidate

2. **Orphaned Legacy Directories** (3 dirs)
   - `docs/architecture/` - Duplicate of `2_architecture/`, contains outdated analysis
   - `docs/development/` - Duplicate of `4_development/`, contains outdated UI/UX docs
   - `docs/testing/` - Partial duplicate of `5_testing/`, contains outdated checklists
   - `docs/requirements/` - Partial duplicate of `3_requirements/`
   - `docs/plans/` - Unknown purpose, appears empty

3. **Unmaintained Archive** (27 files in `docs/archive/`)
   - Many have inconsistent naming: `*_en_docs.md`, `*_docs.md`, `README_*.md`
   - Lack clear deprecation rationale or migration paths
   - Should be curated, not blanket-archived

4. **Incomplete i18n Structure**
   - `docs/i18n/ja/` and `docs/i18n/ko/` exist but empty
   - No clear localization strategy defined
   - Should either be populated or archived with note

5. **Inconsistent Metadata**
   - Some docs have version (1.0.0), others don't
   - "Last Updated" dates missing or inconsistent
   - Status fields (Draft/Review/Published) not uniform

---

## Phase 2: Consolidation Strategy

**Status**: ✅ **COMPLETED** (December 3, 2025)  
**Completion Report**: [PHASE_2_SUMMARY.md](./PHASE_2_SUMMARY.md)

### Completed Actions

#### ✅ Step 1: Collapsed Redundant Directories (COMPLETE)
- **`docs/architecture/`** → Merged 4 unique files into `docs/2_architecture/`, archived 3 legacy files
- **`docs/development/`** → Merged 6 unique guides into `docs/4_development/`, archived 2 legacy versions
- **`docs/testing/`** → Merged 5 checklists/audits into `docs/5_testing/`, preserved all unique content
- **`docs/requirements/`** → Merged 15 FR specs + UX Scenarios into `docs/3_requirements/`, 100% preserved
- **`docs/plans/`** → Merged 6 strategic plans into `docs/6_planning/`, all preserved

**Result**: 36 files consolidated into main sections, 6 legacy files archived, 5 orphaned directories removed

#### ✅ Step 2: Cleaned Empty Legacy Directories (COMPLETE)
- **Removed empty directories**: `docs/archive/`, `docs/reports/`, `docs/i18n/ja/`, `docs/i18n/ko/`
- **Preserved active directories**: All 8 main sections (0_refactoring through 8_archive) now clean and organized

#### ✅ Step 3: Updated Documentation Index (COMPLETE)
- **INDEX.md updated** with all 36 newly consolidated files
- Architecture section: 6 → 10 documents
- Requirements section: 6 → 21 documents  
- Development section: 9 → 12 documents
- Testing section: 4 → 9 documents
- Planning section: 3 → 9 documents
- Archive count updated: 27 → 33 files

### Recommended Actions (Phase 3)
- Create `docs/8_archive/ARCHIVE_INDEX.md` with:
  - Rationale for each archived file
  - Deprecation date and replacement document
  - Search terms for discovery
- Remove redundant archive files (e.g., 27 → 10 curated items)

#### Step 4: Activate i18n Structure
- Option A: Populate with Japanese/Korean translations (if planned)
- Option B: Archive with clear status "Pending localization"

#### Step 5: Create Master Index System
- **`docs/INDEX.md`** - Comprehensive index with role-based navigation
- **Role-based guides:**
  - For New Developers → `NEW_DEVELOPER_GUIDE.md` (symlink to QUICKSTART + setup)
  - For Architects → `ARCHITECTURE_GUIDE.md` (curated links)
  - For QA/Testers → `TESTING_GUIDE.md` (curated links)
  - For Project Managers → `PROJECT_OVERVIEW.md` (already exists, link it)

---

## Phase 3: Metadata & Consistency Updates

### Apply to ALL Active Documents

**Header Template (Add/Update):**
```markdown
# Document Title

**Version**: 1.0.0  
**Last Updated**: December 3, 2025  
**Status**: Published  
**Audience**: [Developers | QA | Architects | PMs | Everyone]  
**Related**: [Link to related doc 1, Link to related doc 2]

---

[Document content...]

---

**Version**: 1.0.0  
**Status**: Published  
**Maintained By**: IoT Bay Team
```

### Naming Consistency
- All files: `FILENAME.md` (no language suffix in English)
- Translations: `FILENAME.ja.md`, `FILENAME.ko.md`
- Archive marker: `_ARCHIVED.md` or move to `8_archive/`

### Cross-Reference Links
- Link format: `[Document Title](../path/to/DOCUMENT.md)`
- Add "Related Documents" section at end of each doc
- Update all broken links

---

## Phase 4: Directory Structure (Final)

```
docs/
├── README.md                           # Master index (all audiences)
├── INDEX.md                            # Detailed index with search
├── CHANGELOG.md                        # Documentation version history
├── NEW_DEVELOPER_GUIDE.md              # Onboarding quickstart
├── ARCHITECTURE_GUIDE.md               # Architect reference
├── TESTING_GUIDE.md                    # QA/Tester reference
│
├── 1_getting-started/                  # Onboarding & setup (KEEP)
│   ├── README.md
│   ├── QUICKSTART.md
│   ├── PROJECT_OVERVIEW.md
│   ├── TECH_STACK.md
│   └── SETUP_GUIDE.md
│
├── 2_architecture/                     # System design (ENHANCED)
│   ├── README.md
│   ├── COMPONENT_ARCHITECTURE.md
│   ├── DATABASE_DESIGN.md
│   ├── DESIGN_SYSTEM.md
│   ├── API_DESIGN.md                   # NEW: Merge from development/
│   ├── SECURITY_ARCHITECTURE.md        # NEW: Merge from development/
│   └── [Content from docs/architecture/ + docs/development/design system]
│
├── 3_requirements/                     # Features & specs (KEEP)
│   ├── README.md
│   ├── FEATURES.md
│   ├── USER_STORIES.md
│   ├── API_REFERENCE.md
│   ├── reference/                      # NEW
│   │   └── 41025_ISD_Assignment_2_Autumn_2025.pdf
│   └── acceptance-criteria/
│
├── 4_development/                      # Dev practices (ENHANCED)
│   ├── README.md
│   ├── CONTRIBUTING.md
│   ├── GIT_WORKFLOW.md
│   ├── DEVELOPMENT_SETUP.md
│   ├── BACKEND_GUIDE.md
│   ├── FRONTEND_GUIDE.md
│   ├── CODE_STYLE.md
│   ├── DATABASE_SETUP.md               # NEW: From development/
│   └── deployment/
│
├── 5_testing/                          # QA & testing (ENHANCED)
│   ├── README.md
│   ├── TEST_STRATEGY.md
│   ├── ERROR_PREVENTION.md
│   ├── ACCESSIBILITY_TESTING.md        # NEW
│   └── reports/
│
├── 6_planning/                         # Roadmap & planning (KEEP)
│   ├── README.md
│   ├── PROJECT_ROADMAP.md
│   ├── migration-guides/
│   └── design-reviews/
│
├── 7_reports/                          # Status reports (KEEP)
│   ├── README.md
│   └── 2025/
│
├── 8_archive/                          # Historical docs (REFACTORED)
│   ├── README.md
│   ├── ARCHIVE_INDEX.md                # NEW: Archive guide
│   ├── REFACTORING_PLAN.md.archived
│   ├── REFACTORING_COMPLETION_REPORT.md.archived
│   └── [10 curated legacy files]
│
└── i18n/                               # Internationalization (PENDING)
    ├── ja/                             # Japanese (future)
    ├── ko/                             # Korean (future)
    └── README.md                       # i18n status
```

---

## Phase 5: Actions & Timeline

### Week 1: Foundation
- [ ] Create this plan, get approval
- [ ] Create master index files (INDEX.md, role-based guides)
- [ ] Audit and tag all files with metadata

### Week 2: Consolidation
- [ ] Move/merge content from orphaned directories into main sections
- [ ] Standardize all active documents with header/footer templates
- [ ] Update all cross-references and internal links

### Week 3: Cleanup
- [ ] Archive deprecated files with clear rationale
- [ ] Delete redundant directory duplicates (after migration)
- [ ] Verify no broken links, build documentation site locally

### Week 4: Finalization
- [ ] Get stakeholder review on new structure
- [ ] Commit to git with comprehensive message
- [ ] Update CONTRIBUTING.md with new guidelines
- [ ] Train team on new structure

---

## Success Criteria

✅ **Discoverability**: New contributor finds any document in < 2 minutes  
✅ **Consistency**: All documents follow same structure, naming, metadata  
✅ **Currency**: All docs match current codebase version (1.0.0)  
✅ **No Redundancy**: Single source of truth for each topic  
✅ **Accessibility**: Clear role-based navigation for diverse audiences  
✅ **Maintainability**: Clear process for adding/updating documents  
✅ **Version Control**: All changes tracked, rationale documented  

---

## Risks & Mitigation

| Risk | Mitigation |
|------|-----------|
| Broken links after reorganization | Comprehensive link audit + automated testing |
| Lost historical context | Archive with deprecation rationale + git history |
| Incomplete migration | Staged approach with validation at each phase |
| Stakeholder confusion | Communication plan + role-based guides |

---

## Notes for Technical Writer

1. **Language Handling**: Decide on i18n strategy before finalizing structure
2. **Tooling**: Consider MkDocs or Docusaurus for automated site generation
3. **Automation**: Set up GitHub Actions to validate links on commit
4. **Maintenance**: Assign document owners for each section
5. **Versioning**: Align documentation versioning with software releases

---

**Next Step**: Review and approve this plan, then proceed to Phase 1 implementation.

**Approvals**:
- [ ] Technical Writer
- [ ] Project Manager
- [ ] Lead Developer
- [ ] Stakeholder

---

**Document Version**: 1.0.0  
**Status**: Ready for Review  
**Prepared By**: Senior Technical Writer (AI Agent)
