$codes = Get-Content .\day1.txt
$numbers = New-Object -TypeName "System.Collections.ArrayList"
foreach( $record in $codes ){
    $Ints = $record -replace '\D'
    switch ($Ints.Length) {
        1 { $numbers.add([int]($Ints + $Ints)) }
        2 { $numbers.add([int]$Ints) }
        { $_ -ge 3 } { 
            $ifirst = $Ints.Substring(0,1)
            $ilast = $Ints.Substring($Ints.Length -1)
            $answer = $ifirst + $ilast
            $numbers.add([int]$answer) }
        Default {  }
    }
}
$numbers | Measure-Object -Sum