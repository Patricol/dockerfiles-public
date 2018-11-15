#!/bin/bash

if [ -f /config/config ]; then
	echo "Existing configuration found."
else
    echo "Using default configuration."
    cp /default_config /config/config
fi

if [ -f /config/refresh_token ]; then
    exec /usr/local/bin/onedrive "$@"
else
	if [ -z "${URI_RESPONSE}" ]; then
		echo 'ERROR: URI_RESPONSE required but not found!
	Please provide (as an env variable) the URI you are redirected to after authorizing this app here:
	https://login.microsoftonline.com/common/oauth2/v2.0/authorize?client_id=22c49a0d-d21c-4792-aed1-8f163c982546&scope=files.readwrite%20files.readwrite.all offline_access&response_type=code&redirect_uri=https://login.microsoftonline.com/common/oauth2/nativeclient'
		exit 1
	fi
    echo "${URI_RESPONSE}" | exec /usr/local/bin/onedrive "$@"
fi