# DataLakeFolderSize

How to use it:

Login-AzureRMAccount
$dataLakeStoreAccount = "whatever"
$DataLakeFolderPath = "/folder"
$CSVOutputFile = "C:\folder\DataLakeFolderSize.csv"


Get-DataLakeFolderSize -DataLakeStoreAccount $dataLakeStoreAccount -DataLakeFolderPath $DataLakeFolderPath -CSVOutputFile $CSVOutputFile -Level 0

