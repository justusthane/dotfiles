remove-item alias:curl

#. ~\PowerShellScripts\Load-Scripts.ps1
. "$([environment]::getfolderpath("mydocuments"))\WindowsPowerShell\Private_Profile.ps1"

if ($host.Name -eq 'ConsoleHost') {
  Import-Module PSReadline
   
  Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
  Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
}

Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
Set-PSReadLineKeyHandler -Chord Alt+c -ScriptBlock {
  Get-ChildItem C:\Users\jbadergr -Recurse -Attributes Directory | Invoke-Fzf | Set-Location
}
