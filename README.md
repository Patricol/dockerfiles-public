# dockerfiles-public

A collection of Dockerfiles created by me; with a wide variety of purposes and functionality.

I've added a README file for every folder, so you can browse through to see the purpose of each container.

This is a public snapshot of my original, private repository; which is still under active development.

## Contents

Includes 2 major (meaning used by a lot of other containers in this repo) base containers for GUI applications:
* ubuntu/x11: Eclipse Che-ready container with vnc, novnc, and rdp access; with programs like Atom and Chromium.
  * Other containers based off of this container add a programming language, its related tools, and an IDE for it.
    * There are such containers for C/C++, Python, Javascript, and Java.
    * There are more containers that extend one of the languge-based containers with a major library/SDK/IDE etc.
      * Such as Android/Kotlin (Java) and SFML (C++)
  * These containers are meant to be used as portable development environments.
    * They allow for convenient use of full IDEs in a clean; dedicated operating system.
    * Connect via a VNC/RDP connection or a web browser (visiting a page created by NoVNC.)
    * They don't drain the battery or tax the hardware of the thin client device; the server hardware will be faster in almost all cases.
    * Negligible latency; suitable for developing games and other programs where latency is important during testing.
    * Hardware accelerateable; with KVM and Cuda support.
    * Uniform experience regardless of client hardware.
      * No-compromises development on Chromebooks without needing to install linux applications or enable developer mode.
      * Very usable on phones; especially when pairing VNC or XRDP with a guacamole stack.
      * VNC, XRDP, and NoVNC all resize the host desktop automatically when the client window changes size/shape. (NoVNC needs an option to be selected in the client-side site.)
    * Kept up to date with autobuilding containers.
    * Tailored for (optional) use with Eclipse Che, which provides a web portal for starting docker containers to use as workspaces; and has its own IDE.
    * A new VNC/RDP/NoVNC password is generated when the container starts, and is echoed to the user whenever they start one of those services.
* other/base/(arch/ubuntu):
  * Relatively minimal base for making GUI applications accessible via VNC; and securely through the web when paired with Guacamole.
    * Has containers for calibre, digikam, filezilla, google_music_manager, quassel, and virt-manager. (also WIP crashplan)
  * Has base containers for both Arch Linux and Ubuntu; for the widest possible package support, and the choice between stabile and cutting-edge versions.
    * Access to the AUR also trivializes the setup for many applications; thus further simplifying maintenance.
  * Supports automatically resizing the server desktop when the client window changes size/shape.
  * Runs i3 with sane defaults and powerful customization options.
    * Config file is a miniscule fraction of the Openbox config for a similar setup.
  * Pre-setup scripts for updating applications and launching the primary GUI application; very easy to extend.
  * Use mounted /config folders to persist all settings across the containers' destruction.

Contains various containers for syncing or serving files; like:
* alpine/sshd
* alpine/gdrive
* alpine/samba
* ubuntu/onedrive

Contains an Arch Linux base container useful for testing AUR applications on a fresh setup; aiding debugging.

And many more!

## Misc Notes

make_dockerfiles.sh is used to generate multiple versions of dockerfiles; allowing me to, for example, have multiple chains of container tags based on different versions of Ubuntu, including Ubuntu+Cuda; without and code duplication in the files that I actually edit.
