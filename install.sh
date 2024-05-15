#!/usr/bin/env bash

# Install python-nautilus
echo "Installing python-nautilus..."
if type "pacman" > /dev/null 2>&1
then
    # check if already install, else install
    pacman -Qi python-nautilus &> /dev/null
    if [ "$?" -eq 1 ]
    then
        sudo pacman -S --noconfirm python-nautilus
    else
        echo "python-nautilus is already installed"
    fi
elif type "apt-get" > /dev/null 2>&1
then
    # Find Ubuntu python-nautilus package
    package_name="python-nautilus"
    found_package=$(apt-cache search --names-only $package_name)
    if [ -z "$found_package" ]
    then
        package_name="python3-nautilus"
    fi

    # Check if the package needs to be installed and install it
    installed=$(apt list --installed $package_name -qq 2> /dev/null)
    if [ -z "$installed" ]
    then
        sudo apt-get install -y $package_name
    else
        echo "$package_name is already installed."
    fi
elif type "dnf" > /dev/null 2>&1
then
    installed=$(dnf list --installed nautilus-python 2> /dev/null)
    if [ -z "$installed" ]
    then
        sudo dnf install -y nautilus-python
    else
        echo "nautilus-python is already installed."
    fi
else
    echo "Failed to find python-nautilus, please install it manually."
fi

# user input for selecting the open-with application
case $1 in
    "code")
        echo "Selected Open-With: VS Code"
        APP_EXEC="code"
        APP_NAME="VS Code"
        CLASS_NAME="VSCodeExtension"
        ;;
    "code-insiders")
        echo "Selected Open-With: VS Code Insiders"
        APP_EXEC="code-insiders"
        APP_NAME="VS Code Insiders"
        CLASS_NAME="VSCodeInsidersExtension"
        ;;
    "sublime-text")
        echo "Selected Open-With: Sublime Text"
        APP_EXEC="subl"
        APP_NAME="Sublime Text"
        CLASS_NAME="SublimeTextExtension"
        ;;
    *)
        echo "No application selected, defaulting to VS Code"
        APP_EXEC="code"
        APP_NAME="VS Code"
        CLASS_NAME="VSCodeExtension"
        ;;
esac
PLUGIN_FILENAME="$HOME/.local/share/nautilus-python/extensions/open_with_$APP_EXEC.py"

# setup Nautilus extensions folder
mkdir -p ~/.local/share/nautilus-python/extensions

# Remove previous version of extension
echo "Removing previous version (if found)..."
rm -f ~/.local/share/nautilus-python/extensions/VSCodeExtension.py
rm -f ~/.local/share/nautilus-python/extensions/code-nautilus.py
rm -f "$PLUGIN_FILENAME"


# Download and install the extension
echo "Downloading latest version..."
wget --show-progress -q -O "$PLUGIN_FILENAME" https://raw.githubusercontent.com/anujdatar/code-nautilus/main/open-with-nautilus.py
sed "s/APP_TITLE/$APP_NAME/g" "$PLUGIN_FILENAME" -i
sed "s/MY_CUSTOM_APP_EXEC/$APP_EXEC/g" "$PLUGIN_FILENAME" -i
sed "s/MY_CUSTOM_APP_NAME/$APP_NAME/g" "$PLUGIN_FILENAME" -i
sed "s/MY_EXTENSION_CLASS_NAME/$CLASS_NAME/g" "$PLUGIN_FILENAME" -i

# Restart nautilus
echo "Restarting nautilus..."
nautilus -q

echo "Installation Complete"
