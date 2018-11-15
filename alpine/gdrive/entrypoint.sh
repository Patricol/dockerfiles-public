#!/bin/sh

set -ex

PUID=${PUID:-0}
PGID=${PGID:-0}

if [ -e /config/config ]; then
	echo "Existing configuration found."
	if [[ -n "${CLIENT_ID}" || -n "${CLIENT_SECRET}" || -n "${VERIFICATION_CODE}" ]]; then
		echo "WARNING: Authentication env variables are being ignored! (Using existing configuration instead.)"
	fi
else
	if [ -z "${CLIENT_ID}" ]; then
		echo "ERROR: No CLIENT_ID found!"
		exit 1
	elif [ -z "${CLIENT_SECRET}" ]; then
		echo "ERROR: No CLIENT_SECRET found!"
		exit 1
	elif [ -z "${VERIFICATION_CODE}" ]; then
		echo "ERROR: No VERIFICATION_CODE found!"
		exit 1
	else
		echo "Initializing configuration file...."
        cp /default_config /config/config
        if [ -n "$(tail -c 1 /default_config)" ]; then
            echo "" | tee -a /config/config
        fi
        echo "client_id=${CLIENT_ID}.apps.googleusercontent.com" | tee -a /config/config
        echo "client_secret=${CLIENT_SECRET}" | tee -a /config/config
        echo "verification_code=${VERIFICATION_CODE}" | tee -a /config/config
	fi
fi

if [ -n "${MOUNT_OPTS}" ]; then
	MOUNT_OPTS=",${MOUNT_OPTS}"
fi

echo "Mounting...."
exec google-drive-ocamlfuse /data -headless -f -o uid=${PUID},gid=${PGID},noatime${MOUNT_OPTS} "$@"