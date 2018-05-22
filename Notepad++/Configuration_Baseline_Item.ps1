$NPPCompliant = $null

If (Test-Path -Path (${env:ProgramFiles} + "\Notepad++\notepad++.exe"))
{
    #Obtain version of NPP currently installed
    $NPPVer = [System.Version](((Get-Item (${env:ProgramFiles} + "\Notepad++\notepad++.exe")).VersionInfo.fileversion))

    #Set NPP Compliance to $true if current version is installed; if the version is older then $false
    If ($NPPVer -ge "7.5.4.0")
    {
        $NPPCompliant = $true
    }
        Else
        {
            $NPPCompliant = $false
        }
}

#Set VLC Compliance to $true if no existing VLC install so that baseline deployments are ignored.
    Else
    {
        $NPPCompliant = $true
    }

$NPPCompliant