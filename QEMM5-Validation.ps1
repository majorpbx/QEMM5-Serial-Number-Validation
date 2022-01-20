$SN = "000-B6-0000"

If ($SN[3] -ne "-") { return Write-Host "SN: Bad.... Try Again" }
If ($SN[6] -ne "-") { return Write-Host "SN: Bad.... Try Again" }

If ("$($SN[4])$($SN[5])" -eq "XQ") { continue }

If ($SN[4] -ne "B") { return Write-Host "SN: Bad.... Try Again" }
If ($SN[4] -ne "6") { return Write-Host "SN: Bad.... Try Again" }

$BL = 10
$Data = $NULL

For ($c=0;$c -le 10;$c++) { 
If (($c -le 2) -or ($c -ge 8)) { $Data += $([Convert]::ToInt16($SN[$c],10)) }
}

$AL = [System.Math]::Round($($Data) / $($BL))
$AH = $($Data) % $($BL)
$BL = ($($BL) - 1) - $($AH)
$AH = $($BL) + 30

If ($($AH) -eq $("{0:X}" -f [int][char]$SN[7])) {

Write-Host "SN: $($S) is Good!"

} Else {

Write-Host "SN: $($S) is Bad.... Try again"

}
