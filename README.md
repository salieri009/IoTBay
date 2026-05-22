# IoTBay

IoT device e-commerce platform built with Java Servlets, JSP, and SQLite.

## Quick Start

```bash
# Start local server
mvn jetty:run

# Run all tests (server must be running)
mvn test
```

## Documentation

Full documentation is in the [`docs/`](docs/) directory:

- [Project Overview](docs/1_getting-started/PROJECT_OVERVIEW.md)
- [Quick Start Guide](docs/1_getting-started/QUICKSTART.md)
- [Architecture](docs/2_architecture/)
- [Testing Guide](docs/5_testing/E2E_TESTING.md)
- [Deployment](docs/4_development/deployment/)

## Tech Stack

- **Backend:** Java 11, Servlets, JSP, SQLite
- **Frontend:** Tailwind CSS, Vanilla JS
- **Server:** Jetty (dev), Tomcat (prod)
- **Testing:** JUnit 4, Selenium WebDriver 4
- **CI/CD:** GitHub Actions, Docker, GHCR
