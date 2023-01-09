$IP = Read-Host -Prompt 'Input your server IP'
$username = Read-Host -Prompt 'Enter your user ID'
$password = Read-Host 'Enter your password?' -AsSecureString

$pw = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))
$url = "http://"+$IP+":8080/tamsweb/login.do"

$ie = New-Object -ComObject 'internetExplorer.Application'
$ie.Visible= $true
$ie.Navigate($url)

while ($ie.Busy -eq $true){Start-Sleep -seconds 1;}   

$usernamefield = $ie.Document.IHTMLDocument3_getElementByID('txtEmployeeNumber').value = $username;
$passwordfield = $ie.Document.IHTMLDocument3_getElementByID('txtPassword').value = $pw;
While ($ie.Busy -eq $true) {Start-Sleep -Seconds 1;}

$button = $ie.Document.IHTMLDocument3_getElementByID('btnTamsLogin')
$button.removeAttribute("disabled");
$button.click()
While ($ie.Busy -eq $true) {Start-Sleep -Seconds 1;}
Start-Sleep -Seconds .5
$ie.Document.IHTMLDocument3_getElementByID('ext-gen56').click()
Start-Sleep -Seconds 1

foreach($i in 1..250){
    #Write-Host $i
    Start-Sleep -Milliseconds 300
    $ie.Document.IHTMLDocument3_getElementByID('ext-gen77').click()
}
$ie.Quit()