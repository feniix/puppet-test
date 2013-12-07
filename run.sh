#!/bin/bash -e

if [ -x install-puppet.sh ]; then
  if [ ! -f puppet-intalled.status ]; then
    ./install-puppet.sh && touch puppet-intalled.status
  fi
fi
if [ -f puppet-intalled.status ]; then
    ./execute-exercise.sh
fi
