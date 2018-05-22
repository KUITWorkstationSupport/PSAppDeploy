#Clear JavaCompliant variable in case still stored in memory
$JavaCompliant = $null

#Set and test path for Java.  If Java is detected, check against current prod version
#If Java is not detected, set flag to compliant as no Java is actually better than up-to-date Java :)
$Javax64Path = "$env:SystemDrive\Program Files\Java"
if((Test-Path $Javax64Path) -eq $true){
    $CurrentJREpath = (dir $Javax64Path).FullName | Sort -Descending | Select -First 1
    $JavaVersion = $CurrentJREpath.Substring(31)

    if($JavaVersion -ge "172"){$JavaCompliant = $true}ELSE{$JavaCompliant = $false}}ELSE{$JavaCompliant = $true}

$JavaCompliant