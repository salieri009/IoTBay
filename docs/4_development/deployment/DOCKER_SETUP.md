# Docker Setup Guide

**Document Version**: 1.0.0  
**Status**: Published  
**Last Updated**: December 3, 2025  
**Audience**: DevOps, Developers  
**Maintained By**: IoT Bay Documentation Team

---

## Overview

Run IoT Bay using Docker containers.

## Dockerfile
```dockerfile
FROM tomcat:9-jdk11-openjdk
COPY target/iotbay.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]
```

## Docker Compose
```yaml
version: '3'
services:
  app:
    build: .
    ports:
      - "8080:8080"
    environment:
      - DB_URL=jdbc:postgresql://db:5432/iotbay
  db:
    image: postgres:13
    environment:
      - POSTGRES_PASSWORD=secret
```

## Running
```bash
docker-compose up --build
```
