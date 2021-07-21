remove-item alias:curl

. ~\PowerShellScripts\Load-Scripts.ps1

  
function Check-LoadedModule {
  Param( [parameter(Mandatory = $true)][alias("Module")][string]$ModuleName)
    $LoadedModules = Get-Module | Select Name
    if (!$LoadedModules -like "*$ModuleName*") {Import-Module -Name $ModuleName}
}

function ipinfo {
 param (
   $IPAddress
 )
 curl https://ipinfo.io/$IPAddress
}

function Get-MigrationBatchStatus {
  param (
    $BatchID
  )
  Check-LoadedModule "ExchangeOnlineManagement"
  get-migrationuser -BatchId $BatchID | sort DataConsistencyScore | select Identity,Status,ErrorSummary,DataConsistencyScore,HasUnapprovedSkippedItems
}

function Get-SkippedItems {
  param (
    $BatchID
  )
  Check-LoadedModule "ExchangeOnlineManagement"
  get-migrationuser -BatchId $BatchID | 
  ?{ $_.HasUnapprovedSkippedItems -eq $True } | 
  Get-MigrationUserStatistics -IncludeSkippedItems | 
  select -Expand SkippedItems @{label="UserIdentity";expression={$_.Identity}} | 
  ? {$_.Kind -ne "CorruptFolderACL" } | 
  select @{label="Identity";expression={$_.UserIdentity}},Kind,FolderName,Subject,DateReceived,@{label="MessageSizeMB";expression={$_.MessageSize/1024/1024}}
}


if ($host.Name -eq 'ConsoleHost') {
  Import-Module PSReadline
   
  Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
  Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
}
