# IoTBay E-commerce Platform - Developer Documentation

## 📋 Project Information

**Course**: 41025 Information Systems Development (ISD)  
**Assignment**: Assignment 2 - Autumn 2025  
**Institution**: University of Technology Sydney (UTS)  
**Project Type**: E-commerce Web Application for IoT Devices

---

## 📋 Project Overview

IoTBay is a comprehensive e-commerce web application designed specifically for Internet of Things (IoT) devices and components. Developed as part of **UTS 41025 ISD Assignment 2 Autumn 2025**, the platform serves as a marketplace for IoT products including sensors, cables, batteries, and smart home devices across various categories such as Industrial, Warehouse, Agriculture, and Smart Home solutions.

## 🎯 Business Requirements

### Primary Objectives
- **B2B and B2C IoT Marketplace**: Provide a platform for businesses and consumers to purchase IoT devices and components
- **Product Catalog Management**: Comprehensive product browsing, search, and categorization
- **User Account Management**: Complete user registration, authentication, and profile management
- **Shopping Cart & Checkout**: Full e-commerce functionality with cart management and order processing
- **Order Management**: Order tracking, history, and status management
- **Administrative Tools**: Admin interfaces for managing products, users, and system logs
- **Secure Authentication**: Role-based access control with secure password management

### Target Users
1. **Customers (End Users)**: Individuals and businesses purchasing IoT devices
2. **Administrators**: System administrators managing the platform
3. **Staff**: Customer service and inventory management personnel

## 🏗️ System Architecture

### Architecture Pattern
- **MVC (Model-View-Controller)**: Clean separation of concerns
- **Three-Tier Architecture**: Presentation, Business Logic, and Data Access layers
- **DAO Pattern**: Data Access Object pattern for database operations
- **Dependency Injection**: Custom IoC container for service management

### Technology Stack

#### Backend
- **Java 8+**: Core programming language
- **JSP (JavaServer Pages)**: Server-side rendering for views
- **Servlets**: HTTP request handling and controller logic
- **Maven**: Build automation and dependency management
- **Jetty Server**: Embedded web server for development
- **SQLite**: Lightweight relational database
- **JSTL**: JSP Standard Tag Library for view logic

#### Frontend
- **JSP (JavaServer Pages)**: Server-side rendering for views
- **HTML5**: Semantic markup
- **CSS3**: Modern styling with CSS Custom Properties
- **JavaScript ES6+**: Client-side interactivity
- **JSTL**: JSP Standard Tag Library for view logic
- **Design System**: Component-based CSS framework

#### Security
- **SHA-256**: Password hashing with salt
- **HMAC**: Token-based authentication
- **Session Management**: Secure session handling
- **Input Validation**: SQL injection and XSS prevention

## 📊 Database Design

### Core Entities

#### Users Table
```sql
- id (Primary Key)
- email (Unique)
- firstName
- lastName
- password (Hashed)
- phone
- postalCode
- addressLine1
- addressLine2
- paymentMethod
- dateOfBirth
- createdAt
- updatedAt
- role (customer, admin, staff)
- isActive
```

#### Products Table
```sql
- id (Primary Key)
- categoryId (Foreign Key)
- name
- description
- price
- stockQuantity
- imageUrl
- createdAt
```

#### Categories Table
```sql
- id (Primary Key)
- name
- description
- parentCategoryId (Self-referential)
```

#### Orders Table
```sql
- id (Primary Key)
- userId (Foreign Key)
- orderDate
- status (pending, processing, shipped, delivered, cancelled)
- totalAmount
```

#### OrderProducts Table (Junction)
```sql
- orderId (Foreign Key)
- productId (Foreign Key)
- quantity
- unitPrice
```

#### CartItems Table
```sql
- id (Primary Key)
- userId (Foreign Key)
- productId (Foreign Key)
- quantity
- addedAt
```

#### AccessLogs Table
```sql
- id (Primary Key)
- userId (Foreign Key)
- action
- timestamp
- ipAddress
- userAgent
```

