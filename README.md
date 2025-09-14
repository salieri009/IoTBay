# IoT Bay - Smart Technology Store

A modern, responsive web application for IoT device management and e-commerce, developed as part of **UTS (University of Technology Sydney) academic coursework**. Built with **JSP**, **Java MVC**, **Maven**, and **Jetty server**. Features a comprehensive design system, dark mode support, and responsive grid layouts.

---

## Features

### **Modern UI/UX Design**
- **Responsive Design**: Mobile-first approach with custom CSS
- **Dark Mode**: Toggle between light and dark themes
- **Component-based Architecture**: Reusable JSP components
- **Grid Layouts**: Modern product grid systems
- **Interactive Elements**: Smooth animations and hover effects

### **E-commerce Functionality**
- **Product Categories**: Industrial, Warehouse, Agriculture, Smart Home
- **Product Browsing**: Advanced filtering and search
- **Shopping Cart**: Add to cart functionality
- **User Authentication**: Login/Register with role-based access
- **Order Management**: Order history and tracking

### **User Management**
- **Customer Accounts**: Profile management and order history
- **Staff Dashboard**: Administrative tools and analytics
- **Role-based Access**: Different permissions for customers and staff
- **Session Management**: Secure user sessions

### **Admin Features**
- **Staff Dashboard**: Analytics and reporting
- **User Management**: Customer and staff account management
- **Product Management**: Inventory and catalog management
- **Data Management**: System data administration

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
│   │   ├── header.jsp       # Navigation header
│   │   ├── footer.jsp       # Site footer
│   │   ├── masthead.jsp     # Hero sections
│   │   └── layout/          # Layout templates
│   ├── css/
│   │   └── modern-theme.css # Main stylesheet with design system
│   ├── js/
│   │   └── main.js          # JavaScript functionality
│   ├── images/              # Static assets
│   ├── WEB-INF/
│   │   ├── web.xml          # Deployment descriptor
│   │   └── views/           # Protected JSP pages
│   ├── index.jsp            # Homepage
│   ├── login.jsp            # Login page
│   ├── register.jsp         # Registration page
│   ├── browse.jsp           # Product browsing
│   ├── about.jsp            # About page
│   ├── contact.jsp          # Contact page
│   ├── Profiles.jsp         # User profile page
│   ├── category-*.jsp       # Category pages
│   └── productDetails.jsp   # Product detail page
├── design plan/             # Design system documentation
│   ├── DESIGN_SYSTEM.md
│   └── MODERN_DESIGN_SYSTEM.md
└── pom.xml                  # Maven configuration
```

---

## Design System

### Color Palette
- **Primary**: Blue (#3B82F6)
- **Secondary**: Green (#10B981)
- **Accent**: Purple (#8B5CF6)
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

---

## Development Commands

| Task | Command | Description |
|------|---------|-------------|
| Clean | `mvn clean` | Remove build artifacts |
| Compile | `mvn compile` | Compile source code |
| Test | `mvn test` | Run unit tests |
| Package | `mvn package` | Create WAR file |
| Run | `mvn jetty:run` | Start development server |
| Stop | `Ctrl + C` | Stop the server |

---

## 🔧 Configuration

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

## 📱 Responsive Breakpoints

- **Mobile**: < 768px
- **Tablet**: 768px - 1024px
- **Desktop**: 1024px - 1280px
- **Large Desktop**: > 1280px

---

## 🎯 Key Features Implemented

### ✅ **Completed Features**
- [x] Modern responsive design system
- [x] Dark/light theme toggle
- [x] User authentication (login/register)
- [x] Product browsing with categories
- [x] Shopping cart functionality
- [x] User profile management
- [x] Staff dashboard and admin tools
- [x] Order management system
- [x] Contact and about pages
- [x] Mobile-responsive navigation
- [x] Interactive dropdown menus
- [x] Grid-based product layouts

### 🔄 **In Progress**
- [ ] Payment integration
- [ ] Email notifications
- [ ] Advanced search filters
- [ ] Product reviews and ratings

---

## 🛠 Technology Stack

- **Backend**: Java 8+, JSP 2.3+, Servlets 3.1+
- **Frontend**: HTML5, CSS3, JavaScript ES6+
- **Styling**: Tailwind CSS, Custom CSS Variables
- **Build Tool**: Maven 3.6+
- **Server**: Jetty 9.4+
- **Architecture**: MVC Pattern
- **Data Access**: DAO Pattern with Stub Implementation

---

## 📄 License

This project is developed for **academic purposes** as part of a university course.

---

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

--