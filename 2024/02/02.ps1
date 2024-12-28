# $inputFile = Get-Content "C:\Dev\aoc\2024\02\sample_input.txt"
$inputFile = Get-Content "C:\Dev\aoc\2024\02\input.txt"
$i = $null
function Split-ToSingleString{
    [CmdletBinding()]
    param (
        [String]$InputString,
        [int]$Index
    )
    Return ($InputString -split '\D')
}

function Get-IsSafe{
    [CmdletBinding()]
    param (
        [Int]$StartDirection,
        [Int]$CurrentInt,
        [Int]$NextInt
    )
    $isSafe = $false
    $diff = [System.Math]::Abs($CurrentInt - $NextInt)

    if(($diff -le 3) -and ($diff -gt 0)){
        $diffFlag = $true
    }
    switch($StartDirection){
        -1 {if(($CurrentInt -gt $NextInt) -and ($diffFlag) ){$isSafe = $true;}}
         1 {if(($CurrentInt -lt $NextInt) -and ($diffFlag) ){$isSafe = $true;}}
         0 {$isSafe = $false}
    }

    Return $isSafe
}

$count = 0
foreach($line in $inputFile){
    $safe = $true
    $strings = Split-ToSingleString -InputString $line
    $c = $strings.Length -1
    $sDiff = $strings[0]-$strings[1]

    if($sDiff -lt 0){
        $dir = 1
    }elseif($sDiff -gt 0){
        $dir = -1
    }else{
        $dir = 0
    }

    for($i=0;$i -lt $c;$i++){
        $i1 = $strings[$i]
        $i2 = $strings[$i+1]
        $isSafe = Get-IsSafe -StartDirection $dir -CurrentInt $i1 -NextInt $i2
        if(!$isSafe){
            $safe = $false
        }
    }
    if($safe){
        $count++
    }
}
$count