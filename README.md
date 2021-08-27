# code-nautilus

This repo provides a **Open With** extensions for Nautilus.

Scripts for VS Code, VS Code Insiders, and Sublime Text Work at the moment.


## Install Extension Using the Script

The script currently works on Arch (`pacman`), Ubuntu/Debian (`apt`), Fedora (`dnf`). For other systems please check the manual installation section.

for VS Code
```sh
wget -qO- https://raw.githubusercontent.com/anujdatar/code-nautilus/master/install.sh | bash -s "code"
```

for VS Code Insiders
```sh
wget -qO- https://raw.githubusercontent.com/anujdatar/code-nautilus/master/install.sh | bash -s "code-insiders"
```

for Sublime Text
```sh
wget -qO- https://raw.githubusercontent.com/anujdatar/code-nautilus/master/install.sh | bash -s "sublime-text"
```

## Manual Installaion
1. This extension set depends on Python bindings for Nautilus. They are generally called `python-nautilus` on Arch based systems, `python-nautilus` or `python3-nautilus` on Ubuntu/Debian, and `nautilus-python` on Fedora. If the script installation fails, figure out what it is called on your distribution and install.

2. Create folder for the scripts
  ```sh
  mkdir -p ~/.local/share/nautilus-python/extension
  ```

3. Manually download and copy the extension's python file into this folder
  ```sh
  wget --show-progress -q -O ~/.local/share/nautilus-python/extensions/<extension_name>.py https://raw.githubusercontent.com/anujdatar/code-nautilus/master/<extension_name>.py

  ```

## Uninstall Extension

for VS Code
```sh
rm -f ~/.local/share/nautilus-python/extensions/code-nautilus.py
```

for VS Code Insiders
```sh
rm -f ~/.local/share/nautilus-python/extensions/code-insiders-nautilus.py
```

for Sublime Text
```sh
rm -f ~/.local/share/nautilus-python/extensions/sublime-text-nautilus.py
```

## HOW TO: Making your own script
Pick any of the existing scripts and edit the following to use with your application
```python
# line 19, the application binary or executable's name that is used in terminal
app_exec = 'code'

# line 22, the name you would like to show up in the right click context menu
app_name = 'VS Code'

# line 29, the class name (VSCodeExtension), it can be anything.
# as long as it does not clash with the class name of another extension.
# do not change the parameters
class VSCodeExtension(GObject.GObject, Nautilus.MenuProvider):
```

An example for say **Sublime Merge**

```python
# line 19
app_exec = 'smerge'

# line 22
app_name = 'Sublime Merge'

# line 29
class SublimeMergeExtension(GObject.GObject, Nautilus.MenuProvider):
```
