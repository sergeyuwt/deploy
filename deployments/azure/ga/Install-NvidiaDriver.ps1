# Install-NvidiaDriver.ps1
Configuration InstallNvidiaDriver
{
	param(
     	[Parameter(Mandatory=$true)]
     	[String] $sourceUrl,

     	[Parameter(Mandatory=$false)]
        [String] $LocalDLPath = "$env:systemdrive\WindowsAzure\PCoIPAgentInstaller",

     	[Parameter(Mandatory=$false)]
        [String] $nvidiaInstaller = "nvidia-driver.zip"
    )
	
	#Import-DscResource -ModuleName xPSDesiredStateConfiguration

    Node "localhost"
    {
        LocalConfigurationManager
        {
            RebootNodeIfNeeded = $true
        }

        Script InstallNvidiaDriver
        {
            DependsOn  = "[xRemoteFile]Download_Nvidia_Installer"
            GetScript  = { @{ Result = "Install_Nvidia" } }

            TestScript = {
    			return $false
			}

            SetScript  = {
                Write-Verbose "Downloading Nvidia driver"
                $nvidiaGetResp = Invoke-WebRequest $sourceUrl -UseBasicParsing
                [io.file]::WriteAllBytes("$LocalDLPath\$nvidiaInstaller", $nvidiaGetResp.Content)
                #Unzip "D:\Downloadinstallers\NVAzureDriver.zip" "D:\NVIDIAazure"

                Write-Verbose "Unzipping Nvidia driver"

				$localNvidiaPath = "$env:systemdrive\nvidia"
                Expand-Archive "$LocalDLPath\$nvidiaInstaller" -DestinationPath $localNvidiaPath

                Write-Verbose "Starting to Install Nvidia driver"

                $setupFile = $localNvidiaPath + "\setup.exe"
                Start-Process -FilePath $destFile -setupFile "/S /nopostreboot" -PassThru -Wait
				
	            Write-Verbose "Finished Nvidia driver Installation"
            }
        }
    }
}