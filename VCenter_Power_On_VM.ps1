#region Required Modules

Import-Module VMWare.PowerCLI

#endregion

#region Adjustable Variables

$MyHosts = "<Enter VCenter Host FQDN>"
$username = "<Enter Username to connect to VCenter Host>"
$password = "<Enter User's Password here>"
$Server = "<Enter Server Name to Power on here. Accepts wildcards>"
 
#endregion

#region Connect to VCenter

#Connects to the vcenter server
$MyHosts | Foreach {
Write-Host "Connecting to host: $($_)"
$connection = Connect-VIServer $_ -User $username -Password $password
}

#endregion

#region Start VM Working Script
 
 #Gets VM with name listed in $Server and powers on, if seen as powered off

$VM = Get-VM $Server | where{$_.powerstate -like "*off*"}
$VM | Foreach {
Write-Host "Starting $($_.name) found on $($_.VMHost)"
$StaringVMs = Start-VM $_ -Confirm:$false -RunAsync
}

#endregion
