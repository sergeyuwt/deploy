# Install-PCoIPAgent.ps1
Configuration InstallPCoIPAgent
{
    param (
        [string] $activationCode
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
            DestinationPath = "C:\WindowsAzure\PCoIPAgentInstaller"
        }

        Script Install_PCoIPAgent
        {
            DependsOn  = "[File]Download_Directory"
            GetScript  = { @{ Result = "Install_PCoIPAgent" } }

            #TODO: Check for other agent types as well?
            TestScript = { if ( Get-Item -path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\PCoIP Standard Agent" -ErrorAction SilentlyContinue )
                            {return $true}
                            else {return $false} }
            SetScript  = {
                Write-Verbose "Install_PCoIPAgent"

                $source = "https://teradeploy.blob.core.windows.net/binaries/PCoIP_agent_release_installer_2.8.0.5614_standard.exe"
                $dest = "C:\WindowsAzure\PCoIPAgentInstaller"
                $installerFileName = "PCoIP_agent_release_installer_2.8.0.5614_standard.exe"
                Invoke-WebRequest $source -OutFile "$dest\$installerFileName"

                #install the agent
                # & "$dest\$installerFileName" /S | Out-Null
                Start-Process "$dest\$installerFileName" /S -Wait

                $folder = "C:\Program Files (x86)\Teradici\PCoIP Agent"
                $activateCmd = ".\pcoip-register-host -RegistrationCode"
                cd $folder
                #& "$activateCmd ' ' $using:activationCode"
                & .\pcoip-register-host -RegistrationCode $using:activationCode
            }
        }
    }
}
