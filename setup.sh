#!/bin/bash
# Simple setup.sh for configuring Ubuntu 16.04 LTS
# for headless setup. 
#
# Updated 4/22/2017
#
# Install nvm: node-version manager
# https://github.com/creationix/nvm

# install
if [ "$1" == 'install' ]; then
    echo "Installing required packages..."
    sudo apt-get install -y git
    sudo apt-get install -y curl
    sudo apt-get install -y tmux

    #################################
    # TODO: Update this
    #curl https://raw.github.com/creationix/nvm/master/install.sh | sh

    # Load nvm and install latest production node
    #source $HOME/.nvm/nvm.sh
    #nvm install v0.10.12
    #nvm use v0.10.12

    # Install jshint to allow checking of JS code within emacs
    # http://jshint.com/
    #npm install -g jshint

    # Install rlwrap to provide libreadline features with node
    # See: http://nodejs.org/api/repl.html#repl_repl
    #sudo apt-get install -y rlwrap

    # Install Heroku toolbelt
    # https://toolbelt.heroku.com/debian
    # wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh
    ##################################
      
    # Install emacs25
    # sudo add-apt-repository ppa:kelleyk/emacs
    sudo add-apt-repository ppa:kelleyk/emacs
    sudo apt-get -qq update
    sudo apt-get install -y emacs25-nox emacs25-el
fi

# git pull and install dotfiles as well
echo "Setting up environment..."
cd $HOME
if [ -d ./envconfig/ ]; then
    mv envconfig  envconfig.old
fi
if [ -d .emacs.d/ ]; then
    mv .emacs.d .emacs.d~
fi
git clone https://github.com/Manca/envconfig.git
ln -sf envconfig/.screenrc .
ln -sf envconfig/.bash_profile .
ln -sf envconfig/.bashrc .
ln -sf envconfig/.bashrc_custom .
ln -sf envconfig/.emacs.d .
ln -sf envconfig/.gitconfig .
ln -sf envconfig/.tmux.conf .
echo "Done."
