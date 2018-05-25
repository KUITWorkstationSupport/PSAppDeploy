#v1.0 by Calvin Schulte 03/2018.
#v1.1 by Calvin Schulte 05/2018. We are now including the old school "Adobe Reader" in this as well because the updater for Reader DC will natively uninstall it, which is a goal.

#-------------Edit Here-------------#
$appName = "Adobe Acrobat Reader DC*"
$appNameAlt = "Adobe Reader*"
$minVersion = "18.011.20040"
#-------------Edit Here-------------#

#Set the hive search variable for either 32 bit or 64 bit Uninstall. If 64 bit, set the search path to BOTH Uninstall hives.
switch((Get-WmiObject Win32_OperatingSystem).OSArchitecture)
    {
        "32-bit" {$hivePath="HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*"}
        "64-bit" {$hivePath='HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*','HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'}
    }

#Search the uninstall registry hive for the app name and app version
$installedVersion = Get-ItemProperty $hivePath | Where-Object {$_.DisplayName -Like $appName -or $_.DisplayName -Like $appNameAlt} | Select-Object DisplayVersion

if ([version]$installedVersion.DisplayVersion -ge [version]$minVersion -or $installedVersion -eq $null)
    {
        $Compliant = $true
    }
else
    {
        $Compliant = $false
    }
$Compliant