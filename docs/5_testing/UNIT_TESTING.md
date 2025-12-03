# Unit Testing Guide

**Document Version**: 1.0.0  
**Status**: Published  
**Last Updated**: December 3, 2025  
**Audience**: Developers  
**Maintained By**: IoT Bay Documentation Team

---

## Overview

Unit tests verify the smallest testable parts of the application, primarily the Service layer and Utility classes.

## Tools
- **JUnit 5**: Testing framework
- **Mockito**: Mocking dependencies

## Best Practices
1.  Test one thing per test method.
2.  Use meaningful test names (e.g., `shouldReturnUserWhenIdExists`).
3.  Mock external dependencies (DAOs, Database).
4.  Aim for >80% code coverage.

## Example

```java
@Test
void shouldRegisterUser() {
    // Arrange
    when(userDAO.findByEmail(anyString())).thenReturn(null);
    
    // Act
    User user = userService.register("test@example.com", "password");
    
    // Assert
    assertNotNull(user);
    verify(userDAO).save(any(User.class));
}
```
