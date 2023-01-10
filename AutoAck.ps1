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

$ie.Document.IHTMLDocument3_getElementByID('ext-gen56').click()
Start-Sleep -Seconds 1

$body = $ie.Document.IHTMLDocument3_getElementsByTagName("body")[0]
$tables = $body.getElementsByClassName("x-grid3-row-table")
$count = $tables.length
Start-Sleep -Seconds 1

# Print the count
Write-Output "Number of notifications that will be acknowledged: $count"

foreach($i in 1..$count){
    Start-Sleep -Milliseconds 300
    $ie.Document.IHTMLDocument3_getElementByID('ext-gen77').click()
}

Read-Host -Prompt "Script finished, Press Enter to close"
$ie.Quit()
