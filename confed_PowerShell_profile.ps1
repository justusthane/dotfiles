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
# Words from https://gist.github.com/justusthane/4c122f504cd095bdb5d05a1d693758f7
function croc-send { param ( $path ) & croc send --code $($(Get-Content C:\Users\jbadergr\Library\basicwordlist.txt | get-random -count 2) -join "-") $path }
