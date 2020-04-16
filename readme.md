# Kickstart script to build the NEXTSPACE livecd

In development script to build the NEXTSPACE live-cd.
Image is now installable.

## Known issues
- No gui networking tools
- No decision made on base applications yet.

## Logging in
- You can login with the live cd/usb with username nextspace and an empty password.

## Download generated ISO(Alpha quality):
https://drive.google.com/open?id=1s-jG79uuR0hyrexpZFo7YE1LQNNuLxGw

[GO TO THE NEXTSPACE GITHUB PAGE](https://www.github.com/trunkmaster/nextspace) credits to Trunkmaster

## Run in it in QEMU

qemu-system-x86_64 -enable-kvm -m 1G -cdrom NEXTSPACE.iso

You really need KVM to get decent performance
