# Local Deployment Guide

**Document Version**: 1.0.0  
**Status**: Published  
**Last Updated**: December 3, 2025  
**Audience**: Developers  
**Maintained By**: IoT Bay Documentation Team

---

## Overview

How to run IoT Bay locally for development.

## Prerequisites
- Java JDK 11+
- Maven 3.6+
- Tomcat 9 (optional, can use embedded)

## Running with Maven
```bash
mvn tomcat7:run
```
Access at `http://localhost:8080/IoTBay`

## Running in IDE
1.  Import as Maven project.
2.  Configure Tomcat server run configuration.
3.  Deploy artifact `iotbay:war exploded`.
