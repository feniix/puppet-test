#!/usr/bin/env bash -e

if [ -x install-puppet.sh ]; then
    ./install-puppet.sh && touch puppet-intalled.status
fi
if [ -f puppet-intalled.status ]; then
    ./execute-exercise.sh
fi
