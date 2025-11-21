# 500 Error Prevention Checklist Validator
# Automatically validates many items from the 500_ERROR_PREVENTION_CHECKLIST.md
# Usage: .\scripts\validate-500-prevention.ps1

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

function Test-NullChecks {
    Write-Host "`n=== Checking Null Pointer Prevention ===" -ForegroundColor Cyan
    
    $javaFiles = Get-ChildItem -Path "src\main\java" -Filter "*.java" -Recurse
    
    foreach ($file in $javaFiles) {
        $content = Get-Content $file.FullName -Raw
        
        # Check for session.getAttribute without null check
        if ($content -match 'session\.getAttribute\("user"\)' -and 
            $content -notmatch 'if\s*\(.*user.*==\s*null|user\s*==\s*null|user\s*!=.*null') {
            Write-CheckResult "Null Checks" "Session attribute null check in $($file.Name)" $false `
                "Session attribute accessed without null check" "Critical"
        }
        
        # Check for request.getParameter without validation
        if ($content -match 'request\.getParameter\(' -and 
            $content -notmatch 'SecurityUtil\.getValidatedStringParameter|SecurityUtil\.getValidatedIntParameter') {
            # Allow some exceptions (like password fields)
            if ($content -notmatch 'password|confirmPassword') {
                Write-CheckResult "Null Checks" "Request parameter validation in $($file.Name)" $false `
                    "Direct request.getParameter() usage without SecurityUtil validation" "High"
            }
        }
    }
    
    Write-CheckResult "Null Checks" "Null check analysis completed" $true
}

function Test-ResourceManagement {
    Write-Host "`n=== Checking Resource Management ===" -ForegroundColor Cyan
    
    $daoFiles = Get-ChildItem -Path "src\main\java\dao" -Filter "*.java" -Recurse -ErrorAction SilentlyContinue
    
    foreach ($file in $daoFiles) {
        $content = Get-Content $file.FullName -Raw
        
        # Check for PreparedStatement usage
        if ($content -match 'PreparedStatement') {
            # Check if using try-with-resources
            if ($content -match 'try\s*\([^)]*PreparedStatement') {
                Write-CheckResult "Resource Management" "Try-with-resources in $($file.Name)" $true
            } else {
                Write-CheckResult "Resource Management" "Try-with-resources in $($file.Name)" $false `
                    "PreparedStatement not using try-with-resources" "Critical"
            }
        }
        
        # Check for ResultSet usage
        if ($content -match 'ResultSet') {
            if ($content -match 'try\s*\([^)]*ResultSet') {
                Write-CheckResult "Resource Management" "ResultSet try-with-resources in $($file.Name)" $true
            } else {
                Write-CheckResult "Resource Management" "ResultSet try-with-resources in $($file.Name)" $false `
                    "ResultSet not using try-with-resources" "Critical"
            }
        }
    }
    
    Write-CheckResult "Resource Management" "Resource management analysis completed" $true
}

function Test-ErrorHandling {
    Write-Host "`n=== Checking Error Handling ===" -ForegroundColor Cyan
    
    $controllerFiles = Get-ChildItem -Path "src\main\java\controller" -Filter "*.java" -Recurse -ErrorAction SilentlyContinue
    
    foreach ($file in $controllerFiles) {
        $content = Get-Content $file.FullName -Raw
        
        # Check for doGet/doPost methods
        if ($content -match 'doGet|doPost') {
            # Check if they have try-catch
            if ($content -match 'try\s*\{[\s\S]*catch') {
                Write-CheckResult "Error Handling" "Try-catch in $($file.Name)" $true
            } else {
                Write-CheckResult "Error Handling" "Try-catch in $($file.Name)" $false `
                    "doGet/doPost method without exception handling" "Critical"
            }
            
            # Check for ErrorAction usage
            if ($content -match 'ErrorAction\.(handleDatabaseError|handleServerError|handleValidationError)') {
                Write-CheckResult "Error Handling" "ErrorAction usage in $($file.Name)" $true
            } else {
                Write-CheckResult "Error Handling" "ErrorAction usage in $($file.Name)" $false `
                    "Not using ErrorAction utility for error handling" "High"
            }
        }
    }
    
    Write-CheckResult "Error Handling" "Error handling analysis completed" $true
}

