remove-item alias:curl

#. ~\PowerShellScripts\Load-Scripts.ps1


if ($host.Name -eq 'ConsoleHost') {
  Import-Module PSReadline
   
  Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
  Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
}

Import-Module PSFzf
