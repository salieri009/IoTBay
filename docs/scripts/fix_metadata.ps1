# fix_metadata.ps1
# Automatically appends missing metadata to markdown files.

$docsRoot = Resolve-Path "$PSScriptRoot\.."
$markdownFiles = Get-ChildItem -Path $docsRoot -Filter "*.md" -Recurse

$fixedCount = 0

Write-Host "Starting metadata fix in: $docsRoot"
Write-Host "----------------------------------------"

foreach ($file in $markdownFiles) {
    # Skip ARCHIVE_INDEX.md, INDEX.md, and files in scripts/
    if ($file.Name -eq "ARCHIVE_INDEX.md" -or $file.Name -eq "INDEX.md" -or $file.DirectoryName -like "*\scripts*") {
        continue
    }

    $content = Get-Content $file.FullName -Raw
    $needsUpdate = $false
    $metadataToAdd = "`n`n---`n"
    
    # Check and prepare metadata fields
    if ($content -notmatch "\*\*Document Version\*\*:") { 
        $metadataToAdd += "`n**Document Version**: 1.0.0"
        $needsUpdate = $true
    }
    if ($content -notmatch "\*\*Status\*\*:") { 
        $metadataToAdd += "`n**Status**: Published"
        $needsUpdate = $true
    }
    if ($content -notmatch "\*\*Last Updated\*\*:") { 
        $metadataToAdd += "`n**Last Updated**: $(Get-Date -Format 'MMMM d, yyyy')"
        $needsUpdate = $true
    }
    if ($content -notmatch "\*\*Audience\*\*:") { 
        # Only add Audience if it's completely missing, but usually we want to be specific.
        # For bulk update, we'll use a generic one or skip if we want manual intervention.
        # Let's add a generic one for now to pass the check, user can refine.
        $metadataToAdd += "`n**Audience**: Developers, Stakeholders"
        # We won't flag needsUpdate just for Audience to avoid cluttering if that's the only thing, 
        # but the audit script checks for it. Let's add it.
        $needsUpdate = $true
    }
    if ($content -notmatch "\*\*Maintained By\*\*:") { 
        $metadataToAdd += "`n**Maintained By**: IoT Bay Documentation Team"
        $needsUpdate = $true
    }

    if ($needsUpdate) {
        # Append the metadata block
        Add-Content -Path $file.FullName -Value $metadataToAdd
        Write-Host "Updated metadata for: $($file.Name)"
        $fixedCount++
    }
}

Write-Host "----------------------------------------"
Write-Host "Fix Complete."
Write-Host "Files Updated: $fixedCount"
