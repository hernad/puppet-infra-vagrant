#!/bin/bash -e

check_exe() {

 if [ -z `which $1` ]; then
     echo install, then put $1 execute in PATH !
     exit 1
 fi
 
}
check_exe packer  

echo -e "Building Centos-7 vbox ..."
if [ ! -f builds-centos7/packer-centos-7-x86_64.ovf ]; then
	packer build centos-7.json
fi


echo -e "Building Fedora 21 box..."
if [ ! -f builds-fedora/packer-fedora-21-x86_64.ovf ]; then
	packer build fedora-21.json
fi


echo -e "Building CentOS 6.6 box..."
if [ ! -f builds-centos6/packer-centos-6.6-x86_64.ovf ]; then
	packer build centos-6.6.json
fi

echo -e "Installing Puppet modules..."
check_exe librarian-puppet
librarian-puppet install > /dev/null


puppetmaster() {
 echo -e "Building Puppetmaster box..."
 if [ ! -f builds/packer-puppetmaster.box ]; then
	packer build puppetmaster.json
	vagrant init --force builds/packer-puppetmaster.box
	vagrant up
	vagrant ssh -c 'sudo /vagrant/generate_certs.sh'
	vagrant destroy --force
	vagrant box remove --force builds/packer-puppetmaster.box
	rm -f Vagrantfile
 fi
}

#echo -e "Building Foreman box..."
#if [ ! -f builds/packer-foreman.box ]; then
#	packer build foreman.json
#fi

#echo -e "Building PuppetDB box..."
#if [ ! -f builds/packer-puppetdb.box ]; then
#	packer build puppetdb.json
#fi

echo -e "Building centos-7 box..."
if [ ! -f builds/packer-centos-7-box.box ]; then
	packer build centos-7-box.json
fi


echo -e "Building centos-6 box..."
if [ ! -f builds/packer-centos-6-box.box ]; then
	packer build centos-6-box.json
fi

echo -e "Building fedora21 box..."
if [ ! -f builds/packer-fedora21.box ]; then
	packer build fedora-21-box.json
fi

echo -e "Cleaning up certificates..."
rm -f foreman.localdomain.* puppetdb.localdomain.* ca.pem
