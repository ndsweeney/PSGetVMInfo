Connect-AzAccount

get-azsubscription

Select-AzSubscription -SubscriptionId XXX

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
$vmOutput | Export-Csv -Path .\newhddinfo2.csv -delimiter ";" -force -notypeinformation 

Get-AzDisk

get-azvm