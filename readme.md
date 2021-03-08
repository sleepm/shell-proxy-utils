# usage
if your proxy is 127.0.0.1:1080
or change PROXY in this script
```
#bash / zsh user
curl https://raw.githubusercontent.com/sleepm/shell-proxy-utils/main/proxy.sh -o ~/proxy
source ~/proxy
source ~/proxy npm

#fish user
curl https://raw.githubusercontent.com/sleepm/shell-proxy-utils/main/proxy.fish -o ~/proxy
source ~/proxy
source ~/proxy npm

#powershell user
$Response = Invoke-WebRequest -Uri "https://raw.githubusercontent.com/sleepm/shell-proxy-utils/main/proxy.ps1"
$Stream = [System.IO.StreamWriter]::new('~\proxy.ps1', $false, $Response.Encoding)
try {
    $Stream.Write($Response.Content)
}
finally {
    $Stream.Dispose()
}
. ~\proxy.ps1
. ~\proxy.ps1 npm
```
