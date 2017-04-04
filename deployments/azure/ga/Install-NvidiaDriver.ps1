# Install-NvidiaDriver.ps1
Configuration InstallNvidiaDriver
{
	param(
     	[Parameter(Mandatory=$false)]
     	[String] $sourceUrl ="https://teradeploy.blob.core.windows.net/binaries/369.71_win10_64bit_international-1015172-02.zip"
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
                $destFile = "c:\WindowsAzure\NvidiaInstaller\nvidia-driver.zip"
                $sourceUrl = $using:sourceUrl
                Invoke-WebRequest $sourceUrl -OutFile $destFile

                Write-Verbose "Unzipping Nvidia driver"
				$localNvidiaPath = "c:\nvidia"
                Expand-Archive $destFile -DestinationPath $localNvidiaPath -Force

                Write-Verbose "Starting to Install Nvidia driver"
                Set-Location $localNvidiaPath
                Set-ExecutionPolicy Unrestricted -force
                .\setup.exe -s -noreboot -clean
                Start-Sleep -s 180

                Write-Verbose "Finished Nvidia driver Installation"
            }
        }
    }
}