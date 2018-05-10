# DataLakeFolderSize

Calculates the total size of the folder specified as well as all sub folders recursively. 

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. 

### Prerequisites

Install the Azure Resource Manager modules from the PowerShell Gallery
```
Install-Module -Name AzureRM -AllowClobber
```
Once the module is installed, you need to load the module into your PowerShell session. You should do this in a normal (non-elevated) PowerShell session. Modules are loaded using the Import-Module cmdlet, as follows:
```
Import-Module -Name AzureRM
```

## Running the script
```
Login-AzureRMAccount
$dataLakeStoreAccount = "whatever"
$DataLakeFolderPath = "/folder"
$CSVOutputFile = "C:\folder\DataLakeFolderSize.csv"
```
```
Get-DataLakeFolderSize -DataLakeStoreAccount $dataLakeStoreAccount -DataLakeFolderPath $DataLakeFolderPath -CSVOutputFile $CSVOutputFile -Level 0
```
or if you just need the total folder size 2 Levels down the tree
```
Get-DataLakeFolderSize -DataLakeStoreAccount $dataLakeStoreAccount -DataLakeFolderPath $DataLakeFolderPath -CSVOutputFile $CSVOutputFile -Level 2
```
