#!/usr/bin/env sh

# setup default home file system

rm -rf ~/*

mkdir -p ~/bin
mkdir -p ~/Repos
mkdir -p ~/org
mkdir ~/Pictures
mkdir ~/Movies
mkdir ~/tmp
mkdir ~/Downloads
mkdir ~/Documents
mkdir ~/Music

# package list string
# assumes git are already installed
sudo pacman -Syu git yay
# kitty
packages="$packages kitty"

#emacs
packages="$packages emacs-nativecomp"

# fish
packages="$packages fish"

# cli utilities
packages="$packages zoxide bat exa fd fzf ripgrep tldr pay-respects-bin tokei gh zotify-git gum"

# firefoxing
packages="$packages firefox-developer-edition firefox-dark-reader firefox-ublock-origin"

# install packages
sudo yay -S $packages

# doom
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install

# ohmyfish
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
