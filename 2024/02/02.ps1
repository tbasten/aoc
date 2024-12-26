$inputFile = Get-Content ./sample_input.txt
$i = $null
function Split-ToSingleString{
    [CmdletBinding()]
    param (
        [String]$InputString,
        [int]$Index
    )
    Return $InputString -split '\D'
}

function Get-NextIntDiff{
    param(
        [int]$CurrentInt,
        [int]$NextInt
    )
    $x = [System.Math]::Abs($CurrentInt - $NextInt)
    Write-Host "$CurrentInt,$NextInt "
    Return [int]$x
}

function Get-SequenceDirection {
    param (
    [int]$first,
    [int]$next
    )
    $direction
    $first - $next
}

function Get-IsSafe{
    [CmdletBinding()]
    param (
        [Int]$StartDirection,
        [Int]$CurrentInt,
        [Int]$NextInt
    )
    switch($StartDirection){
        -1 {if($CurrentInt -lt $NextInt){Return $true}else{false}}
         1 {if($CurrentInt -gt $NextInt){Return $true}else{false}}
    }
}

foreach($line in $inputFile){
    $safe = $true
    $direction = 0
    $strings = Split-ToSingleString -InputString $line
    $c = $strings.Length -1
    
    if($strings[0] -lt 0){
        $direction = -1
    }elseif($strings[0] -lt 0){
        $direction = 1
    }else {
        $safe = $false
    }
    if($safe){
        for($i=0;$i -lt $c;$i++){
            $i1 = $strings[$i]
            $i2 = $strings[$i+1]
            Get-IsSafe -StartDirection $direction -CurrentInt $i1 -NextInt $i2
            Get-NextIntDiff -CurrentInt $strings[$i1] -NextInt $strings[$i2]
        }
    }
    write-host $safe
}