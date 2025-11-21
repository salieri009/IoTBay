# Error Prevention Validation Scripts

This directory contains automated validation scripts that check many items from the error prevention checklists:
- [500 Error Prevention Checklist](../docs/testing/500_ERROR_PREVENTION_CHECKLIST.md)
- [403/404 Error Prevention Checklist](../docs/testing/403_404_ERROR_PREVENTION_CHECKLIST.md)

## PowerShell Script (Windows)

### Usage

```powershell
# Run with default output (only failures)
.\scripts\validate-500-prevention.ps1

# Run with verbose output (all checks)
.\scripts\validate-500-prevention.ps1 -Verbose
```

### What It Checks

The script automatically validates:

1. **Null Pointer Prevention**
   - Session attribute null checks
   - Request parameter validation usage

2. **Resource Management**
   - Try-with-resources usage for PreparedStatement
   - Try-with-resources usage for ResultSet

3. **Error Handling**
   - Try-catch blocks in servlet methods
   - ErrorAction utility usage

4. **SQL Injection Prevention**
   - PreparedStatement usage
   - Detection of dangerous string concatenation

5. **Logging Configuration**
   - Logger declaration patterns
   - Static final logger usage

6. **Configuration Files**
   - application.properties existence and required properties
   - web.xml error page configuration

7. **Build Configuration**
   - pom.xml Java version settings
   - WAR packaging configuration

8. **Error Pages**
   - error.jsp existence
   - Stack trace exposure checks

9. **Input Validation**
   - SecurityUtil usage in controllers
   - Direct parameter access detection

10. **Connection Pool**
    - ConnectionPool class structure
    - Singleton pattern implementation

### Exit Codes

- `0` - All checks passed (may have warnings)
- `1` - Critical issues found

### Integration with CI/CD

Add to your CI/CD pipeline:

```yaml
# Example for GitHub Actions
- name: Validate 500 Error Prevention
  run: |
    pwsh -File scripts/validate-500-prevention.ps1 -Verbose
```

```yaml
# Example for Jenkins
stage('Validation') {
    steps {
        powershell script: 'scripts/validate-500-prevention.ps1 -Verbose'
    }
}
```

## 403/404 Error Prevention Validation Script

### Usage

```powershell
# Run with default output (only failures)
.\scripts\validate-403-404-prevention.ps1

# Run with verbose output (all checks)
.\scripts\validate-403-404-prevention.ps1 -Verbose
```

### What It Checks

The script automatically validates:

1. **Authentication Verification**
   - Session validation in controllers
   - Authentication checks in protected endpoints

2. **Authorization Checks (403 Prevention)**
   - Authorization checks in admin controllers
   - Role-based access control patterns
   - ErrorAction usage for 403 errors

3. **Servlet Mappings (404 Prevention)**
   - web.xml servlet mapping configuration
   - @WebServlet annotation usage
   - Mapping completeness

4. **Path Parameter Validation**
   - PathInfo null/empty checks
   - Path parameter validation patterns

5. **Resource Existence Checks**
   - Null checks after resource retrieval
   - 404 error handling for missing resources

6. **Error Page Configuration**
   - 403 and 404 error page configuration
   - error.jsp existence

7. **CSRF Token Validation**
   - CSRF validation in state-changing operations
   - SecurityUtil.validateCSRFToken usage

8. **Redirect Security**
   - Secure redirect patterns
   - Open redirect vulnerability detection

9. **Type Safety**
   - instanceof checks before casting
   - Safe session attribute access

### Exit Codes

- `0` - All checks passed (may have warnings)
- `1` - Critical issues found

### Integration with CI/CD

Add to your CI/CD pipeline:

```yaml
# Example for GitHub Actions
- name: Validate 403/404 Error Prevention
  run: |
    pwsh -File scripts/validate-403-404-prevention.ps1 -Verbose
```

## Manual Checklist

For items that cannot be automatically validated, refer to the error prevention checklists and check them manually during code review and pre-deployment QA:
- [500 Error Prevention Checklist](../docs/testing/500_ERROR_PREVENTION_CHECKLIST.md)
- [403/404 Error Prevention Checklist](../docs/testing/403_404_ERROR_PREVENTION_CHECKLIST.md)

## Limitations

The automated script checks code patterns and configuration files, but cannot validate:

- Runtime behavior
- Performance characteristics
- Security vulnerabilities (requires specialized tools)
- Manual testing scenarios
- Environment-specific configurations
- Deployment-specific settings

Use this script as a first-pass validation, but always complete the full manual checklist before deployment.

