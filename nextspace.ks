lang en_US.UTF-8
keyboard us
timezone US/Eastern
auth --useshadow --passalgo=sha512
selinux --disabled
part /boot/efi --fstype=efi --grow --maxsize 200 --size=20
part /boot --fstype ext4 --size=512
part / --size 3072

repo --name=centos-7 --mirrorlist=http://mirrorlist.centos.org/?release=7&repo=os&arch=x86_64

%packages
@base
@core
%end

%post --nochroot 
cp /etc/resolv.conf $INSTALL_ROOT/etc/resolv.conf
echo "nextspace.localdomain" > $INSTALL_ROOT/etc/hostname
%end 

%post
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

bootloader --location=partition
