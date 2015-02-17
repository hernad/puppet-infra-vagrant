#!/bin/bash

rpm --import https://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs && \
rpm --import http://download.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6 &&  \

rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm && \
rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
yum -y install puppet-3.6.2-1.el6

hostname empty.localdomain
sed -i 's/^HOSTNAME=.*$/HOSTNAME=empty.localdomain/' /etc/sysconfig/network-scripts/ifcfg-eth0
echo "127.0.0.1	empty.localdomain" >> /etc/hosts
service network restart

puppet cert list

sudo cp /tmp/empty.localdomain.crt /var/lib/puppet/ssl/certs/empty.localdomain.pem
sudo cp /tmp/empty.localdomain.key /var/lib/puppet/ssl/private_keys/empty.localdomain.pem
sudo cp /tmp/ca.pem /var/lib/puppet/ssl/certs/ca.pem