#Add-AzureRmAccount # -Credential $cred –TenantId $subscriptionID

$azureRGName = "syurg2" #keep it short and with no special characters and no capitals

New-AzureRmResourceGroup -Name $azureRGName -Location "West US"

New-AzureRmResourceGroupDeployment -DeploymentName "syudeploy1" -ResourceGroupName $azureRGName -TemplateUri "https://raw.githubusercontent.com/sergeyuwt/deploy/master/serge/nested-templates/main.json" -TemplateParameterUri "https://raw.githubusercontent.com/sergeyuwt/deploy/master/serge/nested-templates/my.azuredeploy.parameters.json"

#Test-AzureRmResourceGroupDeployment -ResourceGroupName $azureRGName -TemplateFile "new-agent.json" -TemplateParameterFile "my.azuredeploy.parameters.json"
