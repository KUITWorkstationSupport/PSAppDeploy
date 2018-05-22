$FirefoxCompliant = $null

If (Test-Path -Path (${env:ProgramFiles} + "\Mozilla Firefox\firefox.exe"))
{
    #Obtain version of Firefox currently installed
    $FirefoxVer = [System.Version](((Get-Item (${env:ProgramFiles} + "\Mozilla Firefox\firefox.exe")).VersionInfo.fileversion))

    #Set Firefox Compliance to $true if current version is installed; if the version is older then $false
    If ($FirefoxVer -ge "60.0.1")
    {
        $FirefoxCompliant = $true
    }
        Else
        {
            $FirefoxCompliant = $false
        }
}

#Set Firefox Compliance to $true if no existing Firefox install so that baseline deployments are ignored.
    Else
    {
        $FirefoxCompliant = $true
    }

$FirefoxCompliant