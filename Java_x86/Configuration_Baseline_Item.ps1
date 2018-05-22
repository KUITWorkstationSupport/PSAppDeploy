#Clear JavaCompliant variable in case still stored in memory
$JavaCompliant = $null

#Set and test path for Java.  If Java is detected, check against current prod version
#If Java is not detected, set flag to compliant as no Java is actually better than up-to-date Java :)
$Javax86Path = "$env:SystemDrive\Program Files (x86)\Java"
if((Test-Path $Javax86Path) -eq $true){
    $CurrentJREpath = (dir $Javax86Path).FullName | Sort -Descending | Select -First 1
    $JavaVersion = $CurrentJREpath.Substring(37)

    if($JavaVersion -ge "172"){$JavaCompliant = $true}ELSE{$JavaCompliant = $false}}ELSE{$JavaCompliant = $true}

$JavaCompliant