Configuration VmUsability
{
    Import-DscResource -module xFirefox

    Node "localhost"
    {
        Registry DisableServerManager
        {
            Ensure = "Present"
            Key = "HKLM:\Software\Microsoft\ServerManager"
            ValueName = "DoNotOpenServerManagerAtLogon"
            ValueData = "1"
            ValueType = "Dword"
        }


        MSFT_xFirefox Firefox
        {
            #install the latest firefox browser
        }
    }
}