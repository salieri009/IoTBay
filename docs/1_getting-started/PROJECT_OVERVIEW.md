# Project Overview

Welcome to IoT Bay! This document provides an executive summary of the project, its goals, scope, and current status.

**Course**: 41025 Information Systems Development (ISD)  
**Assignment**: Assignment 2 - Autumn 2025  
**Institution**: University of Technology Sydney (UTS)  
**Version**: 1.0.0

---

## 🎯 Project Goal

Build a comprehensive e-commerce web application for IoT (Internet of Things) devices, enabling users to browse, purchase, review, and manage IoT products with a focus on scalability, security, and user experience.

---

## 📋 Project Scope

### What's Included ✅
- User registration, authentication, and profile management
- Product catalog with search, filtering, and categorization
- Shopping cart and checkout process
- Order management and history
- Product reviews and ratings
- Admin dashboard for management
- Data export capabilities (CSV, JSON)
- Security features (authentication, authorization, encryption)
- Responsive design (desktop, tablet, mobile)
- Accessibility compliance (WCAG 2.1 AA)

### What's Out of Scope ❌
- Mobile native app (responsive web only)
- Third-party payment processors (mock payment)
- Real-time notifications (future version)
- Multi-vendor marketplace (single vendor v1.0)
- Machine learning recommendations (future version)

---

## 🏗️ Technical Stack

### Backend
- **Language**: Java 8+
- **Framework**: Servlet/JSP
- **Build**: Maven 3.6+
- **Database**: SQLite (dev), PostgreSQL (production)
- **Testing**: JUnit 4, Mockito

### Frontend
- **Markup**: JSP, HTML5
- **Styling**: CSS3 with Atomic Design
- **Interactivity**: TypeScript/JavaScript (ES6+)
- **Icons**: SVG-based system

### DevOps
- **Server**: Jetty 9.4+
- **Build Tool**: Maven
- **Version Control**: Git
- **CI/CD**: GitHub Actions (optional)
- **Deployment**: Docker (optional)

---

## 📊 Project Status

| Area | Status | Completion |
|---|---|---|
| **Features** | ✅ Complete | 100% |
| **Backend** | ✅ Complete | 100% |
| **Frontend** | ✅ Complete | 100% |
| **Database** | ✅ Complete | 100% |
| **Testing** | ✅ Complete | 85% |
| **Documentation** | ✅ Complete | 100% |
| **Deployment Ready** | ✅ Yes | - |

---

## 👥 Key Stakeholders

| Role | Responsibility |
|---|---|
| **Project Manager** | Overall coordination |
| **Backend Team** | Java/Servlet development |
| **Frontend Team** | JSP/CSS/JavaScript |
| **QA Team** | Testing & quality |
| **Database Admin** | Database design & optimization |

---

## 🎓 Learning Outcomes

Upon completion, you will have:
- ✅ Built a full-stack web application
- ✅ Implemented authentication & authorization
- ✅ Designed a normalized database
- ✅ Created reusable UI components
- ✅ Tested for quality & accessibility
- ✅ Deployed to production
- ✅ Collaborated using Git & pull requests

---

## 📂 Quick Links

- **Getting Started**: [Setup Guide](./QUICKSTART.md)
- **Architecture**: [System Design](../2_architecture/README.md)
- **Features**: [Feature List](../3_requirements/FEATURES.md)
- **Development**: [Developer Guide](../4_development/README.md)
- **Testing**: [Test Strategy](../5_testing/README.md)

---

## 🔗 Key Documents

### For Developers
- [Quickstart](./QUICKSTART.md) - Get running in 10 minutes
- [Development Setup](./SETUP_GUIDE.md) - Detailed environment setup
- [Backend Guide](../4_development/BACKEND_GUIDE.md) - Backend patterns
- [Frontend Guide](../4_development/FRONTEND_GUIDE.md) - Frontend patterns
- [Git Workflow](../4_development/GIT_WORKFLOW.md) - Version control

### For Architects
- [Architecture Overview](../2_architecture/README.md) - System design
- [Component Architecture](../2_architecture/COMPONENT_ARCHITECTURE.md) - Component design
- [Database Design](../2_architecture/DATABASE_DESIGN.md) - Database schema
- [API Design](../2_architecture/API_DESIGN.md) - API endpoints

### For QA/Testing
- [Test Strategy](../5_testing/TEST_STRATEGY.md) - Overall testing approach
- [Error Prevention](../5_testing/ERROR_PREVENTION.md) - Preventing 403/404/500
- [Test Data](../5_testing/TEST_DATA.md) - Test data setup

### For Stakeholders
- [Features](../3_requirements/FEATURES.md) - What we're building
- [Project Status](../7_reports/PROJECT_STATUS.md) - Current status
- [Roadmap](../6_planning/PROJECT_ROADMAP.md) - Future plans

---

## 🚀 How to Get Started

1. **New to the project?**
   - Read this page (5 min)
   - Read [Quickstart](./QUICKSTART.md) (10 min)
   - Choose your role below

2. **I'm a Backend Developer**
   - Follow [Quickstart](./QUICKSTART.md)
   - Read [Backend Guide](../4_development/BACKEND_GUIDE.md)
   - Read [Database Design](../2_architecture/DATABASE_DESIGN.md)

3. **I'm a Frontend Developer**
   - Follow [Quickstart](./QUICKSTART.md)
   - Read [Frontend Guide](../4_development/FRONTEND_GUIDE.md)
   - Read [Component Architecture](../2_architecture/COMPONENT_ARCHITECTURE.md)

4. **I'm a QA Engineer**
   - Follow [Quickstart](./QUICKSTART.md)
   - Read [Test Strategy](../5_testing/TEST_STRATEGY.md)
   - Read [Error Prevention](../5_testing/ERROR_PREVENTION.md)

---

## 📞 Getting Help

| Question | Answer |
|---|---|
| How do I set up? | → [Setup Guide](./SETUP_GUIDE.md) |
| What's the tech stack? | → [Tech Stack](./TECH_STACK.md) |
| How do I contribute? | → [Contributing Guide](../4_development/CONTRIBUTING.md) |
| What are the features? | → [Features](../3_requirements/FEATURES.md) |
| How do I test? | → [Test Strategy](../5_testing/TEST_STRATEGY.md) |
| Git workflow help? | → [Git Workflow](../4_development/GIT_WORKFLOW.md) |

---

## 📋 Document Roadmap

Understand the documentation hierarchy:

```
docs/
├── Getting Started (1_getting-started/)         ← Start here
├── Architecture (2_architecture/)               ← System design
├── Requirements (3_requirements/)               ← Features
├── Development (4_development/)                 ← How to code
├── Testing (5_testing/)                         ← Quality assurance
├── Planning (6_planning/)                       ← Roadmaps
├── Reports (7_reports/)                         ← Status
└── Archive (8_archive/)                         ← Historical only
```

---

**Last Updated**: December 3, 2025  
**Version**: 1.0.0  
**Next Steps**: [Quick Start Guide](./QUICKSTART.md)
