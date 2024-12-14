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

$LeftSide = $LeftSide | Sort-Object
$RightSide = $RightSide | Sort-Object

for($i= 0; $i -lt $LeftSide.Length ; $i++)
    {
    $distance = ($leftSide[$i] - $rightSide[$i])
    if($distance -lt 0){
        $distance = $distance * -1
    }
    $answer =  $answer + $distance
}
$answer