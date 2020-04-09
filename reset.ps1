"LOADING PLEASE WAIT ..."
$e = "$([char]27)"
$mem = [regex]::Match((wmic OS get TotalVisibleMemorySize /Value),'[0-9]+').Value + ''
$free = [regex]::Match((wmic OS get FreePhysicalMemory /Value),'[0-9]+').Value + ''

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
. "$scriptRoot\commands.ps1"

SYS64738

