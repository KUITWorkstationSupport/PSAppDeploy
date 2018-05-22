if(Test-Path('C:\Program Files\iTunes\iTunes.exe')) {
    #Obtain version of iTunes currently installed
    $iTunesVer = [System.Version]((get-item 'C:\Program Files\iTunes\iTunes.exe').VersionInfo.fileversion)

    #Set iTunes Compliance to $true if current version is installed; if the install is old then $false
    if($iTunesVer -ge "12.7.4.80"){$iTunesCompliant = $true}ELSE{$iTunesCompliant = $false}
}
    
#Set iTunes Compliance to $true if no existing iTunes install so that baseline deployments are ignored.
else {
    $iTunesCompliant = $true
}
    
$iTunesCompliant