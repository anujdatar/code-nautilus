#!/bin/bash

[ -z $1 ] && echo "No package selected. Exiting..." && exit 1

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
    echo "Please read instructions on installing extensions manually"
    exit 1
fi

echo  "Checking if Python bindings for Nautilus are installed"
$pkgmgr $check_install $package_name &> /dev/null

if [ `echo $?` -eq 1 ]; then
    echo "Synchronozing package databases"
    sudo $pkgmgr $update

    echo "Installing $package_name ..."
    sudo $pkgmgr $install $package_name
    [ `echo $?` -eq 1 ] && echo "Error Installing $package_name. Please install manually"
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

echo "Removing previous version (if found)..."
rm -f ~/.local/share/nautilus-python/extensions/$extension-nautilus.py

echo "Downloading newest version..."
wget --show-progress -q -O ~/.local/share/nautilus-python/extensions/$extension-nautilus.py https://raw.githubusercontent.com/anujdatar/code-nautilus/master/$extension-nautilus.py

echo "Restarting nautilus..."
nautilus -q

echo "Installation Complete"
