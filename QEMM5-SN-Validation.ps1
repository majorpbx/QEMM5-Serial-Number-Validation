#############################################################
#                                                           #
# Version 5:                                                #
#           "328-B6-7676" Good Serial Number                #
#           "328-XQ-7676" Good Serial Number                #
#           "000-B6-0000" Bad Serial Number                 #
#                                                           #
# Version 7:                                                #
#           "500-P7R-4152" Good Serial Number               #
#           "050-ì7@-4152" Good Serial Number               #
#           "050-@7í-4152" Bad Serial Number                #
#                                                           #
#############################################################

# Re-wrote this into a function and aligned the code to follow de-compiled assembly code.
#
# Working on adding more versions but for now only truely supports v5.

Function QD-SerialCheck {
Param (
[Parameter(Mandatory=$False, ValueFromPipeline=$true)]
# [ValidateScript({Test-Path $_})]
[String]$SerialNumber,
[Parameter(Mandatory=$false, ValueFromPipeline=$true)]
[ValidateSet("5","6","7","8")]
[String]$Version = "5"
)

$BL = 10


If ($SerialNumber[3] -ne "-") { return Write-Host "SN: $($SerialNumber) Bad.... Try Again" }
If ($SerialNumber[6] -ne "-") { return Write-Host "SN: $($SerialNumber) Bad.... Try Again" }

If ("$($SerialNumber[4])$($SerialNumber[5])" -eq "XQ") {  } Else { 

If ($SerialNumber[4] -ne "B") { return Write-Host "SN: $($SerialNumber) Bad.... Try Again" }
If ($SerialNumber[5] -ne "6") { return Write-Host "SN: $($SerialNumber) Bad.... Try Again" }

}
<#
Switch ("$($SerialNumber[4])$($SerialNumber[5])") {
   "B6" { break }
   "XQ" { break }
default { return Write-Host "SN: $($SerialNumber) is Bad.... Try Again" }
}
#>

$Data = $NULL

For ($c=0;$c -le 10;$c++) { 
$Data
If (($c -le 2) -or ($c -ge 8)) { $Data += $([Convert]::ToInt16($SerialNumber[$c],10)) }
}

$AL = [System.Math]::Round($($Data) / $($BL))
$AH = $($Data) % $($BL)
$BL = ($($BL) - 1) - $($AH)
$AH = $($BL) + 30

If ($($AH) -eq $("{0:X2}" -f [int][char]$SerialNumber[7])) {

return Write-Host "SN: $($SerialNumber) is Good!"

} Else {

return Write-Host "SN: $($SerialNumber) is Bad.... Try again"

}

}