#### Additional Tables
- **AddressDetails**: Shipping and billing addresses
- **Payments**: Payment information and transaction records
- **PaymentDetails**: Payment method details
- **Reviews**: Product reviews and ratings
- **Wishlist/WishlistProducts**: User wishlist functionality
- **Shipments**: Shipping and tracking information
- **ResetQuestions**: Password recovery security questions

## 🔧 Core Features & Functionality

### 1. User Management System

#### Registration & Authentication
- **User Registration**: New user account creation with validation
- **Login/Logout**: Secure authentication with session management
- **Password Security**: SHA-256 hashing with salt for password storage
- **Role-Based Access**: Different access levels (customer, admin, staff)
- **Profile Management**: Users can update personal information
- **Account Deletion**: Soft delete functionality for user accounts

#### Profile Features
```java
// User Profile Components
- Personal Information (name, email, phone)
- Address Management (multiple addresses)
- Payment Methods
- Order History
- Account Settings
```

### 2. Product Catalog System

#### Product Management
- **Product Browsing**: Category-based and search-based product discovery
- **Product Details**: Comprehensive product information pages
- **Search Functionality**: Keyword-based product search
- **Category Navigation**: Hierarchical category system
- **Inventory Management**: Stock quantity tracking
- **Image Management**: Product image handling with fallback support

#### Categories
```
Industrial IoT Devices
├── Sensors
├── Controllers
└── Connectivity Modules

Warehouse Solutions
├── RFID Systems
├── Automation Tools
└── Monitoring Devices

Agriculture Technology
├── Environmental Sensors
├── Irrigation Systems
└── Livestock Monitoring

Smart Home
├── Security Systems
├── Energy Management
└── Home Automation
```

### 3. E-commerce Functionality

#### Shopping Cart
- **Add to Cart**: Product addition with quantity selection
- **Cart Management**: Update quantities, remove items
- **Persistent Cart**: Cart persistence across sessions
- **Cart Calculation**: Real-time total calculation

#### Checkout Process
```
1. Cart Review
2. Shipping Address Selection/Entry
3. Payment Method Selection
4. Order Confirmation
5. Payment Processing
6. Order Creation
```

#### Order Management
- **Order Creation**: Convert cart to order
- **Order Tracking**: Status updates and tracking
- **Order History**: Complete order history for users
- **Order Status**: Multiple status levels (pending, processing, shipped, delivered)

### 4. Administrative Interface

#### Admin Dashboard
- **User Management**: View, edit, and manage user accounts
- **Product Management**: CRUD operations for products
- **Order Management**: View and update order statuses
- **System Monitoring**: Access logs and system analytics
- **Content Management**: Manage categories and product information

#### Management Features
```java
// Admin Capabilities
- View/Edit/Delete Users
- Add/Update/Remove Products
- Manage Product Categories
- Monitor User Access Logs
- Process Orders
- Generate Reports
```

### 5. Security Features

#### Authentication & Authorization
- **Secure Login**: Password hashing and session management
- **Role-Based Access Control**: Different permission levels
- **Session Security**: Secure session handling and timeout
- **CSRF Protection**: Cross-site request forgery prevention

#### Data Security
- **Input Validation**: SQL injection prevention
- **XSS Protection**: Cross-site scripting prevention
- **Password Policy**: Strong password requirements
- **Audit Logging**: Comprehensive access and action logging

## 🛠️ Technical Implementation

### Project Structure
```
IoTBay/
├── src/main/java/
│   ├── controller/          # Servlet controllers
│   ├── model/              # Data models (JavaBeans)
│   ├── dao/                # Data Access Objects
│   │   └── interfaces/     # DAO interfaces
│   ├── db/                 # Database connection
│   ├── utils/              # Utility classes
│   └── service/            # Business logic services
├── src/main/webapp/
│   ├── components/         # Reusable JSP components
│   ├── css/               # Stylesheets
│   ├── images/            # Static images
│   ├── WEB-INF/           # Protected resources
│   └── *.jsp              # JSP pages
├── IoTBay-Frontend/       # React frontend
│   ├── src/
│   │   ├── components/    # React components
│   │   ├── pages/         # Page components
│   │   ├── services/      # API services
│   │   └── styles/        # CSS modules
│   └── package.json
└── IoTBay-Backend/        # Separated backend services
```

