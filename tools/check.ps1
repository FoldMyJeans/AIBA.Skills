# check.ps1
# Enforces the rules in AGENTS.md. Run from the repo root before every commit:
#   pwsh -File tools\check.ps1
# Exit code 0 means clean. Any finding prints FAIL with the file and line and exits 1.
#
# This checks the repo. It does not check a project's workbook, which is what
# scripts\validate_workbook.py is for. The two do not overlap.

$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$fail = @()

function Add-Fail($file, $line, $msg) {
    $rel = $file.Replace("$root\", '')
    $script:fail += [pscustomobject]@{ File = $rel; Line = $line; Problem = $msg }
}

# Strip fenced blocks and inline code spans so samples are exempt from the prose rules.
function Get-ProseLines($path) {
    $inFence = $false
    $n = 0
    foreach ($line in (Get-Content $path)) {
        $n++
        if ($line -match '^\s*```') { $inFence = -not $inFence; continue }
        if (-not $inFence) { [pscustomobject]@{ N = $n; Text = ($line -replace '`[^`]*`', '') } }
    }
}

$mdFiles = Get-ChildItem $root -Recurse -Filter *.md |
    Where-Object { $_.FullName -notlike '*\.git\*' }

foreach ($f in $mdFiles) {
    foreach ($l in Get-ProseLines $f.FullName) {
        if ($l.Text -match '[–—]') { Add-Fail $f.FullName $l.N 'em dash or en dash in prose' }
    }
}

# Skill folder rules.
$skillDirs = Get-ChildItem "$root\skills" -Directory
foreach ($d in $skillDirs) {
    $skillMd = Join-Path $d.FullName 'SKILL.md'
    if (-not (Test-Path $skillMd)) { Add-Fail $d.FullName 0 'skill folder has no SKILL.md'; continue }

    $raw = Get-Content $skillMd -Raw

    $fm = [regex]::Match($raw, '(?s)\A---\r?\n(.*?)\r?\n---')
    if (-not $fm.Success) { Add-Fail $skillMd 1 'no YAML frontmatter'; continue }

    # Count the body, not the frontmatter. The description has its own cap in characters, and
    # counting it twice would penalise wrapping a long description onto readable lines.
    $body = $raw.Substring($fm.Index + $fm.Length)
    $lineCount = ($body -split "\r?\n").Count
    if ($lineCount -gt 150) { Add-Fail $skillMd $lineCount "SKILL.md body is $lineCount lines, cap is 150" }

    $name = [regex]::Match($fm.Groups[1].Value, '(?m)^name:\s*(\S+)').Groups[1].Value
    if ($name -ne $d.Name) { Add-Fail $skillMd 2 "frontmatter name '$name' does not match folder '$($d.Name)'" }

    $desc = [regex]::Match($fm.Groups[1].Value, '(?s)description:\s*>-\s*\r?\n(.*)$').Groups[1].Value -replace '\s+', ' '
    $desc = $desc.Trim()
    if ($desc.Length -eq 0)    { Add-Fail $skillMd 3 'description is empty or not a >- block' }
    if ($desc.Length -gt 1024) { Add-Fail $skillMd 3 "description is $($desc.Length) chars, cap is 1024" }

    Get-ChildItem (Join-Path $d.FullName 'references') -Filter *.md -ErrorAction SilentlyContinue | ForEach-Object {
        $rc = (Get-Content $_.FullName).Count
        if ($rc -gt 300) { Add-Fail $_.FullName $rc "reference is $rc lines, cap is 300, split it by topic" }
    }
}

# No path reference may leave its own skill folder. Point at another skill by name, because a
# skill folder has to survive being copied on its own into ~/.agents/skills.
$skillNames = ($skillDirs | ForEach-Object { $_.Name }) -join '|'
$pathPatterns = @(
    @{ Rx = '(?<![.\w])\.\./';                     Msg = 'relative path escapes the skill folder' }
    @{ Rx = "(?:$skillNames)[\\/]references[\\/]"; Msg = 'cross skill path, name the skill instead of its path' }
    @{ Rx = '(?<!agents[\\/])skills[\\/]';         Msg = 'repo relative path, name the skill instead' }
)
Get-ChildItem "$root\skills" -Recurse -Include *.md, *.json | ForEach-Object {
    $file = $_.FullName
    $n = 0
    foreach ($line in (Get-Content $file)) {
        $n++
        foreach ($p in $pathPatterns) {
            if ($line -match $p.Rx) { Add-Fail $file $n $p.Msg }
        }
    }
}

# assets/ does not travel when one skill folder is copied into ~/.agents/skills, and the xlsx
# templates cannot sensibly live inside every skill. So a skill may point at them, as long as
# it names the repo, which leaves the reader somewhere to go.
Get-ChildItem "$root\skills" -Recurse -Filter *.md | ForEach-Object {
    $file = $_.FullName
    $n = 0
    foreach ($line in (Get-Content $file)) {
        $n++
        if ($line -match 'assets[\\/]' -and $line -notmatch 'AIBA\.Skills') {
            Add-Fail $file $n 'points at assets/ without naming the repo it lives in'
        }
    }
}

# Every references/x.md pointer must resolve inside its own skill.
foreach ($d in $skillDirs) {
    Get-ChildItem $d.FullName -Recurse -Filter *.md | ForEach-Object {
        $src = $_.FullName
        $n = 0
        foreach ($line in (Get-Content $src)) {
            $n++
            foreach ($m in [regex]::Matches($line, 'references/([A-Za-z0-9._-]+\.(?:md|json))')) {
                $target = Join-Path $d.FullName "references\$($m.Groups[1].Value)"
                if (-not (Test-Path $target)) {
                    Add-Fail $src $n "points at references/$($m.Groups[1].Value), which does not exist in this skill"
                }
            }
        }
    }
}

# Every skill named in prose must exist. A pointer at a skill that was renamed or never
# written sends an agent looking for a file that is not there.
$known = $skillDirs | ForEach-Object { $_.Name }
Get-ChildItem $root -Recurse -Filter *.md |
    Where-Object { $_.FullName -notlike '*\.git\*' } | ForEach-Object {
        $file = $_.FullName
        $n = 0
        foreach ($line in (Get-Content $file)) {
            $n++
            foreach ($m in [regex]::Matches($line, '\bba-[a-z][a-z-]*\b')) {
                if ($known -notcontains $m.Value) {
                    Add-Fail $file $n "names skill '$($m.Value)', which does not exist"
                }
            }
        }
    }

# Redaction. Everything here is public.
# Add local terms in tools\banned.local.txt, one regex per line, blank lines and # comments
# skipped. Git ignores that file, so terms specific to your own clients stay out of the repo.
$banned = @(
    @{ Rx = '(?i)\b[a-z0-9._%+-]+@(?!example\.com)[a-z0-9.-]+\.[a-z]{2,}\b'; Msg = 'real looking email address' }
    @{ Rx = '(?i)https?://(?!localhost|example\.|github\.com|anthropic\.com|w3\.org)[a-z0-9.-]+\.(?:com|ca|io|net)/'; Msg = 'live URL, check it is not a client or an internal host' }
)
$localTerms = Join-Path $PSScriptRoot 'banned.local.txt'
if (Test-Path $localTerms) {
    foreach ($line in Get-Content $localTerms) {
        $rx = $line.Trim()
        if ($rx -and -not $rx.StartsWith('#')) {
            $banned += @{ Rx = "(?i)$rx"; Msg = 'local banned term, use a role or a placeholder' }
        }
    }
}
Get-ChildItem $root -Recurse -Include *.md, *.json, *.ps1, *.py |
    Where-Object { $_.FullName -notlike '*\.git\*' } | ForEach-Object {
        $file = $_.FullName
        $n = 0
        foreach ($line in (Get-Content $file)) {
            $n++
            foreach ($b in $banned) {
                if ($line -match $b.Rx) { Add-Fail $file $n $b.Msg }
            }
        }
    }

# Every JSON in the repo must parse.
Get-ChildItem $root -Recurse -Filter *.json |
    Where-Object { $_.FullName -notlike '*\.git\*' } | ForEach-Object {
        $jsonFile = $_.FullName
        try { Get-Content $jsonFile -Raw | ConvertFrom-Json | Out-Null }
        catch { Add-Fail $jsonFile 0 "invalid JSON: $($_.Exception.Message)" }
    }

# Every reference file must be named in its own SKILL.md, or an agent never loads it.
foreach ($skillDir in $skillDirs) {
    $skillMd = Join-Path $skillDir.FullName 'SKILL.md'
    if (-not (Test-Path $skillMd)) { continue }
    $skillText = Get-Content $skillMd -Raw
    $refDir = Join-Path $skillDir.FullName 'references'
    if (-not (Test-Path $refDir)) { continue }
    Get-ChildItem $refDir -File | ForEach-Object {
        if ($skillText -notmatch [regex]::Escape($_.Name)) {
            Add-Fail $skillMd 0 "reference '$($_.Name)' is not mentioned in SKILL.md"
        }
    }
}

# Every skill must be listed in README.md, so a new one cannot ship undiscoverable.
$readme = Get-Content (Join-Path $root 'README.md') -Raw
foreach ($d in $skillDirs) {
    if ($readme -notmatch [regex]::Escape($d.Name)) {
        Add-Fail (Join-Path $root 'README.md') 0 "skill '$($d.Name)' is not listed in README.md"
    }
}

# The workbook vocabularies are the contract between the field set in ba-user-stories, the
# validator, and the generated templates. Run both scripts' own checks so a change to one
# cannot silently drift from the others.
if (Get-Command python -ErrorAction SilentlyContinue) {
    Push-Location $root
    try {
        $out = python scripts/validate_workbook.py --selfcheck 2>&1
        if ($LASTEXITCODE -ne 0) { Add-Fail "$root\scripts\validate_workbook.py" 0 "selfcheck failed: $out" }
        $out = python scripts/make_templates.py --verify 2>&1
        if ($LASTEXITCODE -ne 0) { Add-Fail "$root\scripts\make_templates.py" 0 "templates no longer match the vocabularies: $out" }
        $out = python scripts/check_doc_contract.py 2>&1
        if ($LASTEXITCODE -ne 0) { Add-Fail "$root\skills\ba-user-stories\SKILL.md" 0 "field table disagrees with the code: $out" }
    } finally { Pop-Location }
} else {
    Write-Output "note: python not found, skipped the workbook vocabulary checks"
}

if ($fail.Count -eq 0) {
    Write-Output "PASS. $($mdFiles.Count) markdown files, $($skillDirs.Count) skills, no findings."
    exit 0
}

Write-Output "FAIL. $($fail.Count) finding(s):"
$fail | Sort-Object File, Line | Format-Table -AutoSize | Out-String | Write-Output
exit 1
