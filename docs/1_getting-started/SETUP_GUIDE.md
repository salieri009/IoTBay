# Setup & Environment Configuration

Detailed guide for setting up your development environment for IoT Bay.

---

## Prerequisites

### System Requirements
- **OS**: Windows 10+, macOS 10.14+, or Linux (Ubuntu 18.04+)
- **RAM**: Minimum 2GB, Recommended 4GB+
- **Disk Space**: Minimum 1GB, Recommended 2GB+
- **Internet**: Required for Maven dependency download

### Required Software
| Software | Version | Purpose |
|---|---|---|
| Java Development Kit | 8+ | Backend development |
| Maven | 3.6+ | Build and dependency management |
| Git | 2.x | Version control |

### Optional Software
| Software | Purpose |
|---|---|
| IDE (Eclipse/IntelliJ) | Development environment |
| Docker | Containerization |
| PostgreSQL | Production database |

---

## Installation Guide

### Windows

#### Java
1. Download from [Oracle JDK](https://www.oracle.com/java/technologies/javase-downloads.html)
2. Run installer, follow prompts
3. Add to PATH environment variable
4. Verify: Open PowerShell, run `java -version`

#### Maven
1. Download from [Apache Maven](https://maven.apache.org/download.cgi)
2. Extract to preferred location (e.g., `C:\maven`)
3. Add to PATH environment variable
4. Verify: Open PowerShell, run `mvn -version`

#### Git
1. Download from [Git for Windows](https://git-scm.com/download/win)
2. Run installer, use default options
3. Verify: Open PowerShell, run `git --version`

### macOS

#### Using Homebrew (Recommended)
```bash
# Install Homebrew if needed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Java
brew install openjdk@11

# Install Maven
brew install maven

# Install Git
brew install git
```

#### Manual Installation
Follow Windows steps above, using macOS downloads.

### Linux (Ubuntu)

```bash
# Update package manager
sudo apt-get update

# Install Java
sudo apt-get install openjdk-11-jdk

# Install Maven
sudo apt-get install maven

# Install Git
sudo apt-get install git

# Verify
java -version
mvn -version
git --version
```

---

## IDE Setup

### Eclipse

1. Download from [eclipse.org](https://www.eclipse.org/downloads/)
2. Install Eclipse IDE for Enterprise Java Developers
3. Import project as Maven project:
   - File → Import → Maven → Existing Maven Projects
   - Select IoTBay root directory
   - Click Finish

### IntelliJ IDEA

1. Download from [jetbrains.com](https://www.jetbrains.com/idea/)
2. Install (Community Edition or Professional)
3. Open project:
   - File → Open → Select IoTBay directory
   - Trust project, wait for indexing

### Visual Studio Code

1. Install [VS Code](https://code.visualstudio.com/)
2. Install extensions:
   - Extension Pack for Java
   - Maven for Java
   - REST Client
3. Open IoTBay folder

---

## Project Configuration

### Clone Repository

```bash
# Navigate to desired location
cd ~/Projects

# Clone repository
git clone https://github.com/salieri009/IoTBay.git

# Navigate to project
cd IoTBay
```

### Configure Maven

```bash
# Update Maven settings (if needed)
# File: ~/.m2/settings.xml (Linux/Mac) or %USERPROFILE%\.m2\settings.xml (Windows)

# First build (downloads all dependencies)
mvn clean install
```

### Database Setup

**Development (SQLite)**:
```bash
# SQLite is file-based, no setup needed
# Database file: iotbay.db (created on first run)
```

**Production (PostgreSQL)**:
```bash
# Create database
createdb iotbay

# Create user
createuser -P iotbay_user

# Grant privileges
psql -d iotbay -c "GRANT ALL PRIVILEGES ON DATABASE iotbay TO iotbay_user;"
```

---

## First Run

### 1. Build Application

```bash
mvn clean install
```

Output should end with: `BUILD SUCCESS`

### 2. Run Application

```bash
mvn jetty:run
```

Output should show: `Started Jetty Server`

### 3. Access Application

- Open browser: `http://localhost:8080`
- You should see the IoT Bay homepage

### 4. Stop Application

- Press `Ctrl+C` in terminal

---

## Troubleshooting

### Java not recognized
```bash
# Windows - Set JAVA_HOME
set JAVA_HOME=C:\Program Files\Java\jdk1.8.0_xxx
set PATH=%JAVA_HOME%\bin;%PATH%

# Linux/Mac - Add to ~/.bashrc or ~/.zshrc
export JAVA_HOME=/usr/libexec/java_home -v 11
export PATH=$JAVA_HOME/bin:$PATH
```

### Maven not found
```bash
# Verify installation
mvn -version

# If not found, add to PATH
# Windows: Control Panel → System → Environment Variables
# Linux/Mac: Add to ~/.bashrc or ~/.zshrc
```

### Port 8080 in use
```bash
# Use different port
mvn jetty:run -Djetty.port=8081

# Visit http://localhost:8081
```

### Build failures
```bash
# Update dependencies
mvn clean install -U

# Force update
mvn -DarchetypeRepository=https://repo1.maven.org/maven2 clean install

# Check Java version
java -version  # Must be 8+
```

---

## Common Commands

```bash
# Clean build
mvn clean install

# Run tests
mvn test

# Run application
mvn jetty:run

# Run on different port
mvn jetty:run -Djetty.port=9090

# Build WAR file
mvn clean package

# Skip tests (faster build)
mvn clean install -DskipTests

# View dependency tree
mvn dependency:tree

# Update Maven settings
mvn -DarchetypeRepository=https://repo1.maven.org/maven2 clean install
```

---

## Verification

### Successful Setup
You'll know setup is successful when:
- [ ] `mvn clean install` completes with `BUILD SUCCESS`
- [ ] `mvn jetty:run` starts without errors
- [ ] Browser shows IoT Bay homepage at `http://localhost:8080`
- [ ] Tests pass with `mvn test`

### Next Steps
- Read [Project Overview](./PROJECT_OVERVIEW.md)
- Choose your role: [Backend](../4_development/BACKEND_GUIDE.md), [Frontend](../4_development/FRONTEND_GUIDE.md), or [QA](../5_testing/TEST_STRATEGY.md)

---

**Last Updated**: December 3, 2025  
**Version**: 1.0.0


---

**Document Version**: 1.0.0
**Status**: Published
**Audience**: Developers, Stakeholders
**Maintained By**: IoT Bay Documentation Team
