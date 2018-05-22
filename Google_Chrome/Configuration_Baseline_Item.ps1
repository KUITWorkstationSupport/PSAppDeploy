$ChromeCompliant=$null
$ChromeCompliant64=$null
$ChromeCompliant32=$null

If (Test-Path -Path (${env:ProgramFiles(x86)} + "\Google\Chrome\Application\chrome.exe"))
{
    #Obtain 64-bit version of Chrome currently installed
    $ChromeVer64 = [System.Version](((Get-Item (${env:ProgramFiles(x86)} + "\Google\Chrome\Application\chrome.exe")).VersionInfo.fileversion))

    #Set Chrome Compliance to $true if current version is installed; if the install is old then $false
    If ($ChromeVer64 -ge "66.0.3359.181")
    {
        $ChromeCompliant64 = $true
    }
        ELSE
        {
            $ChromeCompliant64 = $false
        }
}

If (Test-Path -Path (${env:ProgramFiles} + "\Google\Chrome\Application\chrome.exe"))
{
    #Obtain 32-bit version of Chrome currently installed
    $ChromeVer32 = [System.Version](((Get-Item (${env:ProgramFiles} + "\Google\Chrome\Application\chrome.exe")).VersionInfo.fileversion))

    #Set Chrome Compliance to $true if current version is installed; if the install is old then $false
    If ($ChromeVer32 -ge "66.0.3359.181")
    {
        $ChromeCompliant32 = $true
    }
        Else 
        {
            $ChromeCompliant32 = $false
        }
}
If (($ChromeCompliant64 -eq $false) -or ($ChromeCompliant32 -eq $false))
    {
        $ChromeCompliant = $false
    }
#Set Chrome Compliance to $true if no existing Chrome install so that baseline deployments are ignored.
    ELSE
    {
        $ChromeCompliant = $true
    }
    
$ChromeCompliant