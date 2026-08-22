$ErrorActionPreference = "SilentlyContinue"

$Version = "1.0.0"
$PlanName = "xCooler"
$BackupPath = Join-Path $env:ProgramData "xCooler.previous"
$StatePath = Join-Path $env:ProgramData "xCooler.state"

$Processor = "54533251-82be-4824-96c1-47b60b740d00"
$CoreMin = "0cc5b647-c1df-4637-891a-dec35c318583"
$CoreMax = "ea062031-0e34-4ff1-9b6d-eb1059334028"
$IdleDisable = "5d76a2ca-e8c0-402f-a133-2158492d58ad"

$PCIExpress = "501a4d13-42af-4429-9fd1-a8218c268e20"
$ASPM = "ee12f906-d277-404b-b6da-e5fa1a576df5"

$USB = "2a737441-1930-4402-8d77-b2bebba308a3"
$USBSuspend = "48e6b7a6-50f5-4782-a5d4-53bb8f07e226"

$Wireless = "19cbb8fa-5279-450e-9fac-8a3d5fedd0c1"
$WirelessPower = "12bbebe6-58d6-4636-95bb-3217ef867c1a"

$IntelGraphics = "44f3beca-a7c0-460e-9df2-bb8b99e0cba6"
$IntelGraphicsPower = "3619c3f2-afb2-4afc-b0e9-e7fef372de36"

$Display = "7516b95f-f776-4464-8c53-06167f40cc99"
$DisplayTimeout = "3c0bc021-c8a8-4e07-a973-6b14cbcb2b7e"

$Sleep = "238c9fa8-0aad-41ed-83f4-97be242c8f20"
$HybridSleep = "94ac6d29-73ce-41a6-809f-6363ba21b47e"
$SleepAfter = "29f6c1db-86da-48c5-9fdb-f2b67b1f44da"

