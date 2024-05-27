$todolistFile = "PSScriptRoot\todolist.txt"

function Initialize-ToDolist  {
    if(-not(Test-Path -Path $todolistFile)){
        New-Item -Path $todolistFile -ItemType File -Force | Out-Null
    }

}
function Add-Task{
    param(
        [string]$task
    )
    Add-Content -Path $todolistFile -Value $task
    Write-Output "Sarcina '$task' a fost adaugata."
}

function List-Tasks {
    if(Test-Path -Path $todolistFile){
    Get-Content -Path $todolistFile
}else{
    Write-Output "Nu exista sarcini in lucru."
}
}

function Remove-Task{
    param(
        [int]$todolistFile
    )
    if(Test-Path -Path $todolistFile){
        $tasks = Get-Content -Path $todolistFile
        if($taskNumber -gt 0 -and $taskNumber -le $tasks.Length){
            $tasks = $task | Where-Object { $_ -ne $tasks[$taskNumber - 1]}
            Set-Content -Path $todolistFile -Value $tasks
            Write-Output "Sarcina #$taskNumber a fost stearsa."

        }else{
            Write-Output "Numarul sarcinii este invalid"
        }
        else{
            Write-Output "Nu exista sarcini in lista"
        }
    }
}
Initialize-ToDoList

do{
    Show-Menu
    $choice = Read-Host "Selecteaza o optiune"

    switch($choice){
        "1"{
            $task = Read-Host "Introdu sarcina"
            Add-Task -task $task
        }
        "2"{
            List-Tasks
        }
        "3"{
            $taskNumber = Read-Host "Introdu numarul sarcinii de sters"
            Remove-Task -taskNumber [int]$taskNumber
        }
        "4" {
            Write-Output "La revedere!"
        }
        default{
            Write-Output "Optiune invalida. Incearca din nou!"
        }
    }
}while($choice -ne "4")
