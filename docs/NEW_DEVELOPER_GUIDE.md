# New Developer Quick Start Guide

**Version**: 1.0.0  
**Last Updated**: December 3, 2025  
**Status**: Published  
**Audience**: New Team Members  
**Time to Complete**: 15-30 minutes

---

## 🚀 Quick Summary

Welcome to IoT Bay! This guide gets you coding in **15 minutes**. Everything you need is linked below.

### What is IoT Bay?
IoT Bay is a university assignment project—an e-commerce platform for IoT devices built with **Java Servlets, JSP, and SQLite**. You'll work with a **3-tier architecture** (Controllers → Services → DAOs).

### Quick Facts
- **Language**: Java 8+
- **Framework**: Servlets 3.1 + JSP 2.3
- **Database**: SQLite (dev) / PostgreSQL (prod)
- **Build**: Maven 3.6+
- **Features**: User auth, product catalog, shopping cart, orders

---

## 🎯 Your First 15 Minutes

### 1. Environment Setup (5 min)
Follow **one** of these, depending on your OS:
- **Windows**: [Setup Guide - Windows](./1_getting-started/SETUP_GUIDE.md#windows)
- **macOS**: [Setup Guide - macOS](./1_getting-started/SETUP_GUIDE.md#macos)
- **Linux**: [Setup Guide - Linux](./1_getting-started/SETUP_GUIDE.md#linux)

**Verify installation**:
```bash
java -version      # Should be 8+
mvn -version       # Should be 3.6+
git --version      # Should be 2.x+
```

### 2. Clone & Build (5 min)
```bash
# Clone the repository
git clone https://github.com/salieri009/IoTBay.git
cd IoTBay

# Build the project
mvn clean install

# You should see "BUILD SUCCESS"
```

### 3. Run the Application (3 min)
```bash
# Start the development server
mvn jetty:run

# Visit in browser: http://localhost:8080
# You should see the IoT Bay homepage
```

### 4. Explore the Codebase (2 min)
Key folders to understand:
- `src/main/java/controller/` - HTTP request handlers
- `src/main/java/service/` - Business logic
- `src/main/java/dao/` - Database access
- `src/main/webapp/` - JSP pages & frontend

---

## 📚 Essential Reading (Next 15 Min)

### For Everyone
1. [**Project Overview**](./1_getting-started/PROJECT_OVERVIEW.md) - What we're building (5 min)
2. [**Tech Stack**](./1_getting-started/TECH_STACK.md) - Tech choices explained (5 min)
3. [**Quick Reference**](./QUICK_REFERENCE.md) - Common tasks & links (5 min)

### For Backend Developers
1. [**Component Architecture**](./2_architecture/COMPONENT_ARCHITECTURE.md) - Frontend structure (5 min)
2. [**Backend Guide**](./4_development/BACKEND_GUIDE.md) - Servlets, DAOs, patterns (10 min)
3. [**Code Style Guide**](./4_development/CODE_STYLE.md) - Our coding standards (5 min)

### For Frontend Developers
1. [**Component Architecture**](./2_architecture/COMPONENT_ARCHITECTURE.md) - UI component design (5 min)
2. [**Frontend Guide**](./4_development/FRONTEND_GUIDE.md) - JSP, TypeScript, CSS (10 min)
3. [**Design System**](./2_architecture/DESIGN_SYSTEM.md) - Visual standards (5 min)

---

## 🔧 Common First Tasks

### Task 1: Create a Feature Branch
```bash
# See Git conventions
git checkout -b feature/your-feature-name
```
[Learn more: Git Workflow](./4_development/GIT_WORKFLOW.md)

### Task 2: Make Your First Code Change
1. Open any controller in `src/main/java/controller/`
2. Understand the pattern: `@WebServlet` → `init()` → `doGet()` / `doPost()`
3. Make a small change
4. Run tests: `mvn test`
5. Commit: `git add . && git commit -m "feat: your message"`

[Learn more: Backend Guide](./4_development/BACKEND_GUIDE.md)

### Task 3: Find & Run Tests
```bash
# Run all tests
mvn test

# Run specific test
mvn test -Dtest=YourTestClass
```
[Learn more: Test Strategy](./5_testing/TEST_STRATEGY.md)

---

## ❓ Troubleshooting

### "Build fails with Java errors"
- Check Java version: `java -version` (must be 8+)
- [Setup Guide](./1_getting-started/SETUP_GUIDE.md)

### "Port 8080 already in use"
- Change port in `pom.xml` or kill the process:
  - Windows: `netstat -ano | findstr :8080`
  - macOS/Linux: `lsof -i :8080`

### "Can't connect to database"
- Check `iotbay.db` exists in project root
- Run `mvn clean install` to reset

### "Need help understanding the architecture?"
- [Architecture Overview](./2_architecture/README.md)
- [Component Architecture](./2_architecture/COMPONENT_ARCHITECTURE.md)

---

## 🎓 Next Steps (After First Day)

1. **Read full guides** for your role:
   - Developers: [Backend](./4_development/BACKEND_GUIDE.md) or [Frontend](./4_development/FRONTEND_GUIDE.md)
   - QA: [Testing Guide](./TESTING_GUIDE.md)

2. **Understand the requirements**:
   - [Features List](./3_requirements/FEATURES.md)
   - [User Stories](./3_requirements/USER_STORIES.md)

3. **Contribute your first fix**:
   - Pick a simple issue
   - Follow [Contributing Guide](./4_development/CONTRIBUTING.md)
   - Submit a pull request

4. **Explore the architecture**:
   - [Database Design](./2_architecture/DATABASE_DESIGN.md)
   - [API Reference](./3_requirements/API_REFERENCE.md)

---

## 📞 Getting Help

**Question**: Where should I look?

| Question | Answer |
|----------|--------|
| How do I set up my environment? | [Setup Guide](./1_getting-started/SETUP_GUIDE.md) |
| What's the coding style? | [Code Style Guide](./4_development/CODE_STYLE.md) |
| How do I contribute code? | [Contributing Guide](./4_development/CONTRIBUTING.md) |
| What APIs are available? | [API Reference](./3_requirements/API_REFERENCE.md) |
| How do I test my code? | [Test Strategy](./5_testing/TEST_STRATEGY.md) |
| Is there a quick reference? | [Quick Reference](./QUICK_REFERENCE.md) |
| Need the full index? | [Documentation Index](./INDEX.md) |

**Stuck?**
1. Check [Troubleshooting](#troubleshooting) above
2. Search [Documentation Index](./INDEX.md)
3. Ask your team lead
4. Check GitHub Issues

---

## 🎯 Success Checklist

After 30 minutes, you should be able to check:

- [ ] Java, Maven, Git installed and verified
- [ ] Project cloned and built successfully
- [ ] Development server running (localhost:8080)
- [ ] Explored project directory structure
- [ ] Read Project Overview
- [ ] Understand what IoT Bay does
- [ ] Created a feature branch
- [ ] Know where to find code style guide
- [ ] Know where to find help/documentation

---

## 📖 Full Documentation

For more details, see [Documentation Index](./INDEX.md) or [TABLE_OF_CONTENTS](./README.md).

---

**Version**: 1.0.0  
**Status**: Published  
**Maintained By**: IoT Bay Team  
**Last Updated**: December 3, 2025
