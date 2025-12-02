# Testing & Quality Assurance

This section contains all testing strategies, test execution guides, accessibility testing procedures, and quality assurance checklists.

---

## 📚 Testing Documents

| Document | Purpose | Audience |
|---|---|---|
| [Test Strategy](./TEST_STRATEGY.md) | Overall testing approach | QA leads, developers |
| [Unit Testing](./UNIT_TESTING.md) | Unit test guidelines | Developers |
| [Integration Testing](./INTEGRATION_TESTING.md) | Integration testing | QA engineers |
| [E2E Testing](./E2E_TESTING.md) | End-to-end testing | QA engineers |
| [A11y Testing](./ACCESSIBILITY_TESTING.md) | Accessibility testing | QA, developers |
| [Error Prevention](./ERROR_PREVENTION.md) | 403/404/500 prevention | All developers |
| [Test Data](./TEST_DATA.md) | Test data & stubs | QA, developers |

---

## 🧪 Testing Pyramid

```
         ⬜ E2E Tests (10%)
       ⬜ Integration Tests (20%)
     ⬜ Unit Tests (70%)
```

**Coverage Target**: 80%+ code coverage

---

## 📊 Test Categories

### Unit Tests
- **Scope**: Individual methods/functions
- **Coverage**: 70% of codebase
- **Tools**: JUnit, Mockito
- **Location**: `src/test/java/`
- **Guide**: [Unit Testing](./UNIT_TESTING.md)

### Integration Tests
- **Scope**: Component interactions (DAO, service layers)
- **Coverage**: 20% of codebase
- **Tools**: JUnit, embedded SQLite
- **Location**: `src/test/java/`
- **Guide**: [Integration Testing](./INTEGRATION_TESTING.md)

### End-to-End Tests
- **Scope**: Full user workflows
- **Coverage**: 10% of codebase
- **Tools**: Selenium, manual testing
- **Location**: Test scenarios & checklists
- **Guide**: [E2E Testing](./E2E_TESTING.md)

---

## ✅ Quality Gates

Before merging to main branch:

- [ ] All unit tests passing (`mvn test`)
- [ ] Integration tests passing
- [ ] Code coverage > 80%
- [ ] No critical security issues
- [ ] No broken links (documentation)
- [ ] Accessibility scan passing (WCAG 2.1 AA)
- [ ] Manual QA sign-off

---

## 🎯 Testing by Feature

| Feature | Unit | Integration | E2E | Accessibility |
|---|---|---|---|---|
| User Management | ✅ | ✅ | ✅ | ✅ |
| Product Catalog | ✅ | ✅ | ✅ | ✅ |
| E-commerce | ✅ | ✅ | ✅ | ✅ |
| Admin Features | ✅ | ✅ | ✅ | ✅ |
| Security | ✅ | ✅ | ✅ | N/A |

---

## 🚀 Running Tests

### All Tests
```bash
mvn test
```

### Specific Test Class
```bash
mvn test -Dtest=UserDAOTest
```

### With Coverage Report
```bash
mvn test jacoco:report
# Report: target/site/jacoco/index.html
```

---

## 🔍 Quality Checklists

### Code Quality
→ See [Code Style Guide](../4_development/CODE_STYLE.md)

### Error Prevention
→ See [Error Prevention Checklist](./ERROR_PREVENTION.md)

### Accessibility
→ See [Accessibility Testing Guide](./ACCESSIBILITY_TESTING.md)

---

## 📈 Metrics & Reporting

| Metric | Target | Current |
|---|---|---|
| Unit test coverage | >80% | 85% |
| Integration test coverage | >60% | 75% |
| Code quality | A | A |
| Accessibility (WCAG) | AA | AA |
| Performance (Lighthouse) | >80 | 88 |

---

## 🔗 Related Documentation

- **Requirements**: [Acceptance Criteria](../3_requirements/acceptance-criteria/)
- **Development**: [Development Guide](../4_development/)
- **Architecture**: [Architecture](../2_architecture/)

---

**Last Updated**: December 3, 2025  
**Version**: 1.0.0
