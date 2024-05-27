
$todolistFile = "$PSScriptRoot\todolist.txt"


function Initialize-ToDoList {
    if (-not (Test-Path -Path $todolistFile)) {
        New-Item -Path $todolistFile -ItemType File -Force | Out-Null
    }
}


function Add-Task {
    param (
        [string]$task
    )
    Add-Content -Path $todolistFile -Value $task
    Write-Output "Sarcina '$task' a fost adăugată."
}


function List-Tasks {
    if (Test-Path -Path $todolistFile) {
        Get-Content -Path $todolistFile
    } else {
        Write-Output "Nu există sarcini în listă."
    }
}


function Remove-Task {
    param (
        [int]$taskNumber
    )
    if (Test-Path -Path $todolistFile) {
        $tasks = Get-Content -Path $todolistFile
        if ($taskNumber -gt 0 -and $taskNumber -le $tasks.Length) {
            $tasks = $tasks | Where-Object { $_ -ne $tasks[$taskNumber - 1] }
            Set-Content -Path $todolistFile -Value $tasks
            Write-Output "Sarcina #$taskNumber a fost ștearsă."
        } else {
            Write-Output "Numărul sarcinii este invalid."
        }
    } else {
        Write-Output "Nu există sarcini în listă."
    }
}


# Interfața utilizator
function Show-Menu {
    Write-Output "1. Adaugă o sarcină"
    Write-Output "2. Listează sarcinile"
    Write-Output "3. Șterge o sarcină"
    Write-Output "4. Ieșire"
}


Initialize-ToDoList

do {
    Show-Menu
    $choice = Read-Host "Selectează o opțiune"

    switch ($choice) {
        "1" {
            $task = Read-Host "Introdu sarcina"
            Add-Task -task $task
        }
        "2" {
            List-Tasks
        }
        "3" {
            $taskNumber = Read-Host "Introdu numărul sarcinii de șters"
            try {
                $taskNumber = [int]$taskNumber
                Remove-Task -taskNumber $taskNumber
            } catch {
                Write-Output "Numărul sarcinii este invalid. Te rog introdu un număr întreg."
            }
        }
        "4" {
            Write-Output "La revedere!"
        }
        default {
            Write-Output "Opțiune invalidă. Încearcă din nou."
        }
    }
} while ($choice -ne "4")
