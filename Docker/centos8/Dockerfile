FROM centos:8
RUN rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
RUN dnf install -y https://www.elrepo.org/elrepo-release-8.el8.elrepo.noarch.rpm
RUN dnf install -y dnf-plugins-core
RUN dnf config-manager --add-repo http://mirror.1000mbps.com/centos/8.2.2004/extras/x86_64/os
RUN dnf install -y epel-release
RUN dnf install -y livecd-tools git vim
