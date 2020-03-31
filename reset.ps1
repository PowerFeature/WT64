"LOADING PLEASE WAIT ..."
$mem = [regex]::Match((wmic OS get TotalVisibleMemorySize /Value),'[0-9]+').Value + '000'
$free = [regex]::Match((wmic OS get FreePhysicalMemory /Value),'[0-9]+').Value + '000'

# This will display READY.\n as prompt
#function prompt {"READY.`n"}
function prompt {"`r"}
cls
""
"        **** MICROSOFT X64 POWERSHELL V" + $PSVersionTable.PSVersion.Major + "." + $PSVersionTable.PSVersion.Minor + " ****    "
" "
" " + $mem + " KB RAM SYSTEM "+ $free  +" KILOBYTES FREE"
" "
"READY."