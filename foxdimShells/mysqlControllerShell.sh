#!/bin/bash

# MySQL service name
service_name="mysql"

# Check if the MySQL service is running
service_status=$(systemctl is-active "$service_name")

if [ "$service_status" = "inactive" ] || [ "$service_status" = "failed" ]; then
    echo "MySQL service is stopped or failed, starting it..."
    # Start the MySQL service
    systemctl start "$service_name"

    # Ensure it started successfully
    if [ "$(systemctl is-active "$service_name")" = "active" ]; then
        echo "MySQL service has been successfully started."
    else
        echo "MySQL service could not be started."
    fi
else
    echo "MySQL service is already running."
fi
