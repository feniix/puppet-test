#!/bin/bash -e

echo "Sudo is asking you for your password"
wget http://apt.puppetlabs.com/puppetlabs-release-precise.deb
sudo dpkg -i puppetlabs-release-precise.deb
sudo apt-get update
sudo apt-get install -y git puppet=3.1.1-1puppetlabs1 puppet-common=3.1.1-1puppetlabs1 rubygems
