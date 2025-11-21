# 403/404 Error Prevention Checklist Validator
# Automatically validates many items from the 403_404_ERROR_PREVENTION_CHECKLIST.md
# Usage: .\scripts\validate-403-404-prevention.ps1

param(
    [switch]$Verbose,
    [switch]$Fix
)

$ErrorActionPreference = "Continue"
$script:Issues = @()
$script:Warnings = @()
$script:Passed = @()
$script:TotalChecks = 0

function Write-CheckResult {
    param(
        [string]$Category,
        [string]$Check,
        [bool]$Passed,
        [string]$Message = "",
        [string]$Severity = "Medium"
    )
    
    $script:TotalChecks++
    $status = if ($Passed) { "✓ PASS" } else { "✗ FAIL" }
    $color = if ($Passed) { "Green" } else { "Red" }
    
    if ($Passed) {
        $script:Passed += "$Category - $Check"
    } elseif ($Severity -eq "Critical") {
        $script:Issues += "$Category - $Check : $Message"
    } else {
        $script:Warnings += "$Category - $Check : $Message"
    }
    
    if ($Verbose -or -not $Passed) {
        Write-Host "$status [$Severity] $Category - $Check" -ForegroundColor $color
        if ($Message -and -not $Passed) {
            Write-Host "  → $Message" -ForegroundColor Yellow
        }
    }
}

