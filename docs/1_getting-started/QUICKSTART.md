# Quick Start Guide

Get IoT Bay running on your machine in less than 10 minutes.

---

## ⏱️ 10-Minute Setup

### Prerequisites (2 min)
- Java 8+ installed
- Maven 3.6+ installed
- Git installed
- Text editor or IDE

**Check versions**:
```bash
java -version
mvn -version
git --version
```

### Clone Repository (1 min)
```bash
git clone https://github.com/salieri009/IoTBay.git
cd IoTBay
```

### Build Application (3 min)
```bash
mvn clean install
```

### Run Application (1 min)
```bash
mvn jetty:run
```

### Access Application (2 min)
1. Open browser
2. Visit `http://localhost:8080`
3. You should see the IoT Bay homepage!

---

## 🎓 Next Steps

**After getting it running**:

1. **Explore the application**
   - Browse products
   - Create an account
   - Add items to cart

2. **Choose your role**
   - Backend Developer? → [Backend Guide](../4_development/BACKEND_GUIDE.md)
   - Frontend Developer? → [Frontend Guide](../4_development/FRONTEND_GUIDE.md)
   - QA Engineer? → [Testing Guide](../5_testing/TEST_STRATEGY.md)

3. **Run the tests**
   ```bash
   mvn test
   ```

4. **Check the code**
   - Backend: `src/main/java/`
   - Frontend: `src/main/webapp/`

---

## 🆘 Troubleshooting

### "Java not found"
```bash
# Install Java
# Windows: Download from oracle.com
# Mac: brew install openjdk@11
# Linux: sudo apt-get install openjdk-11-jdk
```

### "Port 8080 already in use"
```bash
# Use different port
mvn jetty:run -Djetty.port=8081

# Visit http://localhost:8081
```

### "Maven build fails"
```bash
# Clean cache and rebuild
mvn clean install -U

# Check Java version
java -version  # Should be 8+

# Check Maven version
mvn -version   # Should be 3.6+
```

### "Application crashes on startup"
```bash
# Check logs
tail -f target/logs/application.log

# Try rebuild
mvn clean install

# Check database
ls -la *.db
```

---

## 📚 Full Setup Guide

For detailed setup including IDE configuration, database setup, and troubleshooting, see [Setup Guide](./SETUP_GUIDE.md).

---

**Done? Check out**: [Project Overview](./PROJECT_OVERVIEW.md) or pick your role from [Getting Started](./README.md)

---

**Last Updated**: December 3, 2025
