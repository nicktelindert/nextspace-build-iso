lang en_US.UTF-8
firewall --disabled
keyboard us
timezone US/Eastern
auth --useshadow --passalgo=sha512
selinux --disabled
rootpw --plaintext root
repo --name=centos-7 --mirrorlist=http://mirrorlist.centos.org/?release=7&repo=os&arch=x86_64

%post --nochroot 
cp /etc/resolv.conf $INSTALL_ROOT/etc/resolv.conf
%end

%post
cat /dev/null > /etc/fstab
passwd -d root > /dev/null

/usr/bin/systemctl disable display-manager

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
yum -y install https://rpms.remirepo.net/enterprise/remi-release-7.rpm\

yum -y install vim nano indent ImageMagick inkscape gawk

yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

yum -y localinstall --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm

yum -y update

yum -y install VirtualBox VirtualBox-guest-additions dia mpv transmission

yum -y install https://github.com/trunkmaster/nextspace/releases/download/0.85/libdispatch-1.3.1121-3.el7.x86_64.rpm

yum -y install https://github.com/trunkmaster/nextspace/releases/download/0.85/libobjc2-2.0-3.el7.x86_64.rpm

yum -y install https://github.com/trunkmaster/nextspace/releases/download/0.85/nextspace-core-0.95-8.el7.x86_64.rpm

yum -y install https://github.com/trunkmaster/nextspace/releases/download/0.85/nextspace-gnustep-1.26.0_0.25.0-2.el7.x86_64.rpm

yum -y install https://github.com/trunkmaster/nextspace/releases/download/0.85/nextspace-frameworks-0.85-2.el7.x86_64.rpm

yum -y install https://github.com/trunkmaster/nextspace/releases/download/0.85/nextspace-applications-0.85-3.el7.x86_64.rpm

wget -qO- https://raw.githubusercontent.com/nicktelindert/nextspace-build-iso/master/appwrappers.tar.gz | tar xvz -C /Applications

/sbin/adduser -b /Users -s /bin/zsh -G audio nextspace
/sbin/groupadd storage
/sbin/usermod -a -G wheel,storage nextspace
passwd -d nextspace > /dev/null
/usr/sbin/plymouth-set-default-theme nextspace
ln -s /usr/NextSpace/Apps/Login.app/Resources/loginwindow.service /etc/systemd/system/multi-user.target.wants/display-manager.service
/usr/sbin/dracut -f
%end

%packages
@core
@x11
wget
anaconda
@anaconda-tools
pulseaudio
alsa-plugins-pulseaudio
kernel
plymouth
grub2-efi-modules
efibootmgr
memtest86+
shim-x64
grub2
grub2-efi-x64-cdboot
grub2-efi-x64
syslinux
firefox
emacs
gimp
%end
