# DataLakeFolderSize

Calculates the total size of the folder specified as well as all sub folders recursively.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. 

Login-AzureRMAccount
$dataLakeStoreAccount = "whatever"
$DataLakeFolderPath = "/folder"
$CSVOutputFile = "C:\folder\DataLakeFolderSize.csv"


Get-DataLakeFolderSize -DataLakeStoreAccount $dataLakeStoreAccount -DataLakeFolderPath $DataLakeFolderPath -CSVOutputFile $CSVOutputFile -Level 0

