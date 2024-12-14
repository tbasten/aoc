#$file = "sample_input.txt"
$file = "input.txt"
$lines = [System.IO.File]::ReadLines($file)
$leftSide = New-Object -TypeName System.Collections.ArrayList
$rightSide = New-Object -TypeName System.Collections.ArrayList
$answer = 0

foreach($l in $lines){
    $left = ($l.Split('   '))[0]
    $right = ($l.Split('   '))[1]

    [Void]$leftSide.Add($left)
    [Void]$rightSide.Add($right)    
}

foreach($n in $leftSide){
    $count = 0
    foreach ($i in $rightSide){
        if($n -eq $i){
            $count++
        }
    }
    [int]$similarity = [int]$n * [int]$count
    [int]$answer = [int]$answer + [int]$similarity
}

$answer