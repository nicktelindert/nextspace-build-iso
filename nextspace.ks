lang en_US.UTF-8
firewall --disabled
keyboard us
timezone US/Eastern
auth --useshadow --passalgo=sha512
selinux --disabled
rootpw --plaintext root
repo --name=centos-7 --mirrorlist=http://mirrorlist.centos.org/?release=7&repo=os&arch=x86_64
part / --fstype ext4 --size=3072
part /boot --fstype ext4 --size=400
part /boot/EFI --fstype efi --size=20

%post --nochroot 
cp /etc/resolv.conf $INSTALL_ROOT/etc/resolv.conf
%end

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
yum -y install vim nano indent ImageMagick inkscape gawk

yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

yum -y update

yum -y install https://github.com/trunkmaster/nextspace/releases/download/0.85/libdispatch-1.3.1121-3.el7.x86_64.rpm

yum -y install https://github.com/trunkmaster/nextspace/releases/download/0.85/libobjc2-2.0-3.el7.x86_64.rpm

yum -y install https://github.com/trunkmaster/nextspace/releases/download/0.85/nextspace-core-0.95-8.el7.x86_64.rpm

yum -y install https://github.com/trunkmaster/nextspace/releases/download/0.85/nextspace-gnustep-1.26.0_0.25.0-2.el7.x86_64.rpm

yum -y install https://github.com/trunkmaster/nextspace/releases/download/0.85/nextspace-frameworks-0.85-2.el7.x86_64.rpm

yum -y install https://github.com/trunkmaster/nextspace/releases/download/0.85/nextspace-applications-0.85-3.el7.x86_64.rpm
wget -O ~/installer.tar.gz https://github.com/nicktelindert/nextspace-build-iso/blob/master/installer.tar.gz  
tar xvf ~/installer.tar.gz -C /Applications

/sbin/adduser -b /Users -s /bin/zsh -G audio nextspace
/sbin/usermod -a -G wheel,cdrom nextspace
passwd -d nextspace > /dev/null
%end

%packages
@core
@x11
wget
anaconda
@anaconda-tools
pulseaudio
kernel
grub2-efi-modules
plymouth
efibootmgr
memtest86+
shim-x64
grub2
grub2-efi-x64-cdboot
grub2-efi-x64
syslinux
%end

