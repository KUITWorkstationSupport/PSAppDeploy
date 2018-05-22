$VLCCompliant = $null

If (Test-Path -Path (${env:ProgramFiles} + "\VideoLAN\VLC\vlc.exe"))
{
    #Obtain version of VLC currently installed
    $VLCVer = [System.Version](((Get-Item (${env:ProgramFiles} + "\VideoLAN\VLC\vlc.exe")).VersionInfo.fileversion))

    #Set VLC Compliance to $true if current version is installed; if the version is older then $false
    If ($VLCVer -ge "3.0.2")
    {
        $VLCCompliant = $true
    }
        Else
        {
            $VLCCompliant = $false
        }
}

#Set VLC Compliance to $true if no existing VLC install so that baseline deployments are ignored.
    Else
    {
        $VLCCompliant = $true
    }

$VLCCompliant