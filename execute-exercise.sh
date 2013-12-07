#!/usr/bin/env bash -e

cd puppet
sudo puppet apply --modulepath=modules manifests/site.pp
