# verify_links.ps1
# Recursively checks all markdown files in the docs directory for broken relative links.

$docsRoot = Resolve-Path "$PSScriptRoot\.."
$markdownFiles = Get-ChildItem -Path $docsRoot -Filter "*.md" -Recurse

$errorCount = 0
$checkedFiles = 0
$checkedLinks = 0

Write-Host "Starting link verification in: $docsRoot"
Write-Host "----------------------------------------"

foreach ($file in $markdownFiles) {
    $checkedFiles++
    $content = Get-Content $file.FullName -Raw
    
    # Regex to find markdown links: [text](link)
    # This is a basic regex and might need refinement for complex cases
    $links = [regex]::Matches($content, '\[.*?\]\((.*?)\)')

    foreach ($link in $links) {
        $url = $link.Groups[1].Value.Trim()
        
        # Skip empty links, anchors only, absolute URLs (http/https), and mailto
        if ([string]::IsNullOrWhiteSpace($url) -or $url.StartsWith("#") -or $url.StartsWith("http") -or $url.StartsWith("mailto:") -or $url.Contains("../../issues")) {
            continue
        }

        $checkedLinks++
        
        # Remove anchor from URL for file checking
        $filePath = $url -replace '#.*$', ''
        
        # Handle root-relative links (starting with /) - assuming relative to git root or docs root?
        # For this script, we'll assume relative to the current file unless it starts with /
        
        if ($filePath.StartsWith("/")) {
            # Assuming / refers to project root, but for docs we usually use relative paths.
            # Let's flag root-relative paths as potential issues if they don't resolve from docs root
            # Adjust this logic based on actual project structure if needed.
            $targetPath = Join-Path $docsRoot $filePath.TrimStart("/")
        }
        else {
            $targetPath = Join-Path $file.DirectoryName $filePath
        }

        # Check if file exists
        if (-not (Test-Path $targetPath)) {
            # Try checking if it's a directory (for README.md implicit linking)
            if (-not (Test-Path "$targetPath\README.md")) {
                Write-Host "BROKEN LINK: $($file.Name)" -ForegroundColor Red
                Write-Host "  Link: $url"
                Write-Host "  Resolved: $targetPath"
                Write-Host ""
                $errorCount++
            }
        }
    }
}

Write-Host "----------------------------------------"
Write-Host "Verification Complete."
Write-Host "Files Checked: $checkedFiles"
Write-Host "Links Checked: $checkedLinks"
Write-Host "Broken Links:  $errorCount"

if ($errorCount -gt 0) {
    exit 1
}
else {
    exit 0
}
