#!/bin/ash
set -e


mkdir -p /config/users
mkdir -p /config/host_keys


if [[ ! -e /config/sshd_config ]]; then
	echo "$(date) [err] /config/sshd_config missing. Replacing with default backup!"
	cp /etc/default/sshd/sshd_config /config/sshd_config
else
    echo "$(date) [info] /config/sshd_config found. Copying to container filesystem!"
fi
rm /etc/ssh/sshd_config
cp /config/sshd_config /etc/ssh/sshd_config


function createUser() {
    user="${1}"
    
    if getent passwd $user > /dev/null; then
        echo "Skipping creating user: $user (already exists)"
        return 0
    fi
    echo "Creating user: $user"
    
    adduser -D -s /bin/ash $user
    chmod 755 /home/$user
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
    
    if [ ! -f /config/users/$user/key.pub ]; then
        ssh-keygen -f /config/users/$user/key -t rsa -C "$user" -N ''
        mv /config/users/$user/key "/config/""$user""_private_key"
        echo "Generated SSH keys."
    fi
    mkdir -p /home/$user/.ssh/
    cp -f /config/users/$user/key.pub /home/$user/.ssh/authorized_keys
    chmod 600 /home/$user/.ssh/authorized_keys
    chown $user:$user /home/$user/.ssh/authorized_keys
}

function removeUser() {
    user="${1}"
    echo "Removing user: $user"
    
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
        #Not removing for now, in case this makes permissions behave badly when readding user with same name. (if backup files are owned by user etc.)
        #removeUser $(basename $U)
        echo "WARNING: user without config is still present: $(basename $U)"
    fi
done


if [[ "$(ls /config/host_keys | wc -l)" -gt "0" ]]; then
    cp -f /config/host_keys/ssh_host_*key* /etc/ssh/
fi
ssh-keygen -A
mv /etc/ssh/ssh_host_*key* /config/host_keys/


for K in `find /config/ -maxdepth 1 -mindepth 1 -type f -name '*_private_key'`; do
    echo "WARNING: private key still present in config folder; remember it can be removed: $K"
done


chown -R root:root /config
chmod -R o-rwx /config

apk update
apk upgrade

exec /usr/sbin/sshd -D -e "$@"