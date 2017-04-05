# Install-NvidiaDriver.ps1
Configuration InstallNvidiaDriver
{
	param(
     	[Parameter(Mandatory=$false)]
     	[String] $sourceUrl ="https://binarystore.blob.core.windows.net/thirdparty/nvidia/369.95_grid_win10_server2016_64bit_international.exe"
    )
	
    Node "localhost"
    {
        LocalConfigurationManager
        {
            RebootNodeIfNeeded = $true
        }

        File Download_Directory 
        {
            Ensure          = "Present"
            Type            = "Directory"
            DestinationPath = "C:\WindowsAzure\NvidiaInstaller"
        }


        Script InstallNvidiaDriver
        {
            DependsOn  = "[File]Download_Directory"

            GetScript  = { @{ Result = "Install_Nvidia" } }

            TestScript = {
    			return $false
			}

            SetScript  = {
                Write-Verbose "Downloading Nvidia driver"
                $sourceUrl = $using:sourceUrl
                $installerFileName = [System.IO.Path]::GetFileName($sourceUrl)
                $destFile = "c:\WindowsAzure\NvidiaInstaller\" + $installerFileName
                Invoke-WebRequest $sourceUrl -OutFile $destFile

                Write-Verbose "Installing Nvidia driver"
                Start-Process -FilePath $destFile -ArgumentList "/s" -Wait

                Write-Verbose "Finished Nvidia driver Installation"
            }
        }
    }
}