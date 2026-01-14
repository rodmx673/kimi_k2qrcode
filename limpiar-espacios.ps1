# limpiar-espacios.ps1 - Versión mejorada
$projectPath = "C:\rod_apps\proyecto_qr"
$htmlFiles = Get-ChildItem -Path $projectPath -Filter *.html

foreach ($file in $htmlFiles) {
    Write-Host "Procesando: $($file.Name)" -ForegroundColor Cyan

    # Crear copia de respaldo
    Copy-Item $file.FullName -Destination "$($file.FullName).bak" -Force

    # Leer contenido completo
    $content = Get-Content $file.FullName -Raw

    # Limpiar espacios al final en src="URL  "
    $content = $content -replace '(src\s*=\s*["''])[^"'']*?(\s+)["'']', '$1$2'.TrimEnd() + '"'

    # Limpiar espacios al final en SCRIPT_URL = "URL  ";
    $content = $content -replace '(const\s+SCRIPT_URL\s*=\s*["''])[^"'']*?(\s+)["'']', '$1$2'.TrimEnd() + '"'

    # Guardar el archivo corregido
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
}

Write-Host "✅ Limpieza completada. Copias de respaldo (.bak) creadas." -ForegroundColor Green