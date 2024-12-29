$input = Get-Content $PSScriptRoot\2024\02\sample_input.txt
$inputArray = New-Object System.Collections.ArrayList

foreach($line in $input){
    $i = [PSCustomObject]@{
        input = $line -split '\D'
        result = [PSCustomObject]@{
            rule1 = $false
            rule2 = $false
            rule3 = $false
        }
    }
    [Void]$inputArray.Add($i)
}

function Get-Rule1Status{
    param (
        [int]$currentInt,
        [int]$NextInt
    )
    $r = [System.Math]::Abs($currentInt - $NextInt)
    if($r -eq 0){
        Return $false
    }else{
        Return $true
    }
}

function Get-Rule2Status{
    param (
        [int]$currentInt,
        [int]$NextInt
    )
    $r = [System.Math]::Abs($currentInt - $NextInt)
    if(($r -le 3)-and($r -ge 1)){
        Return $true
    }else{
        Return $false
    }
}

function Get-Rule3Direction{
    param (
        [int]$currentInt,
        [int]$NextInt
    )
    $r = $currentInt - $NextInt
    switch($r){
        {$_ -le 0} {Return -1}
        {$_ -gt 0} {Return 1}
        {$_ -eq 0} {Return 0}
    }
}
foreach($line in $inputArray){
    $rule1results = New-Object System.Collections.ArrayList
    $rule2results = New-Object System.Collections.ArrayList
    #get initial direction
    $diff = [int]$line.input[1] - [int]$line.input[0]
    switch($diff){
        {$_ -lt 0} {$direction = -1}
        {$_ -gt 0} {$direction = 1 }
        {$_ -eq 0} {$direction = 0}
    }
    $line | Add-Member -MemberType NoteProperty -Name 'Direction' -Value $direction
    
    for ($i=0; $i -lt ($line.input.Length -1); $i++) {
        $rule1 = Get-Rule1Status -currentInt $line.input[$i] -NextInt $line.input[$i+1]
        $rule2 = Get-Rule2Status -currentInt $line.input[$i] -NextInt $line.input[$i+1]
        [Void]$rule1results.Add($rule1)
        [Void]$rule2results.Add($rule2)
    }
    if($rule1results -notcontains $false){
        $line.result.rule1 = $true
    }
    if($rule2results -notcontains $false){
        $line.result.rule2 = $true
    }
}

$inputArray