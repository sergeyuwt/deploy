# Under Development

# Deploy Teradici PCoIP Standard Agent on Microsoft Azure

### What the scripts do
- The followings will be created / installed 
	* A resource group
	* A Storage account
	* A VNet with network security groups defined
	* A network interface with a public IP address
	* A Windows Server 2016 VM
	* Teradici PCoIP Standard Agent 2.8

### How the scripts work
- main entry point: azuredeploy.json, which invokes
	* resources\storageAccount_template.json
	* resources\network_template.json
	* resources\nic_template.json
	* vm_template.json
	* vm_dsc_template.json, which uses
	  * Install-PCoIPStdAgent.zip

### How to use the scripts
- Used in github readme.md file by creating a deploy button
	* encode the public URI to azuredeploy.json
	* add the following codes to the readme.md file, replacing encoded_uri_to_azuredeploy.json with the one obtained in last step
	```
    <a target="_blank" href="https://portal.azure.com/#create/Microsoft.Template/uri/encoded_uri_to_azuredeploy.json"><img src="http://azuredeploy.net/deploybutton.png"/></a>    
    ```
- Used with powershell
	* simple powershell code to deploy the template
    ```
	Add-AzureRmAccount

	$azureRGName = "resourcegroup1" #keep it short and with no special characters and no capitals

	New-AzureRmResourceGroup -Name $azureRGName -Location "West US"

	New-AzureRmResourceGroupDeployment -DeploymentName "saploy1" -ResourceGroupName $azureRGName -TemplateFile "azuredeploy.json"
    ```

  
<p>&nbsp;</p>
<p>&nbsp;</p>
Copyright 2017 Teradici Corporation. All Rights Reserved.