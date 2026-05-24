<div align="center">

<img src="src/main/webapp/images/logo.png" alt="IoTBay" width="110" />

# IoTBay

**Full-stack e-commerce platform for IoT devices**

[![CI](https://github.com/salieri009/IoTBay/actions/workflows/ci.yml/badge.svg)](https://github.com/salieri009/IoTBay/actions/workflows/ci.yml)
[![Deploy](https://github.com/salieri009/IoTBay/actions/workflows/deploy.yml/badge.svg)](https://github.com/salieri009/IoTBay/actions/workflows/deploy.yml)
[![Java](https://img.shields.io/badge/Java-11-007396?logo=openjdk&logoColor=white)](https://openjdk.org/projects/jdk/11/)
[![SQLite](https://img.shields.io/badge/SQLite-3-003B57?logo=sqlite&logoColor=white)](https://www.sqlite.org/)
[![Docker](https://img.shields.io/badge/Docker-GHCR-2496ED?logo=docker&logoColor=white)](https://ghcr.io/salieri009/iotbay)
[![Tests](https://img.shields.io/badge/E2E_tests-118_passing-brightgreen?logo=selenium&logoColor=white)](src/test/java/e2e/)

Browse, purchase, and manage IoT devices — Smart Home, Industrial, Healthcare, and more.

[Quick Start](#quick-start) · [Features](#features) · [Tech Stack](#tech-stack) · [Docs](docs/)

</div>

---

## Features

<table>
<tr>
<td width="33%" valign="top">

**User & Auth**
- Registration with email validation
- SHA-256 salted password hashing
- Role-based access: Customer / Staff / Admin
- Session management & audit trail

</td>
<td width="33%" valign="top">

**Product Catalog**
- Full-text search with category, price & stock filters
- 6 product categories
- Paginated listing with sort controls

</td>
<td width="33%" valign="top">

**Shopping & Checkout**
- Persistent session cart
- Multi-step checkout with shipping options
- Payment history & order confirmation

</td>
</tr>
<tr>
<td width="33%" valign="top">

**Order Management**
- Full order lifecycle tracking
- Shipment creation & tracking numbers
- Customer order cancellation

</td>
<td width="33%" valign="top">

**Admin Dashboard**
- KPI overview — sales, users, products
- Product CRUD & user activation/deactivation
- Bulk data export (CSV & JSON)

</td>
<td width="33%" valign="top">

**Security**
- CSRF token validation
- SQL injection prevention (prepared statements)
- XSS output encoding
- Full access log

</td>
</tr>
</table>

---

## Quick Start

**Prerequisites:** Java 11+, Maven 3.6+

```bash
git clone https://github.com/salieri009/IoTBay.git
cd IoTBay
mvn jetty:run
```

Open [http://localhost:8080](http://localhost:8080).

```bash
# Run the full E2E test suite (server must be running)
mvn test
```

> **No Java?** Use Docker instead:
> ```bash
> docker compose up
> ```

---

## Tech Stack

<div align="center">

| Layer | Technology |
|---|---|
| **Backend** | ![Java Servlets](https://img.shields.io/badge/Java_Servlets-11-007396?logo=openjdk&logoColor=white) ![JSP](https://img.shields.io/badge/JSP%2FJSTL-1.2-FF6F00?logo=apachetomcat&logoColor=white) |
| **Database** | ![SQLite](https://img.shields.io/badge/SQLite-3-003B57?logo=sqlite&logoColor=white) |
| **Frontend** | ![Tailwind CSS](https://img.shields.io/badge/Tailwind_CSS-3-06B6D4?logo=tailwindcss&logoColor=white) ![TypeScript](https://img.shields.io/badge/TypeScript-ES6-3178C6?logo=typescript&logoColor=white) |
| **Server** | ![Jetty](https://img.shields.io/badge/Jetty-9.4_(dev)-00CED1) ![Tomcat](https://img.shields.io/badge/Tomcat-9_(prod)-F8DC75?logo=apachetomcat&logoColor=black) |
| **Testing** | ![JUnit](https://img.shields.io/badge/JUnit-4-25A162?logo=junit5&logoColor=white) ![Selenium](https://img.shields.io/badge/Selenium_WebDriver-4-43B02A?logo=selenium&logoColor=white) |
| **CI/CD** | ![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-CI%2FCD-2088FF?logo=githubactions&logoColor=white) ![Docker](https://img.shields.io/badge/Docker%2FGHCR-deploy-2496ED?logo=docker&logoColor=white) |

</div>

---

## Architecture

```mermaid
flowchart TD
    A[Browser] --> B[JSP Views]
    B --> C[Servlet Controllers]
    C --> D[Service Layer\nCart · Order · Product · User · Review]
    D --> E[DAO Layer\ninterface + impl per entity]
    E --> F[(SQLite)]
```

<details>
<summary>Domain model — 10 core entities</summary>

| Entity | Key Relationships |
|---|---|
| `User` | has many `Order`, `Review`, `CartItem`, `AccessLog` |
| `Product` | belongs to `Category`; has many `Review`, `OrderProduct` |
| `Order` | has many `OrderProduct`, one `Payment`, one `Shipment` |
| `CartItem` | links `User` → `Product` |
| `Review` | links `User` → `Product` |
| `Shipment` | belongs to `Order` |
| `Payment` | belongs to `Order` |
| `Supplier` | supplies `Product` |
| `AccessLog` | records every authenticated action |

</details>

<details>
<summary>Feature coverage — F01–F10 (118 E2E tests)</summary>

| ID | Feature | Tests |
|---|---|---|
| F01 | Access Log | 6 |
| F02 | Product Catalog | 10 |
| F03 | Order Management | 8 |
| F04 | Payment | 8 |
| F05 | Shipment | 12 |
| F06 | User Management | 10 |
| F07 | Customer Management | 12 |
| F08 | Staff Management | 12 |
| F09 | Supplier Management | 10 |
| F10 | Data Management (CSV/JSON) | 16 |
| — | Security Boundary Tests | 14 |
| **Total** | | **118** |

</details>

---

## Documentation

<details>
<summary>Full documentation index</summary>

| Section | Links |
|---|---|
| [Getting Started](docs/1_getting-started/) | [Project Overview](docs/1_getting-started/PROJECT_OVERVIEW.md) · [Quick Start](docs/1_getting-started/QUICKSTART.md) · [Setup Guide](docs/1_getting-started/SETUP_GUIDE.md) |
| [Architecture](docs/2_architecture/) | [Components](docs/2_architecture/COMPONENT_ARCHITECTURE.md) · [Database Design](docs/2_architecture/DATABASE_DESIGN.md) · [Security Architecture](docs/2_architecture/SECURITY_ARCHITECTURE.md) |
| [Requirements](docs/3_requirements/) | [Features](docs/3_requirements/FEATURES.md) · [User Stories](docs/3_requirements/USER_STORIES.md) · [API Reference](docs/3_requirements/API_REFERENCE.md) |
| [Development](docs/4_development/) | [Backend Guide](docs/4_development/BACKEND_GUIDE.md) · [Frontend Guide](docs/4_development/FRONTEND_GUIDE.md) · [Contributing](docs/4_development/CONTRIBUTING.md) |
| [Deployment](docs/4_development/deployment/) | [Docker Setup](docs/4_development/deployment/DOCKER_SETUP.md) · [Local](docs/4_development/deployment/LOCAL_DEPLOYMENT.md) · [Production](docs/4_development/deployment/PRODUCTION_DEPLOYMENT.md) |
| [Testing](docs/5_testing/) | [E2E Guide](docs/5_testing/E2E_TESTING.md) · [Test Strategy](docs/5_testing/TEST_STRATEGY.md) · [Test Data](docs/5_testing/TEST_DATA.md) |

</details>

---

<div align="center">
Java Servlets · JSP · SQLite · Tailwind CSS · Selenium WebDriver<br/>
297 commits · 8 contributors · 111 source files · 118 E2E tests

<sub>UTS 41025 Internet Software Development — Autumn 2025 (Semester 1, 2025)</sub>
</div>
