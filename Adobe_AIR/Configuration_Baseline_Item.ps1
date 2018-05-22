#v1.0 by Calvin Schulte 06/2017.
#v1.1 by Calvin Schulte 06/2017. Added Unique switch for the registry query because Adobe Air returns twice on a regular install and would report a false non-compliance.
#v1.2 by Calvin Schulte 03/2018. Stronger typing for versions. True/False are now legit boolean instead of just strings.

#What it does: Search the Uninstall registry hive for a specified application, then compare the version to a specified version and report compliance or non-compliance based on a comparison.

#Why not use a WMI query for win32_product? Querying win32_product triggers MSI validation and repair on all registered MSI applications.
#Why not use a WMI query for SCCM's win32reg_addremoveprograms? Not all programs that are installed reliably end up in there.

#-------------Edit Here-------------#
$appName = "Adobe AIR"
$minVersion = "29.0.0.112"
#-------------Edit Here-------------#

#Set the hive search variable for either 32 bit or 64 bit Uninstall. If 64 bit, set the search path to BOTH Uninstall hives.
switch((Get-WmiObject Win32_OperatingSystem).OSArchitecture)
    {
        "32-bit" {$hivePath="HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*"}
        "64-bit" {$hivePath='HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*','HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'}
    }

#Search the uninstall registry hive for the app name and app version
$installedVersion = Get-ItemProperty $hivePath | Where-Object {$_.DisplayName -Like $appName} | Select-Object DisplayVersion -Unique

if ([version]$installedVersion.DisplayVersion -ge [version]$minVersion -or $installedVersion -eq $null)
    {
        $Compliant = $true
    }
else
    {
        $Compliant = $false
    }
$Compliant