### Key Controllers

#### User Controllers
- **LoginController**: Handles user authentication
- **RegisterController**: Manages user registration
- **UserProfileController**: User profile management
- **UpdateUserController**: Profile updates
- **LogoutController**: Session termination

#### Product Controllers
- **BrowseProductController**: Product search and listing
- **ProductDetailsController**: Individual product pages
- **ManageProductController**: Admin product management
- **UpdateProductController**: Product modification
- **DeleteProductController**: Product removal

#### E-commerce Controllers
- **CartController**: Shopping cart operations
- **CheckoutController**: Order processing
- **OrderHistoryController**: Order management

#### Administrative Controllers
- **ManageUserController**: User administration
- **ManageAccessLogController**: System monitoring
- **AccesslogController**: Audit trail management

### Modern Enhancements (Recently Added)

#### Dependency Injection
```java
// Custom IoC Container
DIContainer container = new DIContainer();
container.register(UserService.class, new UserService(userDAO));
UserService userService = container.resolve(UserService.class);
```

#### Service Layer
```java
// Business Logic Services
@Service
public class UserService {
    private final UserDAO userDAO;
    
    public UserRegistrationResult registerUser(UserRegistrationRequest request) {
        // Business logic for user registration
    }
}
```

#### REST API Endpoints
```java
// Modern API Controllers
@RestController("/api/products")
public class ProductApiController {
    public ResponseEntity<List<Product>> getProducts() {
        // JSON API responses
    }
}
```

#### Response Utilities
```java
// Standardized JSON responses
ResponseUtil.success(data);
ResponseUtil.error("Error message", 400);
```

## 🔄 Data Flow & User Journeys

### Customer Journey
```
1. Home Page → Browse Categories/Search
2. Product Listing → Product Details
3. Add to Cart → Continue Shopping/Checkout
4. Account Creation/Login → Address/Payment
5. Order Confirmation → Order Tracking
6. Account Management → Order History
```

### Admin Workflow
```
1. Admin Login → Dashboard
2. User Management → View/Edit Users
3. Product Management → Add/Update Products
4. Order Management → Process Orders
5. System Monitoring → View Access Logs
6. Content Management → Manage Categories
```

## 🚀 Deployment & Development

### Development Environment
```bash
# Backend (Traditional JSP/Servlet)
mvn clean install
mvn jetty:run
# Access: http://localhost:8080

# Frontend (React)
cd IoTBay-Frontend
npm install
npm run dev
# Access: http://localhost:3000
```

### Build Process
```bash
# Backend WAR file
mvn package
# Generates: target/IoTBay.war

# Frontend production build
npm run build
# Generates: dist/ directory
```

### Configuration
- **Database**: SQLite file-based database
- **Connection Pool**: Custom connection pooling implementation
- **Configuration**: Externalized in `application.properties`
- **Security**: Environment-based configuration for sensitive data

## 📈 Performance & Scalability

### Current Optimizations
- **Connection Pooling**: Database connection management
- **Session Management**: Efficient session handling
- **Static Resource Caching**: CSS/JS/Image caching
- **Database Indexing**: Optimized queries on frequently accessed fields

### Scalability Considerations
- **Stateless Design**: Controllers designed for horizontal scaling
- **Database Migration Path**: SQLite → PostgreSQL/MySQL for production
- **Caching Strategy**: Ready for Redis/Memcached integration
- **Load Balancing**: Stateless sessions support load balancing

## 🔒 Security Implementation

### Authentication Flow
```
1. User submits credentials
2. Password verified against hashed storage
3. Session created with secure attributes
4. Token-based authentication for API calls
5. Role-based authorization for resources
```

### Security Measures
- **Password Hashing**: SHA-256 with salt
- **Session Security**: HttpOnly, Secure flags
- **Input Validation**: All user inputs sanitized
- **SQL Injection Prevention**: Parameterized queries
- **Access Logging**: Comprehensive audit trail

## 🧪 Testing Strategy

