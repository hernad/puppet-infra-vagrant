#!/bin/bash

mkdir -p /vagrant/certs

puppet cert generate foreman.localdomain
puppet cert generate puppetdb.localdomain
puppet cert generate empty.localdomain


cp /var/lib/puppet/ssl/certs/ca.pem /vagrant/certs/ca.pem
cp /var/lib/puppet/ssl/certs/foreman.localdomain.pem /vagrant/certs/foreman.localdomain.crt
cp /var/lib/puppet/ssl/certs/puppetdb.localdomain.pem /vagrant/certs/puppetdb.localdomain.crt
cp /var/lib/puppet/ssl/certs/empty.localdomain.pem /vagrant/certs/empty.localdomain.crt

cp /var/lib/puppet/ssl/private_keys/foreman.localdomain.pem /vagrant/certs/foreman.localdomain.key
cp /var/lib/puppet/ssl/private_keys/puppetdb.localdomain.pem /vagrant/certs/puppetdb.localdomain.key
cp /var/lib/puppet/ssl/private_keys/empty.localdomain.pem /vagrant/certs/empty.localdomain.key
