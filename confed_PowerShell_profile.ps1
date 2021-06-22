remove-item alias:curl

  
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
  get-migrationuser -BatchId $BatchID | sort DataConsistencyScore | select Identity,Status,ErrorSummary,DataConsistencyScore,HasUnapprovedSkippedItems
}

function Get-SkippedItems {
  param (
    $BatchID
  )
  get-migrationuser -BatchId $BatchID | ?{ $_.HasUnapprovedSkippedItems -eq $True } | Get-MigrationUserStatistics -IncludeSkippedItems | select -Expand SkippedItems Identifier | ? {$_.Kind -ne "CorruptFolderACL" } | select @{label="Identity";expression={$_.Identifier}},Kind,FolderName,Subject,DateReceived,@{label="MessageSizeMB";expression={$_.MessageSize/1024/1024}}
}


if ($host.Name -eq 'ConsoleHost') {
  Import-Module PSReadline
   
  Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
  Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
}