### Current Test Coverage
- **Unit Tests**: Model and utility classes
- **Integration Tests**: DAO layer testing
- **Manual Testing**: UI and workflow testing
- **Security Testing**: Authentication and authorization

### Testing Framework Integration
```java
// JUnit test structure
@Test
public void testUserRegistration() {
    // Test user registration logic
}
```

## 📊 Monitoring & Analytics

### Access Logging
- **User Actions**: Login, logout, page access
- **Admin Actions**: User management, product updates
- **System Events**: Errors, security events
- **Performance Metrics**: Response times, error rates

### Data Analytics
- **User Behavior**: Page views, conversion rates
- **Product Analytics**: Popular products, search terms
- **Sales Metrics**: Order volumes, revenue tracking
- **System Health**: Error rates, performance metrics

## 🔮 Future Enhancements

### Planned Features
1. **Advanced Search**: Elasticsearch integration for better search
2. **Recommendation Engine**: ML-based product recommendations
3. **Mobile App**: React Native mobile application
4. **Real-time Notifications**: WebSocket-based notifications
5. **Advanced Analytics**: Business intelligence dashboard
6. **Multi-vendor Support**: Marketplace functionality
7. **Inventory Management**: Advanced stock management
8. **Payment Gateway**: Integration with payment processors

### Technical Improvements
1. **Microservices Architecture**: Service decomposition
2. **Container Deployment**: Docker and Kubernetes
3. **API Gateway**: Centralized API management
4. **Message Queues**: Asynchronous processing
5. **Cloud Migration**: AWS/Azure deployment
6. **Performance Monitoring**: APM tools integration
7. **Automated Testing**: CI/CD pipeline enhancement

## 📚 API Documentation

### Authentication Endpoints
```
POST /login - User login
POST /logout - User logout
POST /register - User registration
GET /me - Current user info
```

### Product Endpoints
```
GET /browse - Product search/listing
GET /product?productId={id} - Product details
POST /api/products - Create product (Admin)
PUT /api/products/{id} - Update product (Admin)
DELETE /api/products/{id} - Delete product (Admin)
```

### Cart & Order Endpoints
```
POST /cart - Add to cart
GET /cart - View cart
PUT /cart - Update cart
POST /checkout - Process order
GET /orderHistory - Order history
```

### Admin Endpoints
```
GET /manage-users - User management
GET /manage-products - Product management
GET /manage-access-logs - System logs
POST /manage-user - User operations
```

## 🎨 UI/UX Design Principles

### Design System
- **Responsive Design**: Mobile-first approach
- **Accessibility**: WCAG compliance
- **User Experience**: Intuitive navigation and workflow
- **Performance**: Fast loading and interactive elements

### Component Library
- **Header/Navigation**: Consistent site navigation
- **Product Cards**: Standardized product display
- **Forms**: Consistent form styling and validation
- **Modals**: User feedback and confirmations

## 🔧 Development Guidelines

### Code Standards
- **Java Conventions**: Oracle Java coding standards
- **JSP Best Practices**: Separation of logic and presentation
- **Database Design**: Normalized schema with proper indexing
- **Security**: OWASP security guidelines
- **Documentation**: Comprehensive inline documentation

### Git Workflow
```
main (production)
├── feature/solo-development (current development)
└── feature/* (feature branches)
```

### Deployment Process
1. **Development**: Local testing and validation
2. **Staging**: Pre-production environment testing
3. **Production**: Live environment deployment
4. **Monitoring**: Post-deployment monitoring and validation

---

## 📞 Support & Maintenance

### Development Team Structure
- **Full-Stack Developer**: Complete system ownership
- **Database Administrator**: Data management and optimization
- **DevOps Engineer**: Deployment and infrastructure
- **QA Engineer**: Testing and quality assurance

### Maintenance Schedule
- **Daily**: Monitoring and basic maintenance
- **Weekly**: Security updates and patches
- **Monthly**: Performance optimization and feature updates
- **Quarterly**: Major version upgrades and architecture reviews

---

*This documentation serves as the comprehensive guide for developers working on the IoTBay e-commerce platform. It should be updated regularly as the system evolves and new features are added.*
