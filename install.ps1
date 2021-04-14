''
'Paste the below two sections into your powershell profiles json'
'---------------------------------------------------------------------------------------------------------------'
$content = Get-Content -Path 'profiles.json'
$currentPath = $(Get-Location).Path -replace '\\', '\\'
$newContent = $content -replace 'INSERT YOUR REPO PATH HERE', $currentPath
$newContent
'---------------------------------------------------------------------------------------------------------------'

