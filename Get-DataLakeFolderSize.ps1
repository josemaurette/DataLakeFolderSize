function Get-DataLakeFolderSize
{
   param
    (
        [Parameter(Mandatory=$True)][string]$DataLakeFolderPath,
        [Parameter(Mandatory=$True)][string]$DataLakeStoreAccount,
        [int]$Level=0,
        [Parameter(Mandatory=$True)][string]$CSVOutputFile
    )

    function GetFolderInfo_Recursive {  
        param ( 
            [Parameter(Mandatory=$true)][string] $DataLakeStoreAccount, 
            [Parameter(Mandatory=$true)][Object] $CurrentFolderInfo 

        )  


    $FolderList=@();
    
    $ChildItems = Get-AzureRmDataLakeStoreChildItem -AccountName $DataLakeStoreAccount -Path $CurrentFolderInfo.Path;

    foreach ($ChildItem in $ChildItems )
        {
            
            switch ($ChildItem.Type) 
            {
                "FILE" 
                {
                    $CurrentFolderInfo.SizeBytes=$CurrentFolderInfo.SizeBytes+$ChildItem.Length;
                }
                "DIRECTORY"
                {   
                    $subFolder = New-Object PSObject -Property @{Path=$ChildItem.Path;SizeBytes=0;Level=$CurrentFolderInfo.Level +1}
                    GetFolderInfo_Recursive -DataLakeStoreAccount $DataLakeStoreAccount -CurrentFolderInfo $subFolder
                    $CurrentFolderInfo.SizeBytes= $CurrentFolderInfo.SizeBytes + $subFolder.SizeBytes;
                    
                    
                }
            }
        }
    $FolderList=$FolderList+$CurrentFolderInfo
    return $FolderList
} 
    
    $dataLakeStoreAccount = $DataLakeStoreAccount
    $currentFolderPath = $DataLakeFolderPath
    $currentFolderInfo = New-Object PSObject -Property @{Path=$currentFolderPath;SizeBytes=0;Level=1}

    if ($Level -gt 0)
    {
        GetFolderInfo_Recursive -DataLakeStoreAccount $dataLakeStoreAccount -CurrentFolderInfo $currentFolderInfo | Where-Object -Property Level -le -Value $Level| Sort-Object -Property SizeBytes -Descending |
             Select-Object -Property @{Name="SizeInGB";Expression={("{0:N4}" -f ($_.SizeBytes / 1GB))}},
                Path, Level | Export-Csv –Path $CSVOutputFile
    }else
    {
        GetFolderInfo_Recursive -DataLakeStoreAccount $dataLakeStoreAccount -CurrentFolderInfo $currentFolderInfo | Sort-Object -Property SizeBytes -Descending |
             Select-Object -Property @{Name="SizeInGB";Expression={("{0:N4}" -f ($_.SizeBytes / 1GB))}},
                Path, Level | Export-Csv –Path $CSVOutputFile
    }

}
