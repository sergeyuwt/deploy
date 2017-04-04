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
            GetScript  = { @{ Result = "Install_Nvidia" } }

            TestScript = {
    			return $false
			}

            SetScript  = {
                Write-Verbose "Downloading Nvidia driver"
                $destFile = "$LocalDLPath\$nvidiaInstaller"
                #temp for test
                $sourceurl = "https://teradeploy.blob.core.windows.net/binaries/369.71_win10_64bit_international-1015172-02.zip"
                Invoke-WebRequest $sourceUrl -OutFile $destFile

                #Unzip "D:\Downloadinstallers\NVAzureDriver.zip" "D:\NVIDIAazure"

                Write-Verbose "Unzipping Nvidia driver"

				$localNvidiaPath = "$env:systemdrive\nvidia"
                Expand-Archive $destFile -DestinationPath $localNvidiaPath

                Write-Verbose "Starting to Install Nvidia driver"

                $setupFile = $localNvidiaPath + "\setup.exe"
                Start-Process -FilePath $destFile -setupFile "/S /nopostreboot" -PassThru -Wait
				
	            Write-Verbose "Finished Nvidia driver Installation"
            }
        }
    }
}