function Is-Admin {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = [Security.Principal.WindowsPrincipal]::new($identity)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Get-ActivePlan {
    $output = powercfg /getactivescheme 2>&1

    if ($output -match "Power Scheme GUID:\s*([a-fA-F0-9-]+)\s+\((.+)\)") {
        return [PSCustomObject]@{
            Guid = $matches[1]
            Name = $matches[2]
        }
    }

    return $null
}

function Get-PlanGuid {
    $output = powercfg /list 2>&1

    foreach ($line in $output) {
        if ($line -match "Power Scheme GUID:\s*([a-fA-F0-9-]+)\s+\((.+)\)") {
            if ($matches[2].Trim() -ieq $PlanName) {
                return $matches[1]
            }
        }
    }

    return $null
}

function Test-PowerSetting {
    param(
        [string]$Plan,
        [string]$Subgroup,
        [string]$Setting
    )

    $output = powercfg /query $Plan $Subgroup $Setting 2>&1

    return ($output -match "Power Setting GUID:")
}

function Set-ACSetting {
    param(
        [string]$Plan,
        [string]$Subgroup,
        [string]$Setting,
        [int]$Value
    )

    if (Test-PowerSetting $Plan $Subgroup $Setting) {
        powercfg /setacvalueindex $Plan $Subgroup $Setting $Value | Out-Null
    }
}

function Create-XCooler {
    $existing = Get-PlanGuid

    if ($existing) {
        return $existing
    }

    $output = powercfg /duplicatescheme SCHEME_BALANCED 2>&1

    if ($output -notmatch "Power Scheme GUID:\s*([a-fA-F0-9-]+)") {
        return $null
    }

    $guid = $matches[1]

    powercfg /changename $guid $PlanName | Out-Null

    Set-ACSetting $guid $Processor $CoreMin 100
    Set-ACSetting $guid $Processor $CoreMax 100
    Set-ACSetting $guid $Processor $IdleDisable 0

    Set-ACSetting $guid $PCIExpress $ASPM 0

    Set-ACSetting $guid $USB $USBSuspend 0

    Set-ACSetting $guid $Wireless $WirelessPower 0

    Set-ACSetting $guid $IntelGraphics $IntelGraphicsPower 1

    Set-ACSetting $guid $Display $DisplayTimeout 0

    Set-ACSetting $guid $Sleep $HybridSleep 0
    Set-ACSetting $guid $Sleep $SleepAfter 0

    powercfg /setactive $guid | Out-Null

    return $guid
}

function Save-PreviousPlan {
    $active = Get-ActivePlan

    if (-not $active) {
        return
    }

    $xCooler = Get-PlanGuid

    if ($xCooler -and $active.Guid -ieq $xCooler) {
        return
    }

    Set-Content -Path $BackupPath -Value $active.Guid -Encoding ASCII
}

function Turn-On {
    $xCooler = Get-PlanGuid

    if (-not $xCooler) {
        $xCooler = Create-XCooler
    }

    if (-not $xCooler) {
        Write-Host ""
        Write-Host "Unable to create xCooler." -ForegroundColor Red
        Start-Sleep -Seconds 2
        return
    }

    $active = Get-ActivePlan

    if ($active -and $active.Guid -ine $xCooler) {
        Save-PreviousPlan
    }

    powercfg /setactive $xCooler | Out-Null

    Set-Content -Path $StatePath -Value "ON" -Encoding ASCII
}

function Turn-Off {
    $xCooler = Get-PlanGuid
    $active = Get-ActivePlan

    if (-not $xCooler) {
        return
    }

    if (-not $active -or $active.Guid -ine $xCooler) {
        return
    }

    $restored = $false

    if (Test-Path $BackupPath) {
        $previous = (Get-Content $BackupPath -ErrorAction SilentlyContinue | Select-Object -First 1).Trim()

        if ($previous) {
            $plans = powercfg /list 2>&1

            if ($plans -match [regex]::Escape($previous)) {
                powercfg /setactive $previous | Out-Null
                $restored = $true
            }
        }
    }

    if (-not $restored) {
        powercfg /setactive SCHEME_BALANCED | Out-Null
    }

    Remove-Item $BackupPath -Force -ErrorAction SilentlyContinue
    Set-Content -Path $StatePath -Value "OFF" -Encoding ASCII
}

function Get-XCoolerStatus {
    $active = Get-ActivePlan
    $xCooler = Get-PlanGuid

    if (-not $xCooler) {
        return "NOT INSTALLED"
    }

    if ($active -and $active.Guid -ieq $xCooler) {
        return "ON"
    }

    return "OFF"
}

function Remove-XCooler {
    $xCooler = Get-PlanGuid

    if (-not $xCooler) {
        Write-Host ""
        Write-Host "xCooler is not installed." -ForegroundColor DarkGray
        Start-Sleep -Seconds 2
        return
    }

    $active = Get-ActivePlan

    if ($active -and $active.Guid -ieq $xCooler) {
        Turn-Off
    }

    powercfg /delete $xCooler | Out-Null

    Remove-Item $BackupPath -Force -ErrorAction SilentlyContinue
    Remove-Item $StatePath -Force -ErrorAction SilentlyContinue

    Write-Host ""
    Write-Host "xCooler removed." -ForegroundColor Cyan
    Start-Sleep -Seconds 2
}

function Show-Header {
    Clear-Host

    Write-Host ""
    Write-Host "██╗  ██╗ ██████╗ ██████╗  ██████╗  ██████╗ ██╗     ███████╗██████╗" -ForegroundColor Cyan
    Write-Host "╚██╗██╔╝██╔════╝██╔═══██╗██╔═══██╗██║   ██║██║     ██╔════╝██╔══██╗" -ForegroundColor Cyan
    Write-Host " ╚███╔╝ ██║     ██║   ██║██║   ██║██║   ██║██║     █████╗  ██████╔╝" -ForegroundColor Cyan
    Write-Host " ██╔██╗ ██║     ██║   ██║██║   ██║██║   ██║██║     ██╔══╝  ██╔══██╗" -ForegroundColor Cyan
    Write-Host "██╔╝ ██╗╚██████╗╚██████╔╝╚██████╔╝╚██████╔╝███████╗███████╗██║  ██║" -ForegroundColor Cyan
    Write-Host "╚═╝  ╚═╝ ╚═════╝ ╚═════╝  ╚═════╝  ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "                         v$Version" -ForegroundColor DarkCyan
    Write-Host "                    Made by bridgezan" -ForegroundColor Cyan
    Write-Host ""

    $active = Get-ActivePlan
    $status = Get-XCoolerStatus

    Write-Host "Current Power Plan : " -NoNewline -ForegroundColor Cyan

    if ($active) {
        Write-Host $active.Name -ForegroundColor White
    }
    else {
        Write-Host "Unknown" -ForegroundColor DarkGray
    }

    Write-Host "xCooler Status     : " -NoNewline -ForegroundColor Cyan

    if ($status -eq "ON") {
        Write-Host "ON" -ForegroundColor Cyan
    }
    elseif ($status -eq "OFF") {
        Write-Host "OFF" -ForegroundColor DarkGray
    }
    else {
        Write-Host "NOT INSTALLED" -ForegroundColor Yellow
    }

    Write-Host ""
    Write-Host "[1] Turn ON" -ForegroundColor Cyan
    Write-Host "[2] Turn OFF" -ForegroundColor Cyan
    Write-Host "[3] Status" -ForegroundColor Cyan
    Write-Host "[4] Uninstall" -ForegroundColor Cyan
    Write-Host "[5] Exit" -ForegroundColor Cyan
    Write-Host ""
}

function Show-Status {
    Clear-Host

    $active = Get-ActivePlan
    $xCooler = Get-PlanGuid
    $status = Get-XCoolerStatus

    Write-Host ""
    Write-Host "xCooler Status" -ForegroundColor Cyan
    Write-Host ""

    Write-Host "Version          : " -NoNewline -ForegroundColor Cyan
    Write-Host $Version

    Write-Host "Status           : " -NoNewline -ForegroundColor Cyan
    Write-Host $status

    Write-Host "xCooler GUID     : " -NoNewline -ForegroundColor Cyan

    if ($xCooler) {
        Write-Host $xCooler
    }
    else {
        Write-Host "Not installed"
    }

    Write-Host "Active Plan      : " -NoNewline -ForegroundColor Cyan

    if ($active) {
        Write-Host $active.Name
    }
    else {
        Write-Host "Unknown"
    }

    Write-Host ""

    Read-Host "Press ENTER to continue"
}

function Start-XCooler {
    while ($true) {
        Show-Header

        $choice = Read-Host "Select"

        switch ($choice) {
            "1" {
                Turn-On
            }

            "2" {
                Turn-Off
            }

            "3" {
                Show-Status
            }

            "4" {
                Remove-XCooler
            }

            "5" {
                Clear-Host
                return
            }
        }
    }
}

if (-not (Is-Admin)) {
    $encoded = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($MyInvocation.MyCommand.Definition))

    Start-Process powershell.exe -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -EncodedCommand $encoded"

    exit
}

if (-not (Get-PlanGuid)) {
    Create-XCooler | Out-Null
}

Start-XCooler
