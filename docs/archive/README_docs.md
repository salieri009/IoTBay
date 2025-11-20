<div align="center">

![Header](https://capsule-render.vercel.app/api?type=waving&color=0:0a95ff,100:22c55e&height=200&section=header&text=IoTBay&fontSize=80&fontColor=ffffff&fontAlignY=35&desc=Smart%20Technology%20Store%20for%20IoT%20Devices&descAlignY=65&descSize=24&animation=fadeIn)

**Technical Sophistication Meets User-Friendly Design**

[![Language](https://img.shields.io/badge/Language-Korean-blue)](README.ko.md)
[![English](https://img.shields.io/badge/English-Documentation-green)](README.en.md)
[![日本語](https://img.shields.io/badge/日本語-ドキュメント-orange)](README.ja.md)

</div>

---

<div align="center">

## 📋 Project Information

**Course Code**: 41025  
**Course Name**: Introduction to Software Development  
**Credit Points**: 6 Credit Points  
**Assignment**: Assignment 2 - Autumn 2025  
**Institution**: University of Technology Sydney (UTS)  
**Project Type**: E-commerce Web Application for IoT Devices  
**Course Handbook**: [41025 - Introduction to Software Development](https://coursehandbook.uts.edu.au/subject/2026/41025)

[![Java](https://img.shields.io/badge/Java-8+-ED8B00?style=flat&logo=java&logoColor=white)](https://www.java.com/)
[![JSP](https://img.shields.io/badge/JSP-2.3+-orange?style=flat)](https://www.oracle.com/java/technologies/jspt.html)
[![Maven](https://img.shields.io/badge/Maven-3.6+-C71A36?style=flat&logo=apache-maven&logoColor=white)](https://maven.apache.org/)

</div>

---

## 🚀 Overview

A modern, responsive **e-commerce platform** specifically designed for **Internet of Things (IoT) devices and components**. Built with **JSP**, **Java MVC**, **Maven**, and **Jetty server**, featuring a comprehensive design system, dark mode support, and WCAG 2.1 AA accessibility compliance.

**Core Philosophy**: Technical sophistication meets user-friendly design, ensuring complex IoT product information is presented in an intuitive, accessible, and trustworthy manner.

### ✨ Key Features

- 🛒 **Full E-commerce Functionality**: Product browsing, shopping cart, checkout, and order management
- 🔐 **Secure Authentication**: Role-based access control (Customer, Staff, Admin) with enterprise-grade security
- 📱 **Responsive Design**: Mobile-first approach with modern UI/UX
- 🌙 **Dark Mode**: Complete dark theme support
- ♿ **Accessibility**: WCAG 2.1 AA compliant with enhanced keyboard navigation
- 🎨 **Modern Design System**: Component-based architecture with CSS Custom Properties
- 🔍 **Advanced Search**: Multi-dimensional filtering (protocol, voltage, use case)
- ⚡ **Performance Optimized**: Optimistic UI, skeleton loading, image optimization
- 🔒 **Security**: Server-side validation, CSRF protection, rate limiting, and secure error handling

---

## 📚 Course Information

This project is developed as part of **41025 - Introduction to Software Development** at the University of Technology Sydney (UTS).

- **Course Code**: 41025
- **Course Name**: Introduction to Software Development
- **Credit Points**: 6 Credit Points
- **Course Handbook**: [View Course Details](https://coursehandbook.uts.edu.au/subject/2026/41025)
- **Assignment**: Assignment 2 - Autumn 2025

---

## 🎯 Project Objectives

- ✅ Implement a fully functional e-commerce platform for IoT devices
- ✅ Demonstrate proficiency in JSP/Servlet web development
- ✅ Apply MVC architecture patterns
- ✅ Implement secure user authentication and authorization
- ✅ Create an intuitive and modern user interface
- ✅ Demonstrate database design and data access patterns
- ✅ Ensure accessibility compliance (WCAG 2.1 AA)
- ✅ Optimize for performance and user experience
- ✅ Implement enterprise-grade security measures

---

## 🏃 Quick Start

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

## 📁 Project Structure

```
IoTBay/
├── src/main/java/
│   ├── controller/           # Servlets (MVC Controllers)
│   ├── dao/                  # Data Access Objects
│   │   ├── stub/            # Stub implementations for testing
│   │   └── impl/            # Database implementations
│   ├── model/               # JavaBeans (User, Product, Order, etc.)
│   ├── service/             # Business Logic Layer
│   ├── utils/               # Utility classes (Security, Validation, Error Handling)
│   └── config/              # Configuration (DIContainer)
├── src/main/webapp/
│   ├── components/          # Reusable JSP components
│   │   ├── header.jsp      # Navigation header
│   │   ├── footer.jsp      # Site footer
│   │   └── layout/         # Layout tags
│   ├── css/                # Stylesheets
│   │   └── modern-theme.css # Design system
│   ├── js/                 # JavaScript functionality
│   │   └── main.js         # Core interactions
│   └── *.jsp               # JSP pages
├── design plan/            # Design system documentation
│   ├── UI_UXdoc.md         # UI/UX specification
│   ├── FEATURES.md         # Feature requirements
│   └── *.md                # Other design docs
└── pom.xml                 # Maven configuration
```

---

## 🛠️ Tech Stack

### Backend
- **Java**: JDK 8 or higher
- **JSP**: JavaServer Pages 2.3+
- **Servlets**: Java Servlet API 3.1+
- **Maven**: Build automation and dependency management
- **Jetty**: Embedded web server (development)
- **Architecture**: MVC (Model-View-Controller) Pattern
- **Data Access**: DAO (Data Access Object) Pattern

### Frontend
- **HTML5**: Semantic markup with ARIA attributes
- **CSS3**: Modern styling with CSS Custom Properties
- **JavaScript**: ES6+ for interactivity and optimistic UI
- **Design System**: Custom CSS framework with component-based architecture
- **Responsive Design**: Mobile-first approach with breakpoints

### Database
- **SQLite**: Lightweight relational database (development)
- **JDBC**: Database connectivity
- **DAO Pattern**: Abstraction layer for data access

### Security
- **Password Hashing**: SHA-256 with salt
- **Session Management**: Secure session handling
- **Role-Based Access Control**: Customer, Staff, Admin roles
- **Input Validation**: SQL injection and XSS prevention
- **CSRF Protection**: Token-based CSRF protection
- **Rate Limiting**: Request rate limiting for security
- **Error Handling**: Secure error handling without information disclosure

---

## 📋 Assignment Requirements

### Functional Requirements

#### 1. 👥 User Management
- ✅ User registration and authentication
- ✅ Profile management
- ✅ Role-based access control (Customer, Staff, Admin)
- ✅ Session management

#### 2. 📦 Product Management
- ✅ Product catalog with categories (Industrial, Warehouse, Agriculture, Smart Home)
- ✅ Product search and multi-dimensional filtering
- ✅ Product details pages with technical specifications
- ✅ Inventory management with stock indicators

#### 3. 🛒 E-commerce Features
- ✅ Shopping cart functionality with compatibility checking
- ✅ Checkout process with progress indicator
- ✅ Order management and tracking
- ✅ Order history with detailed information

#### 4. 🔧 Administrative Features
- ✅ User management dashboard
- ✅ Product management interface
- ✅ Order processing and analytics
- ✅ Access logging for security auditing

### Technical Requirements

- ✅ **MVC Architecture**: Clean separation of concerns
- ✅ **DAO Pattern**: Abstraction layer for data access
- ✅ **Security**: Secure authentication and authorization
- ✅ **Responsive Design**: Mobile-first approach
- ✅ **Modern UI/UX**: Design system principles
- ✅ **Error Handling**: Comprehensive validation and error recovery
- ✅ **Access Logging**: Security auditing and analytics
- ✅ **Server-Side Validation**: Enterprise-grade input validation
- ✅ **CSRF Protection**: Token-based protection
- ✅ **Rate Limiting**: Request throttling

### Design Requirements

- ✅ **Consistent Design System**: Unified components across all pages
- ✅ **Responsive Layout**: Mobile, tablet, and desktop support
- ✅ **Accessibility**: WCAG 2.1 AA compliance
- ✅ **Dark Mode**: Complete theme support
- ✅ **Modern Interface**: Clean, intuitive, and professional

---

## 🎨 Design System

IoTBay features a comprehensive design system built with **CSS Custom Properties**, ensuring consistency and maintainability across the entire application.

### Color Palette

- **Primary Blue** (`#0a95ff`): Trust, technology, professionalism
- **Secondary Green** (`#22c55e`): Success, energy, innovation
- **Accent Orange** (`#f97316`): Attention, warnings, CTAs

### Key Design Features

- 🎯 **Component-Based Architecture**: Reusable UI components
- 🌈 **CSS Custom Properties**: Dynamic theming support
- 📱 **Responsive Grid System**: Mobile-first breakpoints
- ♿ **Accessibility First**: ARIA attributes, keyboard navigation
- 🎭 **Dark Mode**: Complete theme switching
- ⚡ **Performance**: Optimized animations and loading states

For detailed design documentation, see:
- [Design System](design%20plan/DESIGN_SYSTEM.md)
- [UI/UX Documentation](designplan/UI_UXdoc.md)
- [Component Architecture](design%20plan/COMPONENT_ARCHITECTURE.md)
- [Features Documentation](design%20plan/FEATURES.md)

---

## 🔒 Security Features

### Enterprise-Grade Security Implementation

- **Input Validation**: Comprehensive server-side validation using `SecurityUtil` and `ValidationUtil`
- **XSS Prevention**: Enhanced sanitization of all user inputs
- **SQL Injection Prevention**: Parameterized queries and input sanitization
- **CSRF Protection**: Token-based CSRF protection for state-changing operations
- **Rate Limiting**: Request throttling to prevent abuse
- **Secure Error Handling**: Generic error messages to prevent information disclosure
- **Security Logging**: Comprehensive audit trail for security events
- **Password Security**: Strong password requirements and secure hashing

### Security Utilities

- `SecurityUtil`: Input validation, sanitization, CSRF token management
- `ErrorAction`: Consistent error handling without information leakage
- `ValidationUtil`: Business logic validation for all input fields

---

## 📚 Development Guidelines

### Code Standards

- ✅ Follow Java naming conventions
- ✅ Use meaningful variable and method names
- ✅ Implement proper error handling
- ✅ Add comments for complex logic
- ✅ Maintain consistent code formatting

### Testing

- ✅ Test all user flows
- ✅ Verify authentication and authorization
- ✅ Test responsive design on multiple devices
- ✅ Validate form inputs
- ✅ Test error scenarios
- ✅ Accessibility testing (keyboard navigation, screen readers)

### Documentation

- ✅ Maintain up-to-date README
- ✅ Document API endpoints
- ✅ Include inline code comments
- ✅ Update design system documentation

---

## 📖 Documentation

<div align="center">

| Language | Documentation | Description |
|:--------:|:------------:|:-----------|
| 🇰🇷 | [한국어](README.ko.md) | 한국어 전체 문서 |
| 🇺🇸 | [English](README.en.md) | Full documentation in English |
| 🇯🇵 | [日本語](README.ja.md) | 日本語完全ドキュメント |

</div>

### Additional Resources

- [UI/UX Design Documentation](designplan/UI_UXdoc.md) - Comprehensive UX specification
- [Design System](design%20plan/DESIGN_SYSTEM.md) - Visual design guidelines
- [Component Architecture](design%20plan/COMPONENT_ARCHITECTURE.md) - Component structure
- [Developer Documentation](design%20plan/DEVELOPER_DOCUMENTATION.md) - Development guide
- [Features Documentation](design%20plan/FEATURES.md) - Complete feature list

---

## 📄 License

This project is developed for **academic purposes** as part of **UTS 41025 Introduction to Software Development - Assignment 2 Autumn 2025**. All code and documentation are intended for educational use only.

---

<div align="center">

![Footer](https://capsule-render.vercel.app/api?type=waving&color=0:0a95ff,100:22c55e&height=100&section=footer&text=IoTBay%20-%20Smart%20Technology%20Store&fontSize=20&fontColor=ffffff&fontAlignY=50&animation=twinkling)

**Built with ❤️ for IoT Enthusiasts**

[![UTS](https://img.shields.io/badge/UTS-41025-blue)](https://coursehandbook.uts.edu.au/subject/2026/41025)

</div>
