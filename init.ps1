cls
$systeminfo = &"systeminfo.exe" 2>&1
$mem = ($systeminfo | Select-String 'Total Physical Memory:').ToString().Split(':')[1].Trim() -replace " MB",".000.000"
$free = ($systeminfo | Select-String 'Available Physical Memory:').ToString().Split(':')[1].Trim() -replace " MB",".000.000"
function prompt {"`r"}
#$mem = (systeminfo | Select-String 'Total Physical Memory:').ToString().Split(':')[1].Trim()
#$free = (systeminfo | Select-String 'Available Physical Memory:').ToString().Split(':')[1].Trim()
cls
""
"        **** MICROSOFT 64 POWERSHELL V" + $PSVersionTable.PSVersion.Major + "." + $PSVersionTable.PSVersion.Minor + " ****    "
" "
" " + $mem + " RAM SYSTEM "+ $free  +" BYTES FREE"
" "
"READY."

