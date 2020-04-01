"LOADING PLEASE WAIT ..."
$mem = [regex]::Match((wmic OS get TotalVisibleMemorySize /Value),'[0-9]+').Value + '000'
$free = [regex]::Match((wmic OS get FreePhysicalMemory /Value),'[0-9]+').Value + '000'

# This will display READY.\n as prompt
# function prompt {"READY.`n"}
function prompt {"`r"}
function CenterText([string]$inputLine,[int]$textWidth,[string]$wrapChar) {
    If (($inputLine.length + ($wrapChar.Length *2)) -ge $textWidth) {

        return -join($wrapChar,$inputLine.Substring(0,$textWidth-2*$wrapChar.Length),$wrapChar)}
    else {
        $diff =  ($textWidth+(2*$wrapChar.Length)) - $inputLine.Length
        $spaceCount = [math]::Floor($diff/2)
        $leadingSpaces = $(" " * $spaceCount)
        if (-join( $wrapChar, $leadingSpaces, $inputLine, $leadingSpaces,$wrapChar).Length -lt $textWidth) {
            return -join( $wrapChar, $leadingSpaces, $inputLine, $leadingSpaces,$wrapChar, " ")
            
        } else {
            return -join( $wrapChar, $leadingSpaces, $inputLine, $leadingSpaces,$wrapChar)
            
        }
    }

}
$scriptRoot = Split-Path -parent $PSCommandPath

cls
""
$line1 = "**** MICROSOFT X64 POWERSHELL V" + $PSVersionTable.PSVersion.Major + "." + $PSVersionTable.PSVersion.Minor + " ****"
$line2 = " " + $mem + " KB RAM SYSTEM "+ $free  +" KILOBYTES FREE"

CenterText $line1 ((Get-Host).UI.RawUI.MaxWindowSize.Width)
" "
CenterText $line2 ((Get-Host).UI.RawUI.MaxWindowSize.Width)
" "
"READY."
. "$scriptRoot\commands.ps1"


