# IoT Bay - Smart Technology Store

<div align="center">

한국어 | [English](README.en.md) | [日本語](README.ja.md)

</div>

---

## 📋 Project Information

**Course**: 41025 Information Systems Development (ISD)  
**Assignment**: Assignment 2 - Autumn 2025  
**Institution**: University of Technology Sydney (UTS)  
**Project Type**: E-commerce Web Application for IoT Devices

---

## Overview

A modern, responsive web application for IoT device management and e-commerce, developed as part of **UTS (University of Technology Sydney) academic coursework (41025 ISD Assignment 2 Autumn 2025)**. Built with **JSP**, **Java MVC**, **Maven**, and **Jetty server**. Features a comprehensive design system, dark mode support, and responsive grid layouts.

**Core Features**: E-commerce platform with product browsing, shopping cart, user authentication, order management, and administrative dashboard for IoT device sales.

### Project Objectives

- Implement a fully functional e-commerce platform for IoT devices
- Demonstrate proficiency in JSP/Servlet web development
- Apply MVC architecture patterns
- Implement secure user authentication and authorization
- Create an intuitive and modern user interface
- Demonstrate database design and data access patterns

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
│   ├── controller/           # Servlets (LoginController, etc.)
│   ├── dao/                  # Data Access Objects
│   │   ├── stub/            # Stub implementations for testing
│   │   └── impl/            # Database implementations
│   └── model/               # JavaBeans (User, Product, Order)
├── src/main/webapp/
│   ├── components/          # Reusable JSP components
│   ├── css/                # Stylesheets
│   ├── js/                 # JavaScript functionality
│   └── *.jsp               # JSP pages
├── design plan/            # Design system documentation
└── pom.xml                 # Maven configuration
```

---

## Tech Stack

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

This project is developed for **academic purposes** as part of **UTS 41025 ISD Assignment 2 Autumn 2025**. All code and documentation are intended for educational use only.

---

## Documentation

- [English Documentation](README.en.md) - Full documentation in English
- [한국어 문서](README.ko.md) - 한국어 전체 문서
- [日本語ドキュメント](README.ja.md) - 日本語完全ドキュメント
