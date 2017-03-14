# Easy Deploy Teradici Standard Agent on Microsoft Azure

This will deploy Teradici Standard Agent on Microsoft Azure.

### What you need before the deployment

1. A Microsoft Azure account
    * to create a free Azure account, goto: [https://azure.microsoft.com/en-in/free/](https://azure.microsoft.com/en-in/free/)
2. An activation code for Teradici Standard Agent
    * to obtain an activation code for Teradici Standard Agent, goto: [todo](todo)

### To deploy

Click the button below to deploy, you will be prompted to enter your Azure account credentials and the activation code for Teradici Standard Agent.

<a target="_blank" href="https://portal.azure.com/#create/Microsoft.Template/uri/the_encoded_template_uri">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>

### What you can do now
1. find out the public ip address of the Standard Agent:
    * Login to [https://portal.azure.com](https://portal.azure.com) using your account credentials
    * Click "Resource groups"
    * Find the resource group whose name starts with ..., click on it
    * Click the "Public IP address" resource. You will be shown the IP Address 

2. connect Teradici PCoIP client to the Teradici Standard Agent.
    * using the IP address found in the prevous step, you can now connect Teradici PCoIP client to the Teradici Standard Agent.

### What you need to do after usage

Delete the Teradici Standard Agent from your Microsoft Azure account
  * Login to [https://portal.azure.com](https://portal.azure.com) using your account credentials
  * Click "Resource groups"
  * Find the resource group whose name starts with ..., right-click on it, then select "Delete"
  * You will be prompted to type the resource group name. Type it and click "Delete" button

<p>&nbsp;</p>
<p>&nbsp;</p>
Copyright 2017 Teradici Corporation. All Rights Reserved.

Some content is based off of the Azure Quickstart Templates, Copyright (c) Microsoft Azure. With the following license: https://github.com/Azure/azure-quickstart-templates/blob/master/LICENSE
