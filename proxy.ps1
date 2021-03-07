$PROXY = '127.0.0.1:1080'

function git_proxy() {
    $git_http_proxy = git config --global --get http.proxy
    if ( $git_http_proxy -eq "http://$PROXY" ){
        git config --global --unset http.proxy
        git config --global --unset https.proxy
        Write-Output 'unset git proxy'
    } else {
        git config --global http.proxy http://$PROXY
        git config --global https.proxy http://$PROXY
        Write-Output "set git proxy $PROXY"
    }
}

function npm_proxy() {
    $npm_http_proxy = npm config get proxy
    if ( $npm_http_proxy -eq "http://$PROXY/" ) {
        npm config delete proxy
        npm config delete https_proxy
        Write-Output "unset npm proxy"
    } else{
        npm config set proxy http://$PROXY
        npm config set https_proxy http://$PROXY
        Write-Output "set npm proxy $PROXY"
    }
}

function set_proxy() {
    if ( $Env:http_proxy -eq "http://$PROXY" ) {
        $Env:http_proxy=''
        $Env:https_proxy=''
        Write-Output 'now proxy is off'
    } else {
        $Env:http_proxy="http://$PROXY"
        $Env:https_proxy="http://$PROXY"
        Write-Output "now proxy is on; $Env:http_proxy"
    }
}

switch ($args[0]) {
    git {
        git_proxy
    }
    npm {
        npm_proxy
    }
    default {
        set_proxy
    }
}