function Test-AuthenticationChecks {
    Write-Host "`n=== Checking Authentication Verification ===" -ForegroundColor Cyan
    
    $controllerFiles = Get-ChildItem -Path "src\main\java\controller" -Filter "*.java" -Recurse -ErrorAction SilentlyContinue
    
    $authCheckCount = 0
    $missingAuthCount = 0
    
    foreach ($file in $controllerFiles) {
        $content = Get-Content $file.FullName -Raw
        
        # Skip public endpoints
        $publicEndpoints = @("LoginController", "RegisterController", "BrowseProductController", "ProductDetailsController")
        $isPublic = $false
        foreach ($public in $publicEndpoints) {
            if ($file.Name -match $public) {
                $isPublic = $true
                break
            }
        }
        
        if ($isPublic) { continue }
        
        # Check for session validation
        if ($content -match 'doGet|doPost|doPut|doDelete') {
            if ($content -match 'getSession\(false\)|session\s*==\s*null|instanceof\s+User') {
                $authCheckCount++
                Write-CheckResult "Authentication" "Session validation in $($file.Name)" $true
            } else {
                $missingAuthCount++
                Write-CheckResult "Authentication" "Session validation in $($file.Name)" $false `
                    "Protected endpoint without authentication check" "Critical"
            }
        }
    }
    
    Write-CheckResult "Authentication" "Controllers with auth checks: $authCheckCount" $true
    if ($missingAuthCount -gt 0) {
        Write-CheckResult "Authentication" "Missing authentication checks" $false `
            "$missingAuthCount controllers missing authentication" "Critical"
    }
}

function Test-AuthorizationChecks {
    Write-Host "`n=== Checking Authorization (403 Prevention) ===" -ForegroundColor Cyan
    
    $controllerFiles = Get-ChildItem -Path "src\main\java\controller" -Filter "*.java" -Recurse -ErrorAction SilentlyContinue
    
    $adminControllers = @("ManageProductController", "ManageUserController", "ManageAccessLogController", 
                         "DeleteProductController", "DeleteUserController", "SupplierController", 
                         "AdminDashboardController", "DataManagementController")
    
    $authzCount = 0
    $missingAuthzCount = 0
    
    foreach ($file in $controllerFiles) {
        $isAdminController = $false
        foreach ($admin in $adminControllers) {
            if ($file.Name -match $admin) {
                $isAdminController = $true
                break
            }
        }
        
        if ($isAdminController) {
            $content = Get-Content $file.FullName -Raw
            
            # Check for authorization checks
            if ($content -match 'isAdmin|isStaff|staff.*equalsIgnoreCase|admin.*equalsIgnoreCase|ErrorAction\.handleAuthorizationError') {
                $authzCount++
                Write-CheckResult "Authorization" "Authorization check in $($file.Name)" $true
            } else {
                $missingAuthzCount++
                Write-CheckResult "Authorization" "Authorization check in $($file.Name)" $false `
                    "Admin endpoint without authorization check" "Critical"
            }
        }
    }
    
    Write-CheckResult "Authorization" "Admin controllers with authz checks: $authzCount" $true
    if ($missingAuthzCount -gt 0) {
        Write-CheckResult "Authorization" "Missing authorization checks" $false `
            "$missingAuthzCount admin controllers missing authorization" "Critical"
    }
}

function Test-ErrorActionUsage {
    Write-Host "`n=== Checking ErrorAction Usage for 403 ===" -ForegroundColor Cyan
    
    $controllerFiles = Get-ChildItem -Path "src\main\java\controller" -Filter "*.java" -Recurse -ErrorAction SilentlyContinue
    
    $errorActionCount = 0
    $directResponseCount = 0
    
    foreach ($file in $controllerFiles) {
        $content = Get-Content $file.FullName -Raw
        
        # Check for 403 responses
        if ($content -match 'SC_FORBIDDEN|403') {
            if ($content -match 'ErrorAction\.handleAuthorizationError') {
                $errorActionCount++
                Write-CheckResult "ErrorAction" "ErrorAction usage in $($file.Name)" $true
            } else {
                $directResponseCount++
                Write-CheckResult "ErrorAction" "ErrorAction usage in $($file.Name)" $false `
                    "Direct 403 response without ErrorAction" "High"
            }
        }
    }
    
    Write-CheckResult "ErrorAction" "Controllers using ErrorAction for 403: $errorActionCount" $true
    if ($directResponseCount -gt 0) {
        Write-CheckResult "ErrorAction" "Direct 403 responses" $false `
            "$directResponseCount instances of direct 403 responses" "High"
    }
}

function Test-ServletMappings {
    Write-Host "`n=== Checking Servlet Mappings (404 Prevention) ===" -ForegroundColor Cyan
    
    # Check web.xml
    $webXmlPath = "src\main\webapp\WEB-INF\web.xml"
    if (Test-Path $webXmlPath) {
        Write-CheckResult "Servlet Mapping" "web.xml exists" $true
        
        $webXml = Get-Content $webXmlPath -Raw
        
        # Count servlet mappings
        $servletCount = ([regex]::Matches($webXml, '<servlet>')).Count
        $mappingCount = ([regex]::Matches($webXml, '<servlet-mapping>')).Count
        
        if ($servletCount -eq $mappingCount) {
            Write-CheckResult "Servlet Mapping" "All servlets have mappings" $true
        } else {
            Write-CheckResult "Servlet Mapping" "All servlets have mappings" $false `
                "Mismatch: $servletCount servlets, $mappingCount mappings" "Critical"
        }
        
        # Check for @WebServlet annotations
        $javaFiles = Get-ChildItem -Path "src\main\java\controller" -Filter "*.java" -Recurse
        $webServletCount = 0
        
        foreach ($file in $javaFiles) {
            $content = Get-Content $file.FullName -Raw
            if ($content -match '@WebServlet') {
                $webServletCount++
            }
        }
        
        Write-CheckResult "Servlet Mapping" "@WebServlet annotations found: $webServletCount" $true
    } else {
        Write-CheckResult "Servlet Mapping" "web.xml exists" $false `
            "web.xml not found" "Critical"
    }
}

function Test-PathParameterValidation {
    Write-Host "`n=== Checking Path Parameter Validation (404 Prevention) ===" -ForegroundColor Cyan
    
    $controllerFiles = Get-ChildItem -Path "src\main\java\controller" -Filter "*.java" -Recurse -ErrorAction SilentlyContinue
    
    $validatedCount = 0
    $unvalidatedCount = 0
    
    foreach ($file in $controllerFiles) {
        $content = Get-Content $file.FullName -Raw
        
        # Check for pathInfo usage
        if ($content -match 'getPathInfo\(\)') {
            # Check if pathInfo is validated
            if ($content -match 'pathInfo\s*==\s*null|pathInfo\.isEmpty\(\)|SC_NOT_FOUND') {
                $validatedCount++
                Write-CheckResult "Path Validation" "Path validation in $($file.Name)" $true
            } else {
                $unvalidatedCount++
                Write-CheckResult "Path Validation" "Path validation in $($file.Name)" $false `
                    "PathInfo used without null/empty check" "High"
            }
        }
    }
    
    Write-CheckResult "Path Validation" "Controllers with path validation: $validatedCount" $true
    if ($unvalidatedCount -gt 0) {
        Write-CheckResult "Path Validation" "Missing path validation" $false `
            "$unvalidatedCount controllers missing path validation" "High"
    }
}

function Test-ResourceExistenceChecks {
    Write-Host "`n=== Checking Resource Existence Checks (404 Prevention) ===" -ForegroundColor Cyan
    
    $controllerFiles = Get-ChildItem -Path "src\main\java\controller" -Filter "*.java" -Recurse -ErrorAction SilentlyContinue
    
    $checkedCount = 0
    $uncheckedCount = 0
    
    foreach ($file in $controllerFiles) {
        $content = Get-Content $file.FullName -Raw
        
        # Check for DAO method calls that return single objects
        if ($content -match 'getProductById|getUserById|getOrderById|findById') {
            # Check if result is null-checked
            if ($content -match '==\s*null|SC_NOT_FOUND|not found') {
                $checkedCount++
                Write-CheckResult "Resource Check" "Resource existence check in $($file.Name)" $true
            } else {
                $uncheckedCount++
                Write-CheckResult "Resource Check" "Resource existence check in $($file.Name)" $false `
                    "Resource retrieval without null check" "High"
            }
        }
    }
    
    Write-CheckResult "Resource Check" "Controllers with resource checks: $checkedCount" $true
    if ($uncheckedCount -gt 0) {
        Write-CheckResult "Resource Check" "Missing resource checks" $false `
            "$uncheckedCount controllers missing resource existence checks" "High"
    }
}

function Test-ErrorPageConfiguration {
    Write-Host "`n=== Checking Error Page Configuration ===" -ForegroundColor Cyan
    
    $webXmlPath = "src\main\webapp\WEB-INF\web.xml"
    if (Test-Path $webXmlPath) {
        $webXml = Get-Content $webXmlPath -Raw
        
        # Check for 403 error page
        if ($webXml -match '<error-code>403</error-code>') {
            Write-CheckResult "Error Pages" "403 error page configured" $true
        } else {
            Write-CheckResult "Error Pages" "403 error page configured" $false `
                "403 error page not configured in web.xml" "High"
        }
        
        # Check for 404 error page
        if ($webXml -match '<error-code>404</error-code>') {
            Write-CheckResult "Error Pages" "404 error page configured" $true
        } else {
            Write-CheckResult "Error Pages" "404 error page configured" $false `
                "404 error page not configured in web.xml" "Critical"
        }
        
        # Check if error.jsp exists
        $errorPagePath = "src\main\webapp\error.jsp"
        if (Test-Path $errorPagePath) {
            Write-CheckResult "Error Pages" "error.jsp exists" $true
        } else {
            Write-CheckResult "Error Pages" "error.jsp exists" $false `
                "error.jsp not found" "Critical"
        }
    }
}

function Test-CSRFValidation {
    Write-Host "`n=== Checking CSRF Token Validation ===" -ForegroundColor Cyan
    
    $controllerFiles = Get-ChildItem -Path "src\main\java\controller" -Filter "*.java" -Recurse -ErrorAction SilentlyContinue
    
    $csrfCount = 0
    $missingCsrfCount = 0
    
    foreach ($file in $controllerFiles) {
        $content = Get-Content $file.FullName -Raw
        
        # Check for POST/PUT/DELETE methods
        if ($content -match 'doPost|doPut|doDelete') {
            # Check for CSRF validation
            if ($content -match 'validateCSRFToken|CSRF') {
                $csrfCount++
                Write-CheckResult "CSRF" "CSRF validation in $($file.Name)" $true
            } else {
                # Some endpoints might not need CSRF (public APIs, etc.)
                # Only flag if it's a state-changing operation
                if ($content -match 'delete|update|create|insert') {
                    $missingCsrfCount++
                    Write-CheckResult "CSRF" "CSRF validation in $($file.Name)" $false `
                        "State-changing operation without CSRF check" "High"
                }
            }
        }
    }
    
    Write-CheckResult "CSRF" "Controllers with CSRF validation: $csrfCount" $true
    if ($missingCsrfCount -gt 0) {
        Write-CheckResult "CSRF" "Missing CSRF validation" $false `
            "$missingCsrfCount controllers missing CSRF validation" "High"
    }
}

function Test-RedirectSecurity {
    Write-Host "`n=== Checking Redirect Security ===" -ForegroundColor Cyan
    
    $controllerFiles = Get-ChildItem -Path "src\main\java\controller" -Filter "*.java" -Recurse -ErrorAction SilentlyContinue
    
    $secureRedirectCount = 0
    $insecureRedirectCount = 0
    
    foreach ($file in $controllerFiles) {
        $content = Get-Content $file.FullName -Raw
        
        # Check for redirects
        if ($content -match 'sendRedirect') {
            # Check if redirect uses context path or validates URL
            if ($content -match 'getContextPath\(\)|startsWith\(.*getContextPath|startsWith\("/"\)') {
                $secureRedirectCount++
                Write-CheckResult "Redirect Security" "Secure redirect in $($file.Name)" $true
            } elseif ($content -match 'getParameter\("returnUrl"\)|getParameter\("redirect"\)') {
                $insecureRedirectCount++
                Write-CheckResult "Redirect Security" "Secure redirect in $($file.Name)" $false `
                    "Potential open redirect vulnerability" "Critical"
            }
        }
    }
    
    Write-CheckResult "Redirect Security" "Secure redirects: $secureRedirectCount" $true
    if ($insecureRedirectCount -gt 0) {
        Write-CheckResult "Redirect Security" "Insecure redirects" $false `
            "$insecureRedirectCount potential open redirect vulnerabilities" "Critical"
    }
}

function Test-InstanceofChecks {
    Write-Host "`n=== Checking instanceof Usage for Type Safety ===" -ForegroundColor Cyan
    
    $controllerFiles = Get-ChildItem -Path "src\main\java\controller" -Filter "*.java" -Recurse -ErrorAction SilentlyContinue
    
    $instanceofCount = 0
    $unsafeCastCount = 0
    
    foreach ($file in $controllerFiles) {
        $content = Get-Content $file.FullName -Raw
        
        # Check for session.getAttribute casts
        if ($content -match 'session\.getAttribute\("user"\)|getAttribute\("user"\)') {
            if ($content -match 'instanceof\s+User') {
                $instanceofCount++
                Write-CheckResult "Type Safety" "instanceof check in $($file.Name)" $true
            } elseif ($content -match '\(User\)\s*session|\(User\)\s*getAttribute') {
                $unsafeCastCount++
                Write-CheckResult "Type Safety" "instanceof check in $($file.Name)" $false `
                    "Unsafe cast without instanceof check" "High"
            }
        }
    }
    
    Write-CheckResult "Type Safety" "Controllers with instanceof checks: $instanceofCount" $true
    if ($unsafeCastCount -gt 0) {
        Write-CheckResult "Type Safety" "Unsafe casts" $false `
            "$unsafeCastCount instances of unsafe casting" "High"
    }
}

# Main execution
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "403/404 Error Prevention Checklist Validator" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# Run all checks
Test-AuthenticationChecks
Test-AuthorizationChecks
Test-ErrorActionUsage
Test-ServletMappings
Test-PathParameterValidation
Test-ResourceExistenceChecks
Test-ErrorPageConfiguration
Test-CSRFValidation
Test-RedirectSecurity
Test-InstanceofChecks

# Summary
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Validation Summary" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

Write-Host "`nTotal Checks: $script:TotalChecks" -ForegroundColor White
Write-Host "Passed: $($script:Passed.Count)" -ForegroundColor Green
Write-Host "Critical Issues: $($script:Issues.Count)" -ForegroundColor Red
Write-Host "Warnings: $($script:Warnings.Count)" -ForegroundColor Yellow

if ($script:Issues.Count -gt 0) {
    Write-Host "`n=== Critical Issues ===" -ForegroundColor Red
    foreach ($issue in $script:Issues) {
        Write-Host "  ✗ $issue" -ForegroundColor Red
    }
}

if ($script:Warnings.Count -gt 0) {
    Write-Host "`n=== Warnings ===" -ForegroundColor Yellow
    foreach ($warning in $script:Warnings) {
        Write-Host "  ⚠ $warning" -ForegroundColor Yellow
    }
}

# Exit code
if ($script:Issues.Count -gt 0) {
    Write-Host "`nValidation FAILED - Critical issues found!" -ForegroundColor Red
    exit 1
} elseif ($script:Warnings.Count -gt 0) {
    Write-Host "`nValidation PASSED with warnings" -ForegroundColor Yellow
    exit 0
} else {
    Write-Host "`nValidation PASSED - All checks successful!" -ForegroundColor Green
    exit 0
}

