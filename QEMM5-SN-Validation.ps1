# $SN = "328-B6-7676" # Good Serial Number
# $SN = "328-XQ-7676" # Good Serial Number
$SN = "000-B6-0000" # Bad Serial Number

If ($SN[3] -ne "-") { return Write-Host "SN: $($SN) Bad.... Try Again" }
If ($SN[6] -ne "-") { return Write-Host "SN: $($SN) Bad.... Try Again" }

Switch ("$($SN[4])$($SN[5])") {
   "B6" { break }
   "XQ" { break }
default { return Write-Host "SN: $($SN) is Bad.... Try Again" }
}

$BL = 10
$Data = $NULL

For ($c=0;$c -le 10;$c++) { 
If (($c -le 2) -or ($c -ge 8)) { $Data += $([Convert]::ToInt16($SN[$c],10)) }
}

$AL = [System.Math]::Round($($Data) / $($BL))
$AH = $($Data) % $($BL)
$BL = ($($BL) - 1) - $($AH)
$AH = $($BL) + 30

If ($($AH) -eq $("{0:X2}" -f [int][char]$SN[7])) {
Write-Host "SN: $($SN) is Good!"
} Else {
Write-Host "SN: $($SN) is Bad.... Try again"
}
