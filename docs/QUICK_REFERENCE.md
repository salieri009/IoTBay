# Quick Reference Card

Fast lookup for common tasks and documentation locations.

---

## 🎯 I Want To...

### Start Contributing
**Time**: 10 minutes  
**Path**: [Getting Started](./1_getting-started/README.md) → [Quickstart](./1_getting-started/QUICKSTART.md) → [Contributing](./4_development/CONTRIBUTING.md)

### Understand the Architecture
**Time**: 20 minutes  
**Path**: [Project Overview](./1_getting-started/PROJECT_OVERVIEW.md) → [Architecture](./2_architecture/README.md) → [Component Architecture](./2_architecture/COMPONENT_ARCHITECTURE.md)

### Build a Backend Feature
**Time**: 30 minutes  
**Path**: [Backend Guide](./4_development/BACKEND_GUIDE.md) → [Database Design](./2_architecture/DATABASE_DESIGN.md) → [Code Style](./4_development/CODE_STYLE.md)

### Build a Frontend Component
**Time**: 30 minutes  
**Path**: [Frontend Guide](./4_development/FRONTEND_GUIDE.md) → [Component Architecture](./2_architecture/COMPONENT_ARCHITECTURE.md) → [Code Style](./4_development/CODE_STYLE.md)

### Fix a Bug
**Time**: 20 minutes  
**Path**: [Debugging Guide](./4_development/DEBUGGING_GUIDE.md) → [Error Prevention](./5_testing/ERROR_PREVENTION.md) → [Test Strategy](./5_testing/TEST_STRATEGY.md)

