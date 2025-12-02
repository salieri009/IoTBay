# Development Guide

This section contains everything developers need to contribute to the IoT Bay project, including setup guides, coding standards, contribution workflows, and deployment procedures.

---

## 📚 Development Documents

| Document | Purpose | Audience |
|---|---|---|
| [Contributing](./CONTRIBUTING.md) | How to contribute code | All developers |
| [Git Workflow](./GIT_WORKFLOW.md) | Git branching & commit strategy | All developers |
| [Backend Guide](./BACKEND_GUIDE.md) | Backend development practices | Backend developers |
| [Frontend Guide](./FRONTEND_GUIDE.md) | Frontend development practices | Frontend developers |
| [Database Setup](./DATABASE_SETUP.md) | Database configuration | Backend developers |
| [Code Style](./CODE_STYLE.md) | Code standards & conventions | All developers |
| [Debugging Guide](./DEBUGGING_GUIDE.md) | Troubleshooting & debugging | All developers |
| [Deployment](./deployment/) | Local, staging, production | DevOps, all developers |

---

## 🚀 Developer Onboarding

### Step 1: Set Up Environment (20 min)
```bash
# Clone repository
git clone https://github.com/salieri009/IoTBay.git
cd IoTBay

# Install dependencies
mvn clean install

# Run application
mvn jetty:run

# Visit http://localhost:8080
```

### Step 2: Understand Code Structure
- Read [Backend Guide](./BACKEND_GUIDE.md) for Java structure
- Read [Frontend Guide](./FRONTEND_GUIDE.md) for JSP/CSS structure
- Review [Architecture](../2_architecture/)

### Step 3: Learn Contribution Process
- Read [Contributing](./CONTRIBUTING.md)
- Learn [Git Workflow](./GIT_WORKFLOW.md)
- Check [Code Style](./CODE_STYLE.md)

### Step 4: Make Your First Contribution
- Create feature branch: `git checkout -b feat/my-feature`
- Write code following [Code Style](./CODE_STYLE.md)
- Commit with proper message format (see [Contributing](./CONTRIBUTING.md))
- Push and create pull request

---

## 🛠️ Development Tools

| Tool | Purpose | Version |
|---|---|---|
| Java | Backend language | 8+ |
| Maven | Build tool | 3.6+ |
| Eclipse/IntelliJ | IDE | Latest |
| SQLite | Development DB | 3.x |
| Jetty | Application server | 9.4+ |
| Git | Version control | 2.x |
| Node.js | TypeScript compilation | 14+ (optional) |

---

## 📖 Recommended Reading Paths

### Backend Developer Setup
1. [Backend Guide](./BACKEND_GUIDE.md) - Architecture & patterns
2. [Database Setup](./DATABASE_SETUP.md) - Database configuration
3. [Code Style](./CODE_STYLE.md) - Java conventions
4. [Contributing](./CONTRIBUTING.md) - Workflow

### Frontend Developer Setup
1. [Frontend Guide](./FRONTEND_GUIDE.md) - JSP & component structure
2. [Code Style](./CODE_STYLE.md) - CSS/JSP conventions
3. [Contributing](./CONTRIBUTING.md) - Workflow

### Full-Stack Developer Setup
1. [Backend Guide](./BACKEND_GUIDE.md)
2. [Frontend Guide](./FRONTEND_GUIDE.md)
3. [Database Setup](./DATABASE_SETUP.md)
4. [Contributing](./CONTRIBUTING.md)

---

## 🔄 Common Development Tasks

### Running Tests
```bash
mvn test                          # Run all tests
mvn test -Dtest=UserDAOTest      # Run specific test
mvn test -DargLine="-X"          # Debug tests
```

### Building for Deployment
```bash
mvn clean package                 # Build WAR file
# Output: target/iot-bay.war
```

### Deploying Locally
```bash
mvn jetty:run                     # Start development server
# Visit: http://localhost:8080
```

### Debugging
See [Debugging Guide](./DEBUGGING_GUIDE.md) for:
- Remote debugging setup
- Common error solutions
- Performance profiling

---

## 📋 Commit Message Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Example**:
```
feat(auth): add password reset functionality

Users can now reset their passwords by answering security questions.
This implements the password recovery feature specified in FR-001.

Closes #123
```

See [Contributing](./CONTRIBUTING.md) for full guidelines.

---

## 🚀 Deployment

### Local Development
→ [Local Deployment Guide](./deployment/LOCAL_DEPLOYMENT.md)

### Production
→ [Production Deployment Guide](./deployment/PRODUCTION_DEPLOYMENT.md)

### Docker
→ [Docker Setup Guide](./deployment/DOCKER_SETUP.md)

---

## 🆘 Getting Help

| Issue | Resource |
|---|---|
| Setup problems | [Debugging Guide](./DEBUGGING_GUIDE.md) |
| Code questions | [Code Style](./CODE_STYLE.md) |
| Git issues | [Git Workflow](./GIT_WORKFLOW.md) |
| Database issues | [Database Setup](./DATABASE_SETUP.md) |
| General debugging | [Debugging Guide](./DEBUGGING_GUIDE.md) |

---

**Last Updated**: December 3, 2025  
**Version**: 1.0.0
