# Database Setup Guide

**Document Version**: 1.0.0  
**Status**: Published  
**Last Updated**: December 3, 2025  
**Audience**: Developers  
**Maintained By**: IoT Bay Documentation Team

---

## Overview

IoT Bay uses SQLite for development and PostgreSQL for production.

## Development Setup (SQLite)

1.  **Location**: `src/main/resources/iotbay.db`
2.  **Initialization**: The app automatically creates tables on startup if they don't exist.
3.  **Tools**: Use `DB Browser for SQLite` to inspect data.

## Production Setup (PostgreSQL)

1.  **Install**: `sudo apt install postgresql`
2.  **Create DB**: `CREATE DATABASE iotbay;`
3.  **Config**: Update `application.properties` with credentials.

## Schema

See [Database Design](../2_architecture/DATABASE_DESIGN.md) for table definitions.