### Write Tests
**Time**: 20 minutes  
**Path**: [Test Strategy](./5_testing/TEST_STRATEGY.md) → [Backend Guide](./4_development/BACKEND_GUIDE.md#testing) → [Error Prevention](./5_testing/ERROR_PREVENTION.md)

### Check API Endpoints
**Time**: 5 minutes  
**Path**: [API Reference](./3_requirements/API_REFERENCE.md)

### Understand User Stories
**Time**: 10 minutes  
**Path**: [Features](./3_requirements/FEATURES.md) → [User Stories](./3_requirements/USER_STORIES.md)

### Deploy to Production
**Time**: 30 minutes  
**Path**: [Deployment](./4_development/deployment/PRODUCTION_DEPLOYMENT.md)

### Setup Local Environment
**Time**: 20 minutes  
**Path**: [Setup Guide](./1_getting-started/SETUP_GUIDE.md)

---

## 📚 Documentation Map

```
You Are Here: Quick Reference Card

Main Navigation:
├── 1️⃣ Getting Started (Onboarding)
│   ├── Project Overview - What is this?
│   ├── Quickstart - Get running in 10 min
│   ├── Tech Stack - What technologies?
│   └── Setup Guide - Detailed environment setup
│
├── 2️⃣ Architecture (System Design)
│   ├── Component Architecture - Frontend structure
│   └── Database Design - Schema & relationships
│
├── 3️⃣ Requirements (What to Build)
│   ├── Features - Complete feature list
│   ├── User Stories - User requirements
│   ├── API Reference - API contracts
│   └── Acceptance Criteria - Feature specs
│
├── 4️⃣ Development (How to Build)
│   ├── Backend Guide - Backend patterns
│   ├── Frontend Guide - Frontend patterns
│   ├── Code Style - Coding standards
│   ├── Contributing - Contribution workflow
│   ├── Git Workflow - Git strategy
│   └── Deployment - Deploy procedures
│
├── 5️⃣ Testing (Quality Assurance)
│   ├── Test Strategy - Testing approach
│   └── Error Prevention - Common errors
│
├── 6️⃣ Planning (Roadmap & Migrations)
│
├── 7️⃣ Reports (Project Status)
│
└── 8️⃣ Archive (Legacy Reference)
```

---

## 🔧 Common Commands

### Setup & Build
```bash
# Initial setup
git clone https://github.com/salieri009/IoTBay.git
cd IoTBay
mvn clean install

# Run application
mvn jetty:run

# Run on different port
mvn jetty:run -Djetty.port=9090
```

### Testing
```bash
# Run all tests
mvn test

# Run specific test
mvn test -Dtest=ProductServiceTest

# Run with coverage
mvn test jacoco:report
```

### Git Workflow
```bash
# Create feature branch
git checkout -b feat/feature-name

# Commit with proper format
git commit -m "feat(scope): brief description"

# Create pull request
# (push and create PR on GitHub)

# Merge after approval
git checkout develop
git pull origin develop
git merge feat/feature-name
git push origin develop
```

---

## 📋 Checklist Before Pushing Code

- [ ] Code follows [Code Style](./4_development/CODE_STYLE.md) guide
- [ ] All unit tests pass (`mvn test`)
- [ ] Code coverage maintained (≥80%)
- [ ] Commit message follows format (see [Contributing](./4_development/CONTRIBUTING.md))
- [ ] Branch is up to date with develop
- [ ] No compiler warnings
- [ ] Documentation updated if needed

---

## 🚨 Common Problems

### Port 8080 Already in Use
```bash
mvn jetty:run -Djetty.port=8081
```
[More help](./4_development/GIT_WORKFLOW.md#troubleshooting)

### Build Fails with "Dependencies Not Found"
```bash
mvn clean install -U
```

### Tests Failing
```bash
# Run single test
mvn test -Dtest=FailingTest -X

# Check [Test Strategy](./5_testing/TEST_STRATEGY.md)
```

### Can't Connect to Database
Check [Database Setup](./4_development/DATABASE_SETUP.md)

### Git Merge Conflict
See [Git Workflow - Troubleshooting](./4_development/GIT_WORKFLOW.md#conflict-resolution)

---

## 📖 Documentation Structure

### By Role

**Backend Developer**
1. [Backend Guide](./4_development/BACKEND_GUIDE.md)
2. [Database Design](./2_architecture/DATABASE_DESIGN.md)
3. [API Reference](./3_requirements/API_REFERENCE.md)

**Frontend Developer**
1. [Frontend Guide](./4_development/FRONTEND_GUIDE.md)
2. [Component Architecture](./2_architecture/COMPONENT_ARCHITECTURE.md)
3. [Code Style](./4_development/CODE_STYLE.md)

**QA Engineer**
1. [Test Strategy](./5_testing/TEST_STRATEGY.md)
2. [Features](./3_requirements/FEATURES.md)
3. [Error Prevention](./5_testing/ERROR_PREVENTION.md)

**DevOps**
1. [Deployment](./4_development/deployment/PRODUCTION_DEPLOYMENT.md)
2. [Docker Setup](./4_development/deployment/DOCKER_SETUP.md)

**Project Manager**
1. [Project Overview](./1_getting-started/PROJECT_OVERVIEW.md)
2. [Features](./3_requirements/FEATURES.md)
3. [User Stories](./3_requirements/USER_STORIES.md)

---

## 🔗 Direct Links to Key Documents

| Need | Link | Read Time |
|---|---|---|
| API Endpoints | [API Reference](./3_requirements/API_REFERENCE.md) | 10 min |
| Database Schema | [Database Design](./2_architecture/DATABASE_DESIGN.md) | 15 min |
| Code Standards | [Code Style](./4_development/CODE_STYLE.md) | 15 min |
| Contributing | [Contributing Guide](./4_development/CONTRIBUTING.md) | 10 min |
| Error Handling | [Error Prevention](./5_testing/ERROR_PREVENTION.md) | 20 min |
| Backend Dev | [Backend Guide](./4_development/BACKEND_GUIDE.md) | 30 min |
| Frontend Dev | [Frontend Guide](./4_development/FRONTEND_GUIDE.md) | 30 min |
| Testing | [Test Strategy](./5_testing/TEST_STRATEGY.md) | 25 min |

---

## ⚡ 5-Minute Essentials

### Project at a Glance
- **Type**: Full-stack Java/JSP e-commerce platform
- **Architecture**: MVC with 5 layers (Servlet → Service → DAO)
- **Backend**: Java 8+, Maven, Servlet/JSP
- **Frontend**: JSP, HTML5, CSS3, JavaScript
- **Database**: SQLite (dev), PostgreSQL (prod)
- **Design**: Atomic Design system

### Key Technologies
- Backend: Java, Servlet, Maven
- Frontend: JSP, CSS3, JavaScript
- Database: SQLite (dev), PostgreSQL (prod)
- Server: Jetty 9.4+
- Version Control: Git

### Project Structure
```
src/main/java/iotbay/
├── servlet/        # HTTP Controllers
├── service/        # Business Logic
├── dao/            # Database Access
├── model/          # Data Objects
└── util/           # Helpers

src/main/webapp/
├── assets/         # CSS, JS, Images
├── WEB-INF/views/  # JSP Templates
└── index.jsp       # Home Page
```

---

## 🆘 Need Help?

1. **Question about docs?** → [Getting Started](./1_getting-started/README.md)
2. **How to code?** → [Code Style](./4_development/CODE_STYLE.md)
3. **How to test?** → [Test Strategy](./5_testing/TEST_STRATEGY.md)
4. **How to contribute?** → [Contributing](./4_development/CONTRIBUTING.md)
5. **Problem debugging?** → [Debugging Guide](./4_development/DEBUGGING_GUIDE.md)
6. **How to deploy?** → [Deployment](./4_development/deployment/)

---

## 📞 Support

- **Architecture Questions**: Check [Architecture](./2_architecture/README.md)
- **Code Pattern Questions**: Check [Backend Guide](./4_development/BACKEND_GUIDE.md) or [Frontend Guide](./4_development/FRONTEND_GUIDE.md)
- **API Questions**: Check [API Reference](./3_requirements/API_REFERENCE.md)
- **Testing Questions**: Check [Test Strategy](./5_testing/TEST_STRATEGY.md)

---

**Last Updated**: December 3, 2025  
**Quick Ref Version**: 1.0.0

🔗 **[Back to Main Docs](./README.md)**
