lang en_US.UTF-8
firewall --disabled
keyboard us
timezone US/Eastern
auth --useshadow --passalgo=sha512
selinux --disabled
rootpw --plaintext root
repo --name=fedora-32 --url=https://fedora.mirror.wearetriple.com/linux/releases/32/Everything/x86_64/os/
%packages
@core
@x11
kernel-devel
wget
git
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
network-manager-applet
%end
%post --nochroot 
cp /etc/resolv.conf $INSTALL_ROOT/etc/resolv.conf
cp etc/default/useradd $INSTALL_ROOT/etc/default/useradd
cp etc/init.d/modgroups $INSTALL_ROOT/etc/init.d/modgroups
cp etc/rc.d/rc.local $INSTALL_ROOT/etc/rc.d/rc.local
chmod +x $INSTALL_ROOT/etc/rc.d/rc.local
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

/usr/sbin/plymouth-set-default-theme nextspace -R
ln -s /usr/NextSpace/Apps/Login.app/Resources/loginwindow.service /etc/systemd/system/multi-user.target.wants/display-manager.service
cd /tmp & wget https://github.com/trunkmaster/nextspace/releases/download/0.90/NextSpace-0.90-Fedora_31.tgz
tar zxf NextSpace-0.90-Fedora_31.tgz
cd Nextspace-0.90
./nextspace-install.sh
/sbin/useradd -b /Users -s /bin/zsh -G audio nextspace
/sbin/groupadd storage
passwd -d nextspace > /dev/null
%end
