If (Test-Path -Path (${env:ProgramFiles} + "\7-Zip\7z.exe")) {
    # Obtain version of 7zip currently installed
    $7zipVer = [System.Version](((Get-Item (${env:ProgramFiles} + "\7-Zip\7z.exe")).VersionInfo.fileversion))

    # Set 7zip Compliance to $true if current version is installed; if the version is older then $false
    If ($7zipVer -ge "18.05") {
        $7zipCompliant = $true
    }
    Else {
        $7zipCompliant = $false
    }
}

# Set 7zip Compliance to $true if no existing 7zip install so that baseline deployments are ignored.
Else {
    $7zipCompliant = $true
}

$7zipCompliant