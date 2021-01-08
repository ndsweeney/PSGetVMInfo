#Log in to Azure
Connect-AzAccount

#Get your list of subscriptions
#ACTION - Copy the Sub ID you want to use
get-azsubscription

#Select the correct sub you want to use
#ACTION - paste the sub ID where XXX
Select-AzSubscription -SubscriptionId XXX

#Runs the command Get-VM which gets the virtual machine parameters for the VMs in the subscription 
#Sets an ouput variable ($VmOutput) and places the relevant objects from the GetVM output for each VM
$VMs = Get-AzVM
$vmOutput = $VMs | ForEach-Object {
    [PSCustomObject]@{
        "VM Name" = $_.Name
        "VM Type" = $_.StorageProfile.osDisk.osType
        "VM Profile" = $_.HardwareProfile.VmSize
        "VM OS Disk Size" = $_.StorageProfile.OsDisk.DiskSizeGB
        "VM OS Disk Name" = $_.StorageProfile.OsDisk.Name
        "VM Data Disk Name" = $_.StorageProfile.DataDisks.Name
        "VM Data Disk SKU" = $_.StorageProfile.DataDisks.Sku.Name
        "VM Data Disk Size" = ($_.StorageProfile.DataDisks.DiskSizeGB) -join ','
    }
}

#Outputs the array into a csv file
$vmOutput | Export-Csv -Path .\newhddinfo.csv -delimiter ";" -force -notypeinformation 
