# Technology Stack

Overview of technologies, frameworks, and tools used in IoT Bay.

---

## 📦 Tech Stack Overview

```
Frontend Layer (JSP/CSS/TypeScript)
    ↓
Servlet/Controller Layer (Java)
    ↓
Service/Business Logic (Java)
    ↓
Data Access Layer (DAO Pattern)
    ↓
Database (SQLite/PostgreSQL)
```

---

## 🔧 Backend Technologies

### Core Language & Framework
| Technology | Version | Purpose |
|---|---|---|
| **Java** | 8+ | Backend language |
| **Servlet API** | 3.1 | Request/response handling |
| **JSP** | 2.3 | Server-side templates |

### Build & Dependency Management
| Technology | Version | Purpose |
|---|---|---|
| **Maven** | 3.6+ | Build and dependency management |
| **pom.xml** | - | Project configuration |

### Database
| Technology | Version | Purpose |
|---|---|---|
| **SQLite** | 3.x | Development database |
| **PostgreSQL** | 13+ | Production database (optional) |
| **JDBC** | 4.2+ | Database connectivity |

### Testing
| Technology | Version | Purpose |
|---|---|---|
| **JUnit** | 4.13+ | Unit testing framework |
| **Mockito** | 2.x+ | Mocking library |

### Logging
| Technology | Version | Purpose |
|---|---|---|
| **SLF4J** | 1.7+ | Logging facade |
| **Logback** | 1.2+ | Logging implementation |

---

## 🎨 Frontend Technologies

### Markup & Templating
| Technology | Version | Purpose |
|---|---|---|
| **HTML5** | - | Page structure |
| **JSP** | 2.3 | Dynamic content |
| **JSTL** | 1.2 | Tag library |

### Styling
| Technology | Version | Purpose |
|---|---|---|
| **CSS3** | - | Styling & layout |
| **Flexbox** | - | Layout system |
| **Grid** | - | Layout system |
| **Atomic Design** | - | Component organization |

### Interactivity
| Technology | Version | Purpose |
|---|---|---|
| **JavaScript** | ES6+ | Client-side logic |
| **TypeScript** | 5.3+ | Type-safe JavaScript |
| **Fetch API** | - | AJAX requests |

### Design & Icons
| Technology | Version | Purpose |
|---|---|---|
| **SVG** | - | Vector graphics |
| **CSS Animations** | - | Visual effects |
| **Responsive Design** | - | Mobile support |

---

## 🚀 Server & Deployment

### Application Server
| Technology | Version | Purpose |
|---|---|---|
| **Jetty** | 9.4+ | Embedded web server (dev) |
| **WAR Format** | - | Deployable package |

### Containers (Optional)
| Technology | Version | Purpose |
|---|---|---|
| **Docker** | 20+ | Containerization |
| **Docker Compose** | 2+ | Multi-container orchestration |

---

## 🛠️ Development Tools

### IDE Support
- **Eclipse**: Full support via Maven integration
- **IntelliJ IDEA**: Full support via Maven integration
- **Visual Studio Code**: Java extensions + Maven

### Version Control
| Technology | Purpose |
|---|---|
| **Git** | Version control system |
| **GitHub** | Repository hosting |

### Build Commands
```bash
# Build
mvn clean install

# Run tests
mvn test

# Run application
mvn jetty:run

# Build WAR file
mvn clean package
```

---

## 📊 Architecture Pattern

### Model-View-Controller (MVC)

```
Request
    ↓
Controller (HttpServlet)
    ↓ 
Service (Business Logic)
    ↓
DAO (Data Access)
    ↓
Database
    ↓
DAO returns Entity
    ↓
Service processes Entity
    ↓
Controller forwards to JSP (View)
    ↓
JSP renders HTML
    ↓
Response to Browser
```

### Data Access Object (DAO) Pattern

```
Interface
    ↓
┌─────────────────┐
│ Implementation  │ ← Database queries
│    Classes      │
└─────────────────┘
    ↓
Entity Classes
    ↓
Database
```

---

## 🔐 Security Technologies

### Authentication
- Session-based authentication
- Password hashing (SHA-256 + salt)

### Authorization
- Role-Based Access Control (RBAC)
- Resource-level permissions

### Data Protection
- SQL injection prevention (prepared statements)
- XSS prevention (output encoding)
- CSRF protection (token validation)

---

## 📈 Development Workflow

```
Developer
    ↓
Git Branch (feat/feature-name)
    ↓
Maven Build (mvn clean install)
    ↓
Run Tests (mvn test)
    ↓
Git Commit (proper message format)
    ↓
Push to GitHub
    ↓
Create Pull Request
    ↓
Code Review
    ↓
Merge to main
    ↓
Automated Build & Test (CI/CD)
    ↓
Deploy
```

---

## 💻 System Requirements

### Minimum
- **Java**: 8 or higher
- **Maven**: 3.6 or higher
- **RAM**: 2 GB
- **Disk**: 500 MB
- **OS**: Windows, macOS, Linux

### Recommended
- **Java**: 11 or higher
- **Maven**: 3.8 or higher
- **RAM**: 4+ GB
- **Disk**: 1 GB
- **IDE**: Eclipse or IntelliJ IDEA

---

## 📦 Key Dependencies

### Backend
- `javax.servlet-api` - Servlet specification
- `gson` - JSON processing
- `sqlite-jdbc` - SQLite driver
- `jstl-api` - JSP tag library
- `junit` - Testing framework
- `mockito` - Mocking library

### Installed via Maven
View complete list in `pom.xml` file.

---

## 🔗 Related Documentation

- [Setup Guide](./SETUP_GUIDE.md)
- [Backend Guide](../4_development/BACKEND_GUIDE.md)
- [Frontend Guide](../4_development/FRONTEND_GUIDE.md)
- [Architecture](../2_architecture/README.md)

---

**Last Updated**: December 3, 2025  
**Version**: 1.0.0
