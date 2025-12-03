# Production Deployment Guide

**Document Version**: 1.0.0  
**Status**: Published  
**Last Updated**: December 3, 2025  
**Audience**: DevOps, Developers  
**Maintained By**: IoT Bay Documentation Team

---

## Overview

Guide for deploying IoT Bay to a production environment.

## Requirements
- **OS**: Linux (Ubuntu 20.04+)
- **Java**: JDK 11+
- **Server**: Apache Tomcat 9+
- **Database**: PostgreSQL 13+

## Steps

1.  **Build WAR**: `mvn clean package`
2.  **Copy WAR**: `cp target/iotbay.war /var/lib/tomcat9/webapps/`
3.  **Config DB**: Set environment variables for DB credentials.
4.  **Restart**: `sudo systemctl restart tomcat9`

## Security
- Use HTTPS (Let's Encrypt).
- Set secure cookies.
- Disable default Tomcat apps.
