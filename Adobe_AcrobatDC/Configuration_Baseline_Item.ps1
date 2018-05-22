#v1.0 by Calvin Schulte 03/2018.


#What it does: Search the Uninstall registry hive for a specified application, then compare the version to a specified version and report compliance or non-compliance based on a comparison.
#Why not use a WMI query for win32_product? Querying win32_product triggers MSI validation and repair on all registered MSI applications.
#Why not use a WMI query for SCCM's win32reg_addremoveprograms? Not all programs that are installed reliably end up in there.
#AcrobatDC-Specific weirdness:
    #You can have an "Adobe Acrobat DC" installed that is Classic track. Since the MSP won't work for that, we have to also check if it's Continuous
    #To do this, you have to decode the GUID a bit. See https://www.adobe.com/devnet-docs/acrobatetk/tools/AdminGuide/identify.html

#-------------Edit Here-------------#
$appName = "Adobe Acrobat DC*"
$minVersion = "18.011.20040"       #Minimum version to be compliant.
#-------------Edit Here-------------#

#Set the hive search variable for either 32 bit or 64 bit Uninstall. If 64 bit, set the search path to BOTH Uninstall hives.
switch((Get-WmiObject Win32_OperatingSystem).OSArchitecture)
    {
        "32-bit" {$hivePath="HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*"}
        "64-bit" {$hivePath='HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*','HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'}
    }

#Search the uninstall registry hive for the app name and app version
$installedVersion = Get-ItemProperty $hivePath | Where-Object {$_.DisplayName -Like $appName} | Select-Object DisplayVersion,PSChildName

#If no Acrobat DC is found, we'll call it compliant.
if ($installedVersion -eq $null) 
    {
        $Compliant = $true
        Return $Compliant
    }

#If Acrobat DC isn't Continuous, we'll call it compliant because the patch wouldn't work otherwise.
$acrobatDCTrack = $installedVersion.PSChildName.Substring(26,1)
if ($acrobatDCTrack -ne "C") 
    {
        $Compliant = $true
        Return $Compliant
    }

if ([version]$installedVersion.DisplayVersion -ge [version]$minVersion)
    {
        $Compliant = $true
    }
else
    {
        $Compliant = $false
    }
$Compliant