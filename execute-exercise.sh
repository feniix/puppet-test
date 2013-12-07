#!/bin/bash -e

pushd puppet
sudo puppet apply --modulepath=modules manifests/site.pp
popd
