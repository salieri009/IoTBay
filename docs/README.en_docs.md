# IoT Bay - Smart Technology Store

<div align="center">

[한국어](README.ko_docs.md) | English | [日本語](README.ja_docs.md)

</div>

---

## 📋 Project Information

**Course Code**: 41025  
**Course Name**: Introduction to Software Development  
**Credit Points**: 6 Credit Points  
**Assignment**: Assignment 2 - Autumn 2025  
**Institution**: University of Technology Sydney (UTS)  
**Project Type**: E-commerce Web Application for IoT Devices  
**Course Handbook**: [41025 - Introduction to Software Development](https://coursehandbook.uts.edu.au/subject/2026/41025)

---

## 📚 Course Information

This project is developed as part of **41025 - Introduction to Software Development** at the University of Technology Sydney (UTS).

- **Course Code**: 41025
- **Course Name**: Introduction to Software Development
- **Credit Points**: 6 Credit Points
- **Course Handbook**: [View Course Details](https://coursehandbook.uts.edu.au/subject/2026/41025)
- **Assignment**: Assignment 2 - Autumn 2025

A modern, responsive web application for IoT device management and e-commerce, developed as part of **UTS (University of Technology Sydney) academic coursework (41025 Introduction to Software Development - Assignment 2 Autumn 2025)**. Built with **JSP**, **Java MVC**, **Maven**, and **Jetty server**. Features a comprehensive design system, dark mode support, responsive grid layouts, and enterprise-grade security.

### Project Objectives

- Implement a fully functional e-commerce platform for IoT devices
- Demonstrate proficiency in JSP/Servlet web development
- Apply MVC architecture patterns
- Implement secure user authentication and authorization
- Create an intuitive and modern user interface
- Demonstrate database design and data access patterns
- Implement enterprise-grade security measures

---

## Table of Contents

- [Features](#features)
- [Quick Start](#quick-start)
- [Project Structure](#project-structure)
- [Design System](#design-system)
- [Security](#security)
- [Development](#development)
- [Configuration](#configuration)
- [Technology Stack](#technology-stack)
- [License](#license)

---

## Features

### Modern UI/UX Design
- **Responsive Design**: Mobile-first approach with custom CSS
- **Dark Mode**: Toggle between light and dark themes
- **Component-based Architecture**: Reusable JSP components
- **Grid Layouts**: Modern product grid systems
- **Interactive Elements**: Smooth animations and hover effects

### E-commerce Functionality
- **Product Categories**: Industrial, Warehouse, Agriculture, Smart Home
- **Product Browsing**: Advanced filtering and search
- **Shopping Cart**: Add to cart functionality
- **User Authentication**: Login/Register with role-based access
- **Order Management**: Order history and tracking

### User Management
- **Customer Accounts**: Profile management and order history
- **Staff Dashboard**: Administrative tools and analytics
- **Role-based Access**: Different permissions for customers and staff
- **Session Management**: Secure user sessions

### Admin Features
- **Staff Dashboard**: Analytics and reporting
- **User Management**: Customer and staff account management
- **Product Management**: Inventory and catalog management
- **Data Management**: System data administration

### Security Features
- **Server-Side Validation**: Comprehensive input validation
- **CSRF Protection**: Token-based protection
- **Rate Limiting**: Request throttling
- **Secure Error Handling**: Generic error messages
- **Security Logging**: Audit trail for security events

---

## Quick Start

### Prerequisites

- **Java JDK 8+** installed
- **Maven 3.6+** installed
- **Internet connection** for dependencies

### Installation & Setup

1. **Clone the Repository**
   ```bash
   git clone <repository-url>
   cd IoTBay
   ```

2. **Build the Project**
   ```bash
   mvn clean install
   ```

3. **Run the Application**
   ```bash
   mvn jetty:run
   ```

4. **Access the Application**
   ```
   http://localhost:8080/
   ```

### Default Login Credentials

#### Customer Account
- **Email**: `customer@iotbay.com`
- **Password**: `password123`

#### Staff Account
- **Email**: `staff@iotbay.com`
- **Password**: `staff123`

---

## Project Structure

```
IoTBay/
├── src/main/java/
│   ├── controller/           # Servlets (MVC Controllers)
│   ├── dao/                  # Data Access Objects
│   │   ├── stub/            # Stub implementations for testing
│   │   └── impl/            # Database implementations
│   ├── model/               # JavaBeans (User, Product, Order)
│   ├── service/             # Business Logic Layer
│   ├── utils/               # Utility classes (Security, Validation, Error Handling)
│   └── config/              # Configuration (DIContainer)
├── src/main/webapp/
│   ├── components/          # Reusable JSP components
│   │   ├── header.jsp       # Navigation header
│   │   ├── footer.jsp       # Site footer
│   │   └── layout/          # Layout templates
│   ├── css/
│   │   └── modern-theme.css # Main stylesheet with design system
│   ├── js/
│   │   └── main.js          # JavaScript functionality
│   ├── images/              # Static assets
│   ├── WEB-INF/
│   │   ├── web.xml          # Deployment descriptor
│   │   └── views/           # Protected JSP pages
│   └── *.jsp                # JSP pages
├── docs/                    # Project Documentation
│   ├── architecture/        # System design & decisions
│   ├── requirements/        # Features & specifications
│   ├── testing/             # Test strategies & audits
│   ├── development/         # Developer guides
│   ├── plans/               # Implementation plans
│   ├── reports/             # Status reports
│   └── archive/             # Historical data
└── pom.xml                  # Maven configuration
```

---

## Design System

### Color Palette
- **Primary**: Blue (#0a95ff)
- **Secondary**: Green (#22c55e)
- **Accent**: Orange (#f97316)
- **Neutral**: Gray scale (50-900)

### Typography
- **Font Family**: Inter (Google Fonts)
- **Headings**: Font weights 600-700
- **Body Text**: Font weight 400, line-height 1.6

### Components
- **Cards**: Rounded corners, subtle shadows
- **Buttons**: Multiple variants (primary, outline, ghost)
- **Forms**: Consistent styling with validation
- **Navigation**: Responsive with dropdown menus

### Responsive Breakpoints
- **Mobile**: < 768px
- **Tablet**: 768px - 1024px
- **Desktop**: 1024px - 1280px
- **Large Desktop**: > 1280px

---

## Security

### Enterprise-Grade Security Implementation

- **Input Validation**: Comprehensive server-side validation
- **XSS Prevention**: Enhanced sanitization of all user inputs
- **SQL Injection Prevention**: Parameterized queries
- **CSRF Protection**: Token-based protection
- **Rate Limiting**: Request throttling
- **Secure Error Handling**: Generic error messages
- **Security Logging**: Comprehensive audit trail

### Security Utilities

- `SecurityUtil`: Input validation, sanitization, CSRF token management
- `ErrorAction`: Consistent error handling
- `ValidationUtil`: Business logic validation

---

## Development

### Common Commands

| Task | Command | Description |
|------|---------|-------------|
| Clean | `mvn clean` | Remove build artifacts |
| Compile | `mvn compile` | Compile source code |
| Test | `mvn test` | Run unit tests |
| Package | `mvn package` | Create WAR file |
| Run | `mvn jetty:run` | Start development server |
| Stop | `Ctrl + C` | Stop the server |

---

## Configuration

### Port Configuration

Default port is **8080**. To change it, modify `pom.xml`:

```xml
<plugin>
    <groupId>org.eclipse.jetty</groupId>
    <artifactId>jetty-maven-plugin</artifactId>
    <configuration>
        <httpConnector>
            <port>8090</port>
        </httpConnector>
    </configuration>
</plugin>
```

### Database Configuration

Currently using **DAO Stubs** for development. To use a real database:

1. Update `src/main/resources/database.properties`
2. Implement database DAO classes in `src/main/java/dao/impl/`
3. Update `web.xml` servlet configurations

---

## Technology Stack

### Backend
- **Java**: JDK 8 or higher
- **JSP**: JavaServer Pages 2.3+
- **Servlets**: Java Servlet API 3.1+
- **Maven**: Build automation and dependency management
- **Jetty**: Embedded web server (development)
- **Architecture**: MVC (Model-View-Controller) Pattern
- **Data Access**: DAO (Data Access Object) Pattern

### Frontend
- **HTML5**: Semantic markup
- **CSS3**: Modern styling with CSS Custom Properties
- **JavaScript**: ES6+ for interactivity
- **Design System**: Custom CSS framework with component-based architecture
- **Responsive Design**: Mobile-first approach

### Database
- **SQLite**: Lightweight relational database (development)
- **JDBC**: Database connectivity
- **DAO Pattern**: Abstraction layer for data access

### Security
- **Password Hashing**: SHA-256 with salt
- **Session Management**: Secure session handling
- **Role-Based Access Control**: Customer, Staff, Admin roles
- **Input Validation**: SQL injection and XSS prevention
- **CSRF Protection**: Token-based protection
- **Rate Limiting**: Request throttling

---

## Assignment Requirements

### Functional Requirements

1. **User Management**
   - User registration and authentication
   - Profile management
   - Role-based access control (Customer, Staff, Admin)
   - Session management

2. **Product Management**
   - Product catalog with categories
   - Product search and filtering
   - Product details pages
   - Inventory management

3. **E-commerce Features**
   - Shopping cart functionality
   - Checkout process
   - Order management
   - Order history

4. **Administrative Features**
   - User management dashboard
   - Product management
   - Order processing
   - Access logging and analytics

### Technical Requirements

- MVC architecture implementation
- DAO pattern for data access
- Secure authentication and authorization
- Responsive web design
- Modern UI/UX following design system principles
- Error handling and validation
- Access logging for security auditing
- Server-side validation and security measures

### Design Requirements

- Consistent design system across all pages
- Responsive layout for mobile, tablet, and desktop
- Accessibility compliance (WCAG 2.1 AA)
- Dark mode support
- Modern, clean interface

---

## Development Guidelines

### Code Standards

- Follow Java naming conventions
- Use meaningful variable and method names
- Implement proper error handling
- Add comments for complex logic
- Maintain consistent code formatting

### Testing

- Test all user flows
- Verify authentication and authorization
- Test responsive design on multiple devices
- Validate form inputs
- Test error scenarios

### Documentation

- Maintain up-to-date README
- Document API endpoints
- Include inline code comments
- Update design system documentation

---

## License

This project is developed for **academic purposes** as part of **UTS 41025 Introduction to Software Development - Assignment 2 Autumn 2025**. All code and documentation are intended for educational use only.


---

**Document Version**: 1.0.0
**Status**: Published
**Last Updated**: 12�� 3, 2025
**Audience**: Developers, Stakeholders
**Maintained By**: IoT Bay Documentation Team
