# Kickstart script to build the NEXTSPACE livecd

In development script to build the NEXTSPACE live-cd.
Image is now installable.

## Known issues
- No gui networking tools
- No decision made on base applications yet.

## Logging in
- You can login with the live cd/usb with username nextspace and an empty password.

## Create the image based on the current kickstarter script
Run create.sh in the Docker/centos7 folder(install docker first) the image will be placed in the root of your home folder.

[GO TO THE NEXTSPACE GITHUB PAGE](https://www.github.com/trunkmaster/nextspace) credits to Trunkmaster

## Run in it in QEMU

qemu-system-x86_64 -enable-kvm -m 1G -cdrom NEXTSPACE.iso

You really need KVM to get decent performance
