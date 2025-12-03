# Contributing to IoTBay

## Git Commit Message Convention

This project follows a structured commit message format to maintain clear and consistent version history.

### Commit Message Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Type

Must be one of the following:

- **feat**: A new feature
- **fix**: A bug fix
- **docs**: Documentation only changes
- **style**: Changes that do not affect the meaning of the code (formatting, missing semi-colons, etc.)
- **refactor**: A code change that neither fixes a bug nor adds a feature
- **perf**: A code change that improves performance
- **test**: Adding missing tests or correcting existing tests
- **chore**: Changes to the build process or auxiliary tools
- **ci**: Changes to CI configuration files and scripts

### Scope

Optional, but recommended. Can be anything specifying the scope of the commit:

- **backend**: Backend Java code (controllers, services, DAOs)
- **frontend**: Frontend code (JSP, CSS, TypeScript)
- **database**: Database schema changes
- **auth**: Authentication/authorization
- **cart**: Shopping cart functionality
- **checkout**: Checkout process
- **admin**: Admin dashboard
- **api**: API endpoints
- **config**: Configuration files
- **build**: Build system

### Subject

- Brief description (max 50 characters)
- Use imperative, present tense: "change" not "changed" nor "changes"
- Don't capitalize first letter
- No dot (.) at the end

### Body

- Optional, detailed explanation
- Wrap at 72 characters
- Use imperative, present tense
- Explain **what** and **why** vs. **how**
- Can include multiple paragraphs

### Footer

- Optional
- Reference issue numbers: `Closes #123`, `Fixes #456`
- Breaking changes: `BREAKING CHANGE: description`

## Examples

### Simple commit
```
feat(auth): add password reset functionality
```

### Commit with body
```
fix(cart): resolve quantity update issue

The cart quantity update was not properly syncing with the server.
This fix ensures that quantity changes are immediately reflected
in both the UI and the backend database.

Fixes #123
```

### Breaking change
```
refactor(backend): migrate UserDAO to use DIContainer

BREAKING CHANGE: UserDAO now requires DIContainer initialization.
Update all code that directly instantiates UserDAO.
```

### Multiple changes
```
feat(frontend): add TypeScript support

- Convert JavaScript files to TypeScript
- Add type definitions
- Update build configuration
- Add tsconfig.json

Closes #456
```

## Setting Up Git Commit Template

To use the commit message template:

```bash
git config commit.template .gitmessage
```

Or globally:

```bash
git config --global commit.template .gitmessage
```

## Branch Naming Convention

- **feature/**: New features
  - Example: `feature/user-authentication`
- **fix/**: Bug fixes
  - Example: `fix/cart-quantity-update`
- **hotfix/**: Critical bug fixes
  - Example: `hotfix/security-patch`
- **refactor/**: Code refactoring
  - Example: `refactor/dao-layer`
- **docs/**: Documentation updates
  - Example: `docs/api-documentation`
- **test/**: Adding or updating tests
  - Example: `test/user-service-tests`

## Pull Request Guidelines

1. **Title**: Follow commit message format
2. **Description**: 
   - What changes were made
   - Why the changes were necessary
   - How to test the changes
   - Screenshots (if UI changes)
3. **Link Issues**: Reference related issues
4. **Review**: Ensure code follows project standards

## Code Style

- **Java**: Follow Google Java Style Guide
- **TypeScript**: Follow TypeScript style guide (strict mode)
- **JSP**: Follow existing JSP conventions
- **SQL**: Use uppercase for SQL keywords

## Testing

- Write unit tests for new features
- Ensure all tests pass before committing
- Update tests when fixing bugs

## Questions?

If you have questions about contributing, please open an issue or contact the maintainers.

