# Integration Testing Guide

**Document Version**: 1.0.0  
**Status**: Published  
**Last Updated**: December 3, 2025  
**Audience**: Developers, QA  
**Maintained By**: IoT Bay Documentation Team

---

## Overview

Integration tests verify that different modules work together correctly, specifically the interaction between DAOs and the Database.

## Tools
- **JUnit 5**: Testing framework
- **H2 Database**: In-memory database for testing
- **TestContainers**: Docker-based integration testing (optional)

## Scope
- DAO methods (CRUD operations)
- Database constraints and triggers
- Transaction management

## Example

```java
@Test
void shouldSaveAndRetrieveUser() throws SQLException {
    User user = new User("test@example.com", "password");
    userDAO.save(user);
    
    User retrieved = userDAO.findByEmail("test@example.com");
    assertEquals(user.getEmail(), retrieved.getEmail());
}
```
