$Module = Get-Module DRAW
#Remove-Module $Module.Name -Force
dotnet build
Import-Module .\bin\Debug\netstandard2.0\DRAW.dll
Write-DRAW .\logo.png
