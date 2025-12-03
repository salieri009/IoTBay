# Debugging Guide

**Document Version**: 1.0.0  
**Status**: Published  
**Last Updated**: December 3, 2025  
**Audience**: Developers  
**Maintained By**: IoT Bay Documentation Team

---

## Overview

This guide provides strategies and tools for debugging the IoT Bay application.

## Common Issues

### 1. Database Connection Failures
- **Symptom**: `SQLException: No suitable driver found`
- **Fix**: Ensure `sqlite-jdbc` dependency is in `pom.xml`.
- **Check**: Verify `db.url` in `src/main/resources/application.properties`.

### 2. JSP Rendering Errors
- **Symptom**: `JasperException` or blank page
- **Fix**: Check server logs for stack traces. Verify taglib imports.

## Tools
- **IDE Debugger**: Use breakpoints in IntelliJ/Eclipse.
- **Browser DevTools**: Inspect network requests and console errors.
- **Server Logs**: Check Tomcat `catalina.out`.

## FAQ

### Q: How do I enable verbose logging?
A: Update `log4j.properties` to set level to `DEBUG`.