function Test-SQLInjection {
    Write-Host "`n=== Checking SQL Injection Prevention ===" -ForegroundColor Cyan
    
    $javaFiles = Get-ChildItem -Path "src\main\java" -Filter "*.java" -Recurse
    
    foreach ($file in $javaFiles) {
        $content = Get-Content $file.FullName -Raw
        
        # Check for string concatenation in SQL
        if ($content -match 'SELECT|INSERT|UPDATE|DELETE') {
            # Look for dangerous patterns
            if ($content -match '".*SELECT.*"\s*\+|".*INSERT.*"\s*\+|".*UPDATE.*"\s*\+') {
                Write-CheckResult "SQL Injection" "SQL string concatenation in $($file.Name)" $false `
                    "Potential SQL injection: string concatenation in SQL queries" "Critical"
            } elseif ($content -match 'PreparedStatement') {
                Write-CheckResult "SQL Injection" "PreparedStatement usage in $($file.Name)" $true
            }
        }
    }
    
    Write-CheckResult "SQL Injection" "SQL injection prevention analysis completed" $true
}

function Test-Logging {
    Write-Host "`n=== Checking Logging Configuration ===" -ForegroundColor Cyan
    
    $javaFiles = Get-ChildItem -Path "src\main\java" -Filter "*.java" -Recurse
    
    $loggerCount = 0
    $staticLoggerCount = 0
    
    foreach ($file in $javaFiles) {
        $content = Get-Content $file.FullName -Raw
        
        if ($content -match 'Logger\.getLogger') {
            $loggerCount++
            
            # Check if logger is static final
            if ($content -match 'private\s+static\s+final\s+Logger') {
                $staticLoggerCount++
                Write-CheckResult "Logging" "Static final logger in $($file.Name)" $true
            } else {
                Write-CheckResult "Logging" "Static final logger in $($file.Name)" $false `
                    "Logger should be static final" "Medium"
            }
        }
    }
    
    Write-CheckResult "Logging" "Logger instances found: $loggerCount" $true
    Write-CheckResult "Logging" "Static final loggers: $staticLoggerCount/$loggerCount" `
        ($staticLoggerCount -eq $loggerCount) "Not all loggers are static final" "Medium"
}

function Test-Configuration {
    Write-Host "`n=== Checking Configuration Files ===" -ForegroundColor Cyan
    
    # Check application.properties
    $propsPath = "src\main\resources\application.properties"
    if (Test-Path $propsPath) {
        Write-CheckResult "Configuration" "application.properties exists" $true
        
        $props = Get-Content $propsPath
        $requiredProps = @("db.url", "db.driver")
        
        foreach ($prop in $requiredProps) {
            $found = $props | Where-Object { $_ -match "^$prop\s*=" }
            Write-CheckResult "Configuration" "Property $prop exists" ($found -ne $null) `
                "Required property $prop not found" "Critical"
        }
    } else {
        Write-CheckResult "Configuration" "application.properties exists" $false `
            "application.properties not found" "Critical"
    }
    
    # Check web.xml
    $webXmlPath = "src\main\webapp\WEB-INF\web.xml"
    if (Test-Path $webXmlPath) {
        Write-CheckResult "Configuration" "web.xml exists" $true
        
        $webXml = Get-Content $webXmlPath -Raw
        
        # Check for error pages
        if ($webXml -match '<error-page>') {
            Write-CheckResult "Configuration" "Error pages configured in web.xml" $true
            
            if ($webXml -match '<error-code>500</error-code>') {
                Write-CheckResult "Configuration" "500 error page configured" $true
            } else {
                Write-CheckResult "Configuration" "500 error page configured" $false `
                    "500 error page not configured" "High"
            }
        } else {
            Write-CheckResult "Configuration" "Error pages configured in web.xml" $false `
                "No error pages configured" "High"
        }
    } else {
        Write-CheckResult "Configuration" "web.xml exists" $false `
            "web.xml not found" "Critical"
    }
}

function Test-BuildConfiguration {
    Write-Host "`n=== Checking Build Configuration ===" -ForegroundColor Cyan
    
    # Check pom.xml
    $pomPath = "pom.xml"
    if (Test-Path $pomPath) {
        Write-CheckResult "Build" "pom.xml exists" $true
        
        $pom = Get-Content $pomPath -Raw
        
        # Check Java version
        if ($pom -match 'maven\.compiler\.(source|target).*1\.8|release.*8') {
            Write-CheckResult "Build" "Java 8 target configured" $true
        } else {
            Write-CheckResult "Build" "Java 8 target configured" $false `
                "Java version not set to 8" "High"
        }
        
        # Check for WAR packaging
        if ($pom -match '<packaging>war</packaging>') {
            Write-CheckResult "Build" "WAR packaging configured" $true
        } else {
            Write-CheckResult "Build" "WAR packaging configured" $false `
                "Not configured as WAR" "High"
        }
    } else {
        Write-CheckResult "Build" "pom.xml exists" $false `
            "pom.xml not found" "Critical"
    }
}

function Test-ErrorPage {
    Write-Host "`n=== Checking Error Pages ===" -ForegroundColor Cyan
    
    $errorPagePath = "src\main\webapp\error.jsp"
    if (Test-Path $errorPagePath) {
        Write-CheckResult "Error Pages" "error.jsp exists" $true
        
        $errorPage = Get-Content $errorPagePath -Raw
        
        # Check if it exposes stack traces (bad)
        if ($errorPage -match 'printStackTrace|getStackTrace|Exception\.getMessage') {
            Write-CheckResult "Error Pages" "error.jsp doesn't expose stack traces" $false `
                "Error page may expose sensitive information" "High"
        } else {
            Write-CheckResult "Error Pages" "error.jsp doesn't expose stack traces" $true
        }
    } else {
        Write-CheckResult "Error Pages" "error.jsp exists" $false `
            "error.jsp not found" "Critical"
    }
}

function Test-InputValidation {
    Write-Host "`n=== Checking Input Validation ===" -ForegroundColor Cyan
    
    $controllerFiles = Get-ChildItem -Path "src\main\java\controller" -Filter "*.java" -Recurse -ErrorAction SilentlyContinue
    
    $validationCount = 0
    $directParamCount = 0
    
    foreach ($file in $controllerFiles) {
        $content = Get-Content $file.FullName -Raw
        
        # Count SecurityUtil usage
        if ($content -match 'SecurityUtil\.(getValidatedStringParameter|getValidatedIntParameter|getValidatedDoubleParameter)') {
            $validationCount++
        }
        
        # Count direct parameter access (excluding passwords)
        if ($content -match 'request\.getParameter\(' -and $content -notmatch 'password|confirmPassword') {
            $directParamCount++
        }
    }
    
    Write-CheckResult "Input Validation" "Controllers using SecurityUtil: $validationCount" $true
    if ($directParamCount -gt 0) {
        Write-CheckResult "Input Validation" "Direct parameter access (non-password)" $false `
            "$directParamCount instances of direct parameter access found" "High"
    } else {
        Write-CheckResult "Input Validation" "Direct parameter access (non-password)" $true
    }
}

function Test-ConnectionPool {
    Write-Host "`n=== Checking Connection Pool ===" -ForegroundColor Cyan
    
    $poolFile = "src\main\java\db\ConnectionPool.java"
    if (Test-Path $poolFile) {
        Write-CheckResult "Connection Pool" "ConnectionPool class exists" $true
        
        $content = Get-Content $poolFile -Raw
        
        # Check for singleton pattern
        if ($content -match 'getInstance\(\)') {
            Write-CheckResult "Connection Pool" "Singleton pattern implemented" $true
        } else {
            Write-CheckResult "Connection Pool" "Singleton pattern implemented" $false `
                "ConnectionPool should use singleton pattern" "High"
        }
        
        # Check for connection release method
        if ($content -match 'releaseConnection') {
            Write-CheckResult "Connection Pool" "releaseConnection method exists" $true
        } else {
            Write-CheckResult "Connection Pool" "releaseConnection method exists" $false `
                "Connection release method not found" "Critical"
        }
    } else {
        Write-CheckResult "Connection Pool" "ConnectionPool class exists" $false `
            "ConnectionPool not found" "High"
    }
}

# Main execution
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "500 Error Prevention Checklist Validator" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# Run all checks
Test-NullChecks
Test-ResourceManagement
Test-ErrorHandling
Test-SQLInjection
Test-Logging
Test-Configuration
Test-BuildConfiguration
Test-ErrorPage
Test-InputValidation
Test-ConnectionPool

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

