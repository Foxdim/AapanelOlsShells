#!/bin/bash

server="apache"  # Default to Apache server

# Check for LightSpeed Web Server
if command -v /usr/local/lsws/bin/lswsctrl >/dev/null 2>&1; then
    server="lsws"  # If LightSpeed Web Server is found, set the server variable to lsws
fi

script_dir="$(dirname "$(realpath "$0")")"
mysqlControllerShell="$script_dir/mysqlControllerShell.sh"
echo "#### MYSQL Controller Started ####"
"$mysqlControllerShell"
echo ""

if [ "$server" = "lsws" ]; then
    htaccessShell="$script_dir/htaccessShell.sh"
    lswsControllerShell="$script_dir/lswsControllerShell.sh"
    echo "#### Htaccess Controller Started ####"
    "$htaccessShell"
    echo ""

    echo "#### LiteSpeed Server Controller Started ####"
    "$lswsControllerShell"
    echo ""
fi
