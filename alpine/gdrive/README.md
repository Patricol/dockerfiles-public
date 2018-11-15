# alpine-gdrive

Docker image to mount a google drive with google-drive-ocamlfuse shared with host.

don't include lines for client_id, client_secret, or verification_code to the default_config file; they will be added by entrypoint.sh. config file does not support comments etc.
https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities

ln -s /mnt/gdrive /mnt/user/gdrive && chown nobody:users -h /mnt/user/gdrive

If you get a 'server error' when restarting the container in unraid, run "fusermount -uz /mnt/gdrive/"



### Environment Variables
* `PUID`: User ID of mounted files
* `PGID`: Group ID of mounted files
* `MOUNT_OPTS`: Additional mount options
* `CLIENT_ID`: Google oAuth client ID without trailing `.apps.googleusercontent.com`
* `CLIENT_SECRET`: Google oAuth client secret
* `VERIFICATION_CODE`: Google oAuth verification code you will need to obtain manually (and prior to launching the container) by accepting the prompts at the following URL (with CLIENT_ID substituted):
    - `https://accounts.google.com/o/oauth2/auth?client_id=${CLIENT_ID}.apps.googleusercontent.com&redirect_uri=urn:ietf:wg:oauth:2.0:oob&scope=https://www.googleapis.com/auth/drive&response_type=code&access_type=offline&approval_prompt=force`

### UnRAID Host Configuration
# Specify the mount points propagation as shared (execute as root)
mount --bind /mnt/drive /mnt/drive
mount --make-shared /mnt/drive
````