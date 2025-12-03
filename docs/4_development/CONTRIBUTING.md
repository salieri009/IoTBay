# Contributing to IoT Bay

Welcome to the IoT Bay project! This guide explains how to contribute code, documentation, and other improvements.

---

## 🎯 How to Contribute

### Reporting Issues
1. Check [existing issues](../../issues) first
2. Create new issue with:
   - Clear title
   - Detailed description
   - Steps to reproduce (for bugs)
   - Expected vs actual behavior

### Submitting Changes
1. Fork the repository
2. Create feature branch (see [Branch Naming](#branch-naming-convention))
3. Make your changes
4. Write/update tests
5. Follow [code style](#code-style)
6. Submit pull request with clear description

---

## 🔄 Git Commit Message Convention

### Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Type

- **feat**: New feature
- **fix**: Bug fix
- **docs**: Documentation changes
- **style**: Formatting (no code change)
- **refactor**: Code refactoring
- **perf**: Performance improvement
- **test**: Test changes
- **chore**: Build/tool changes
- **ci**: CI/CD changes

### Scope

Optional scope specifying area of change:

- **backend**: Java controllers, services, DAOs
- **frontend**: JSP, CSS, TypeScript
- **database**: Schema changes
- **auth**: Authentication/authorization
- **cart**: Shopping cart
- **checkout**: Checkout process
- **admin**: Admin dashboard
- **api**: API endpoints
- **config**: Configuration
- **build**: Build system

### Subject

- Max 50 characters
- Imperative tense: "change" not "changed"
- No capitalization or period
- Concise and descriptive

### Body

- Optional detailed explanation
- Wrap at 72 characters
- Explain **what** and **why**, not **how**

### Footer

- Optional
- Reference issues: `Closes #123`
- Breaking changes: `BREAKING CHANGE: description`

### Examples

**Simple**:
```
feat(auth): add password reset functionality
```

**With body**:
```
fix(cart): resolve quantity update issue

The cart quantity update was not properly syncing with the server.
This fix ensures that quantity changes are immediately reflected
in both the UI and the backend database.

Fixes #123
```

**Breaking change**:
```
refactor(backend): migrate UserDAO to DIContainer

BREAKING CHANGE: UserDAO now requires DIContainer initialization.
Update all code that directly instantiates UserDAO.
```

---

## 🌿 Branch Naming Convention

| Type | Format | Example |
|---|---|---|
| Feature | `feat/<description>` | `feat/user-authentication` |
| Fix | `fix/<description>` | `fix/cart-quantity-update` |
| Hotfix | `hotfix/<description>` | `hotfix/security-patch` |
| Refactor | `refactor/<description>` | `refactor/dao-layer` |
| Docs | `docs/<description>` | `docs/api-documentation` |
| Test | `test/<description>` | `test/user-service-tests` |

**Rules**:
- Use lowercase
- Use hyphens (not underscores)
- Be descriptive but concise
- Delete branch after merge

---

## ✅ Pull Request Guidelines

### Title
- Follow commit message format
- Keep to ~50 characters
- Example: `feat(auth): add password reset`

### Description
Include:
- **What**: Changes made
- **Why**: Reason for changes
- **How to test**: Testing steps
- **Screenshots**: For UI changes
- **Related issues**: Reference #123

### Checklist
Before submitting:
- [ ] Code follows [style guide](#code-style)
- [ ] Tests written/updated
- [ ] All tests passing (`mvn test`)
- [ ] No console errors/warnings
- [ ] Documentation updated
- [ ] Commit messages follow format
- [ ] No sensitive data committed

---

## 💻 Code Style

### Java
- Follow [Google Java Style Guide](https://google.github.io/styleguide/javaguide.html)
- Use meaningful variable names
- Keep methods focused and small (< 30 lines)
- Add JavaDoc for public methods

**Example**:
```java
/**
 * Validates user input and creates new user account.
 * 
 * @param email User email address
 * @param password User password
 * @return Created user object
 * @throws InvalidUserDataException if validation fails
 */
public User createUser(String email, String password) {
    // Implementation
}
```

### TypeScript/JavaScript
- Use strict mode
- Consistent indentation (2 spaces)
- Meaningful variable names
- Add type annotations

### JSP
- Use consistent indentation (4 spaces)
- Use JSTL tags over scriptlets
- Add comments for complex logic

### SQL
- Use uppercase for keywords
- Use meaningful table/column names
- Add comments for complex queries

### CSS
- Use descriptive class names (BEM convention)
- Group related properties
- Use semantic class names

---

## 🧪 Testing Requirements

### Unit Tests
- Write for new features
- Maintain > 80% coverage
- Use JUnit + Mockito
- File: `src/test/java/*Test.java`

### Running Tests
```bash
mvn test                         # All tests
mvn test -Dtest=UserDAOTest     # Specific test
mvn test jacoco:report          # With coverage
```

### Test Example
```java
@Test
public void testCreateUser_ValidInput_Success() {
    // Arrange
    User user = new User("user@example.com", "password123");
    
    // Act
    User created = userService.createUser(user);
    
    // Assert
    assertNotNull(created.getId());
    assertEquals("user@example.com", created.getEmail());
}
```

---

## 📝 Documentation

### Update When
- Adding new features
- Changing APIs
- Fixing bugs (if doc-related)
- Updating processes

### Where
- Inline code comments for complex logic
- JavaDoc for public methods
- README for project overview
- Relevant docs/ files for detailed docs

---

## 🚀 Submitting Your Contribution

1. **Fork** the repository
2. **Create** feature branch: `git checkout -b feat/my-feature`
3. **Make** changes following style guide
4. **Commit** with proper message: `git commit -m "feat(scope): description"`
5. **Push** to fork: `git push origin feat/my-feature`
6. **Create** Pull Request on GitHub
7. **Wait** for review and address feedback
8. **Merge** once approved

---

## ❓ Questions or Need Help?

- Check [Getting Started](../1_getting-started/)
- Read [Development Guide](./README.md)
- Review [Code Style](./CODE_STYLE.md)
- Open an [issue](../../issues)

---

## 📋 Code of Conduct

Be respectful, inclusive, and professional. We welcome all contributors!

---

**Thank you for contributing to IoT Bay! 🎉**

---

**Last Updated**: December 3, 2025  
**Version**: 1.0.0


---

**Document Version**: 1.0.0
**Status**: Published
**Audience**: Developers, Stakeholders
**Maintained By**: IoT Bay Documentation Team
