#!/usr/bin/env bash

export PATH=$PATH:$HOME/.local/bin

# Powerline configuration
if [ -f $HOME/.local/lib/python3.8/site-packages/powerline/bindings/bash/powerline.sh ]; then
    $HOME/.local/bin/powerline-daemon -q
    POWERLINE_BASH_CONTINUATION=1
    POWERLINE_BASH_SELECT=1
    source $HOME/.local/lib/python3.8/site-packages/powerline/bindings/bash/powerline.sh
fi

export RSPOTIFY_CLIENT_ID="c2cf4444f53540c4912b1818723bf41d"
export RSPOTIFY_CLIENT_SECRET="f712c2e77d4d487f9421bcc5011c04f4"
