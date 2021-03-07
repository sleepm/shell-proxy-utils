# usage
```
#bash / zsh user
curl https://github.com/sleepm/shell-proxy-utils/proxy.sh -o ~/proxy
source ~/proxy
source ~/proxy npm

#fish user
curl https://github.com/sleepm/shell-proxy-utils/proxy.fish -o ~/proxy
source ~/proxy
source ~/proxy npm

#powershell user
$Response = Invoke-WebRequest -Uri "https://github.com/sleepm/shell-proxy-utils/proxy.ps1"
$Stream = [System.IO.StreamWriter]::new('~\proxy.ps1', $false, $Response.Encoding)
try {
    $Stream.Write($Response.Content)
}
finally {
    $Stream.Dispose()
}
. ~\proxy.sh
. ~\proxy npm
```