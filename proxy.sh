PROXY="127.0.0.1:1080"

function git_proxy(){
    if [[ `git config --global --get http.proxy || echo ""` == "http://$PROXY" ]]; then
        git config --global --unset http.proxy
        git config --global --unset https.proxy
        echo "unset git proxy"
    else
        git config --global http.proxy http://$PROXY
        git config --global https.proxy http://$PROXY
        echo "set git proxy $PROXY"
    fi
}

function npm_proxy(){
    if [[ `npm config get proxy` == "http://$PROXY/" ]]; then
        npm config delete proxy
        npm config delete https_proxy
        echo "unset npm proxy"
    else
        npm config set proxy http://$PROXY
        npm config set https_proxy http://$PROXY
        echo "set npm proxy $PROXY"
    fi
}

function snap_proxy(){
    if [[ `snap get system proxy.http` == "http://$PROXY" ]]; then
        sudo snap unset system proxy.http
        sudo snap unset system proxy.https
        echo "unset snap proxy"
    else
        sudo snap set system proxy.http="http://$PROXY"
        sudo snap set system proxy.https="http://$PROXY"
        echo "set snap proxy $PROXY"
    fi
}

function set_proxy(){
    if [[ "$http_proxy" == "http://$PROXY" ]]; then
        export http_proxy=''
        export https_proxy=''
        echo "now proxy is off"
    else
        export http_proxy="http://$PROXY"
        export https_proxy="http://$PROXY"
        echo "now proxy is on; $http_proxy"
    fi
}

case "$1" in
    git)
        git_proxy;;
    npm)
        npm_proxy;;
    snap)
        snap_proxy;;
    *)
        set_proxy;;
esac