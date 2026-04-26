# Regenerate index.html from index.md (Pandoc). Run from this folder.
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

$title = "Modding KotOR on iOS"
$description = "Guide to modding Star Wars: KotOR and The Sith Lords on iOS: IPAs, ipatool, TSLPatcher, Sideloadly, and troubleshooting."

& pandoc "index.md" -f markdown -t html5 -s -c styles.css -o "index.html" `
  -M "title=$title" -M "description=$description" `
  --toc --toc-depth=3 `
  --include-before-body="_include-before.html" `
  --include-after-body="_include-after.html" `
  --section-divs

$html = [IO.File]::ReadAllText((Join-Path $PSScriptRoot "index.html"))

# One document title: remove standalone metadata header (body h1 remains)
$html = $html -replace '(?s)<header id="title-block-header">.*?</header>\s*', ''
$html = $html -replace '<meta name="author" content="" />\r?\n', ''
$html = $html -replace '<nav id="TOC" role="doc-toc">', '<nav id="TOC" role="doc-toc" aria-label="Table of contents">'

if ($html -notmatch "theme-color") {
  $line = "  " + '<meta name="theme-color" content="#faf9f6" media="(prefers-color-scheme: light)">' + [Environment]::NewLine
  $line += "  " + '<meta name="theme-color" content="#0f1216" media="(prefers-color-scheme: dark)">' + [Environment]::NewLine
  $html = $html -replace "(  <title>.*?</title>\r?\n)", ('$1' + $line)
}
$utf8 = New-Object System.Text.UTF8Encoding $false
[IO.File]::WriteAllText((Join-Path $PSScriptRoot "index.html"), $html, $utf8)
Write-Host "Wrote index.html"

# Optional: refresh downloadable RTF to match the markdown source
& pandoc "index.md" -f markdown -o "Modding_Kotor_on_iOS.rtf" 2>$null
if (Test-Path "Modding_Kotor_on_iOS.rtf") { Write-Host "Wrote Modding_Kotor_on_iOS.rtf" }
