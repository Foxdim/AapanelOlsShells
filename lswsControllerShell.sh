#!/bin/bash

script_dir="$(dirname "$(realpath "$0")")"
htaccessfilelastmodifpath="$script_dir/Variables/LswsLastCacheControlTime.txt"

# Create the file if it does not exist and write 0 to it
if [ ! -f "$htaccessfilelastmodifpath" ]; then
    echo "File not found, creating: $htaccessfilelastmodifpath"
    mkdir -p "$(dirname "$htaccessfilelastmodifpath")"  # Create the directory
    echo "0" > "$htaccessfilelastmodifpath"  # Default value is 0
fi

# Get the time information from the file
cache_last_checked_time=$(cat "$htaccessfilelastmodifpath")
current_time=$(date +"%s")

# Check if the LiteSpeedServer service is running
service_name="lsws"
service_status=$(systemctl is-active $service_name)

if [ "$service_status" = "inactive" ] || [ "$service_status" = "failed" ]; then
    echo "LiteSpeedServer service is stopped, starting it..."
    systemctl start $service_name
else
    echo "LiteSpeedServer service is running."
fi

# Cache control - run once every hour
if [ $((current_time - cache_last_checked_time)) -ge 3600 ]; then
    if [ -d "/usr/local/lsws/cachedata/priv/" ]; then
        echo "Clearing cache..."
        find /usr/local/lsws/cachedata/priv/* -mtime +2 -type f -delete
        echo "$(date +"%s")" > "$htaccessfilelastmodifpath"
    else
        echo "/usr/local/lsws/cachedata/priv/ directory does not exist. Cache clearing operation was not performed."
    fi
else
    echo "Cache clearing operation has not yet exceeded the hourly threshold."
fi
