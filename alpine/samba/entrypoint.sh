#!/bin/ash
set -e

if [[ ! -e /config/smb.conf ]]; then
	echo "$(date) [err] /config/smb.conf missing. Replacing with default backup!"
	cp /etc/default/samba/smb.conf /config/smb.conf
else
    echo "$(date) [info] /config/smb.conf found. Copying to container filesystem!"
fi
rm /etc/samba/smb.conf
cp /config/smb.conf /etc/samba/smb.conf
chown root:root /etc/samba/smb.conf
chmod 644 /etc/samba/smb.conf


mkdir -p /config/users

function createUser() {
    user="${1}"
    
    if getent passwd $user > /dev/null; then
        echo "Skipping creating user: $user (already exists)"
        return 0
    fi
    echo "Creating user: $user"
    
    adduser -D -s /sbin/nologin $user
    chmod 750 /home/$user
    chown -R $user:$user /home/$user
}

function updateUser() {
    user="${1}"
    echo "Updating user auth: $user"
    
    if [ ! -f /config/users/$user/password ]; then
        pwgen -s -1 63 > /config/users/$user/password
    fi
    pass=`cat /config/users/$user/password`
    passwd -d $user
    echo "$user:$pass" | chpasswd
    echo "Set password."
    
    smbpasswd -x $user || true
    echo -e "$pass\n$pass" | smbpasswd -as $user
    smbpasswd -e $user
    echo "Added to samba."
}

function removeUser() {
    user="${1}"
    echo "Removing user: $user"
    
    smbpasswd -d $user || true
    smbpasswd -x $user || true
    
    deluser --remove-home $user
}


if [[ "$(ls /config/users | wc -l)" -eq "0" ]]; then
    mkdir /config/users/user
fi

for U in `find /config/users/ -maxdepth 1 -mindepth 1 -type d`; do
    createUser $(basename $U)
    updateUser $(basename $U)
done


for U in `find /home/ -maxdepth 1 -mindepth 1 -type d`; do
    UCONFIG=/config/users/$(basename $U)
    if [[ ! -d "$UCONFIG" ]]; then
        removeUser $(basename $U)
    fi
done


apk update
apk upgrade


if [ -z "$@" ]; then
    # Needed so that smbd doesn't get EOF and decide to exit.
    exec sh -c "smbd -SF --no-process-group < /dev/null"
else
    exec "$@"
fi
