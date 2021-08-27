#!/bin/bash

[ -z $1 ] && echo "No package selected. Exiting..." && exit 1

# Install python-nautilus
echo "Installing Python bindings for Nautilus..."
# define package mananger options
if type "pacman" > /dev/null 2>&1; then
    pkgmgr="pacman"
    update="-Sy"
    upgrade="-Syu"
    install="-S"
    check_install="-Qi"
    package_name="python-nautilus"
elif type "apt-get" > /dev/null 2>&1; then
    pkgmgr="apt-get"
    update="update"
    upgrade="upgrade"
    install="install"
    check_install="list --installed -qq"
    package_name="python-nautilus"
    # make sure you have the right package name for ubuntu
    [ -z `apt-cache search -n $package_name` ] && package_name="python3-nautilus"

    elif type "dnf" > /dev/null 2>&1; then
    pkgmgr="dnf"
    update="check-update"
    upgrade="upgrade"
    install="install"
    check_install="list --installed"
    package_name="nautilus-python"
else
    echo "Distribution package manager not supported yet"
    exit 1
fi

# synchronizing package databases
sudo $pkgmgr $update
# check if package is installed
$pkgmgr $check_install $package_name &> /dev/null
if [ `echo $?` -eq 1 ]; then
    sudo $pkgmgr $install $package_name
    [ `echo $?` -eq 1 ] 
else
    echo "Python bindings package already installed"
fi

# setup extesions folder
mkdir -p ~/.local/share/nautilus-python/extensions

case $1 in
    "code")
        echo "Installing VS Code Nautilus Extension"
        extension="code"
        ;;
    "code-insiders")
        echo "Installing VS Code Insiders Nautilus Extension"
        extension="code-insiders"
        ;;
    "sublime-text")
        echo "Installing Sublime Text Nautilus Extension"
        extension="sublime-text"
        ;;
    *)
        echo "Unknown application. Exiting"
        exit 1
        ;;
esac

# Remove previous version and setup folder
echo "Removing previous version (if found)..."
rm -f ~/.local/share/nautilus-python/extensions/$extension-nautilus.py

# Download and install the extension
echo "Downloading newest version..."
wget --show-progress -q -O ~/.local/share/nautilus-python/extensions/$extension-nautilus.py https://raw.githubusercontent.com/anujdatar/code-nautilus/master/$extension-nautilus.py

# Restart nautilus
echo "Restarting nautilus..."
nautilus -q

echo "Installation Complete"
