# limpiar-espacios.ps1 - Versión corregida
$projectPath = "C:\rod_apps\proyecto_qr"
$htmlFiles = Get-ChildItem -Path $projectPath -Filter *.html

foreach ($file in $htmlFiles) {
    Write-Host "Procesando: $($file.Name)" -ForegroundColor Cyan

    # Crear copia de respaldo
    Copy-Item $file.FullName -Destination "$($file.FullName).bak" -Force

    # Leer todas las líneas
    $lines = Get-Content $file.FullName

    # Procesar línea por línea
    $newLines = @()
    foreach ($line in $lines) {
        # Limpiar espacios al final dentro de src="..."
        if ($line -match 'src\s*=\s*["''].*["'']') {
            $line = $line -replace '(["''])\s+["'']', '$1"'
            $line = $line -replace '=["'']([^"'']*?)\s+["'']', '="$1"'
        }
        # Limpiar espacios al final en SCRIPT_URL
        if ($line -match 'SCRIPT_URL') {
            $line = $line -replace '=["'']([^"'']*?)\s+["'']', '="$1"'
        }
        $newLines += $line
    }

    # Guardar el archivo corregido
    Set-Content -Path $file.FullName -Value $newLines -Encoding UTF8
}

Write-Host "✅ Limpieza completada. Copias de respaldo (.bak) creadas." -ForegroundColor Green