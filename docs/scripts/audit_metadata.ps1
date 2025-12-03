# audit_metadata.ps1
# Checks all markdown files in the docs directory for required metadata headers.

$docsRoot = Resolve-Path "$PSScriptRoot\.."
$markdownFiles = Get-ChildItem -Path $docsRoot -Filter "*.md" -Recurse

$errorCount = 0
$checkedFiles = 0

Write-Host "Starting metadata audit in: $docsRoot"
Write-Host "----------------------------------------"

foreach ($file in $markdownFiles) {
    # Skip ARCHIVE_INDEX.md, INDEX.md, and files in scripts/
    if ($file.Name -eq "ARCHIVE_INDEX.md" -or $file.Name -eq "INDEX.md" -or $file.DirectoryName -like "*\scripts*") {
        continue
    }

    $checkedFiles++
    $content = Get-Content $file.FullName -Raw
    
    # Check for metadata block at the end of the file
    # Pattern: **Document Version**: ... **Status**: ...
    
    $missingMetadata = @()
    
    if ($content -notmatch "\*\*Document Version\*\*:") { $missingMetadata += "Version" }
    if ($content -notmatch "\*\*Status\*\*:") { $missingMetadata += "Status" }
    if ($content -notmatch "\*\*Last Updated\*\*:") { $missingMetadata += "Last Updated" }
    if ($content -notmatch "\*\*Maintained By\*\*:") { $missingMetadata += "Maintained By" }

    if ($missingMetadata.Count -gt 0) {
        Write-Host "MISSING METADATA: $($file.Name)" -ForegroundColor Yellow
        Write-Host "  Missing: $($missingMetadata -join ', ')"
        Write-Host "  Path: $($file.FullName)"
        Write-Host ""
        $errorCount++
    }
}

Write-Host "----------------------------------------"
Write-Host "Audit Complete."
Write-Host "Files Checked: $checkedFiles"
Write-Host "Files with Issues: $errorCount"

if ($errorCount -gt 0) {
    exit 1
}
else {
    exit 0
}
