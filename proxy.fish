set PROXY 127.0.0.1:1080

function git_proxy
    if test (git config --global --get http.proxy; or echo "") = "http://$PROXY"
        git config --global --unset http.proxy
        git config --global --unset https.proxy
        echo "unset git proxy"
    else
        git config --global http.proxy http://$PROXY
        git config --global https.proxy http://$PROXY
        echo "set git proxy $PROXY"
    end
end

function npm_proxy
    if test (npm config get proxy) = "http://$PROXY/"
        npm config delete proxy
        npm config delete https_proxy
        echo "unset npm proxy"
    else
        npm config set proxy http://$PROXY
        npm config set https_proxy http://$PROXY
        echo "set npm proxy $PROXY"
    end
end

function snap_proxy
    if test (snap get system proxy.http) = "http://$PROXY"
        sudo snap unset system proxy.http
        sudo snap unset system proxy.https
        echo "unset snap proxy"
    else
        sudo snap set system proxy.http="http://$PROXY"
        sudo snap set system proxy.https="http://$PROXY"
        echo "set snap proxy $PROXY"
    end
end

function apt_proxy
    if grep '#Acquire::http::Proxy' /etc/apt/apt.conf.d/proxy.conf > /dev/null
        echo -e "Acquire::http::Proxy \"http://$PROXY\";\nAcquire::https::Proxy \"http://$PROXY\";" | sudo tee /etc/apt/apt.conf.d/proxy.conf > /dev/null
        echo "set apt proxy $PROXY"
    else
        sed 's/Ac/#Ac/' /etc/apt/apt.conf.d/proxy.conf | sudo tee /etc/apt/apt.conf.d/proxy.conf > /dev/null
        echo "unset apt proxy"
    end
end

function set_proxy
    if test "$http_proxy" = "http://$PROXY"
        set -x http_proxy
        set -x https_proxy
        echo "now proxy is off"
    else
        set -x http_proxy "http://$PROXY"
        set -x https_proxy "http://$PROXY"
        echo "now proxy is on; $http_proxy"
    end
end

switch $argv[1]
    case git
        git_proxy
    case npm
        npm_proxy
    case snap
        snap_proxy
    case apt
        apt_proxy
    case '*'
        set_proxy
end