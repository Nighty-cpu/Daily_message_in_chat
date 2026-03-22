# ==================== SETTINGS ====================
$program   = "C:\PythonProject3\start.bat"
$flagFile  = "$env:LOCALAPPDATA\last-run.flag" #сюда напишите куда сохранять файл флага
$logFile   = "$env:LOCALAPPDATA\debug-run.log" #сюда напишите куда сохранять файл дебага
# ==================================================

# ГАРАНТИЯ: создаём лог сразу, чтобы ты видел, что скрипт запустился
Add-Content $logFile "`n--- Script started at $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') ---" -Encoding utf8

try {
    $today = (Get-Date).ToString("yyyy-MM-dd")
	$hour = (Get-Date).Hour
	
	if ($hour -lt 7) {
		exit
	}
    Add-Content $logFile "Today value = '$today'" -Encoding utf8

    # ==================== УСЛОВИЕ С ЧАСАМИ (00:00–06:59) ====================
    # ======================================================================

    if (Test-Path $flagFile) {
        $lastRaw = Get-Content $flagFile -Raw -Encoding utf8
        $last = $lastRaw.Trim()
        Add-Content $logFile "Last from flag = '$last' (length $($last.Length))" -Encoding utf8
        
        if ($last -eq $today) {
            Add-Content $logFile "ALREADY RUN TODAY -> exit" -Encoding utf8
            exit
        }
    } else {
        Add-Content $logFile "No flag file yet" -Encoding utf8
    }

    $today | Out-File $flagFile -Encoding utf8 -Force
    Add-Content $logFile "FLAG SET (date $today). Launching bat..." -Encoding utf8

    $batDir = Split-Path $program -Parent
    $proc = Start-Process -FilePath $program -WorkingDirectory $batDir -WindowStyle Hidden -Wait -PassThru -ErrorAction Stop

    if ($proc.ExitCode -eq 0) {
        Add-Content $logFile "SUCCESS (ExitCode = 0)" -Encoding utf8
    } else {
        Add-Content $logFile "WARNING: ExitCode = $($proc.ExitCode)" -Encoding utf8
    }
}
catch {
    Add-Content $logFile "CRITICAL ERROR: $($_.Exception.Message)" -Encoding utf8
}

Add-Content $logFile "=== Script finished ===" -Encoding utf8
