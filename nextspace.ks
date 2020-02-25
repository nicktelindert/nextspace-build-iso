lang en_US.UTF-8
firewall --disabled
keyboard us
timezone US/Eastern
auth --useshadow --passalgo=sha512
selinux --disabled
rootpw --plaintext root
url --url=http://ftp.tudelft.nl/centos.org/7.7.1908/os/x86_64/
repo --name=centos-7 --mirrorlist=http://mirrorlist.centos.org/?release=7&repo=os&arch=x86_64
network --bootproto=dhcp --onboot=on --activate
shutdown
bootloader --location=mbr
zerombr
clearpart --all
part / --fstype=ext4 --size=2500
part /boot --fstype=ext4 --size=500
part /boot/efi --fstype=vfat --size=200

%post
cat /dev/null > /etc/fstab
passwd -d root > /dev/null

# /etc/hosts
cat << EOF > ${fsdir}/etc/hosts
127.0.0.1	localhost localhost.localdomain nextspace.local
EOF

# hostname
cat << EOF > /etc/sysconfig/network
NETWORKING=yes
HOSTNAME=nextspace.local
NETWORKWAIT=1
EOF

yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

yum -y update

yum -y install pulseaudio

yum -y install https://github.com/trunkmaster/nextspace/releases/download/0.85/libdispatch-1.3.1121-3.el7.x86_64.rpm

yum -y install https://github.com/trunkmaster/nextspace/releases/download/0.85/libobjc2-2.0-3.el7.x86_64.rpm

yum -y install https://github.com/trunkmaster/nextspace/releases/download/0.85/nextspace-core-0.95-8.el7.x86_64.rpm

yum -y install https://github.com/trunkmaster/nextspace/releases/download/0.85/nextspace-gnustep-1.26.0_0.25.0-2.el7.x86_64.rpm

yum -y install https://github.com/trunkmaster/nextspace/releases/download/0.85/nextspace-frameworks-0.85-2.el7.x86_64.rpm

yum -y install https://github.com/trunkmaster/nextspace/releases/download/0.85/nextspace-applications-0.85-3.el7.x86_64.rpm

/sbin/adduser -b /Users -s /bin/zsh -G audio nextspace
/sbin/usermod -a -G wheel,cdrom nextspace
passwd -d nextspace > /dev/null
%end

%packages
@core
dracut-live
kernel
grub2
grub2-efi
efibootmgr
memtest86+
shim
syslinux
-dracut-config-rescue
%end

