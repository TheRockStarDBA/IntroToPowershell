﻿param($arg)

function Get-FileCount{

    param([string]$PathName)

    if(Test-Path -Path $PathName){
        $FileCount = (Get-ChildItem $PathName).Length
        "$PathName has $FileCount files" | Out-Host
    }
    else{
        Write-Warning "Path is invalid"
    }
}

Get-FileCount -PathName $arg
