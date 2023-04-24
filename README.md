# code-nautilus

This repo provides a visual studio code extension for Nautilus.

Now also provides extensions for VSCode-Insiders and Sublime text. And, is extensible to other applications as well.

## Install VSCode Extension
```bash
wget -qO- https://raw.githubusercontent.com/harry-cpp/code-nautilus/master/install.sh | bash

# or

wget -qO- https://raw.githubusercontent.com/harry-cpp/code-nautilus/master/install.sh | bash -s "code"
```

## Install VSCode-Insiders Extension
```bash
wget -qO- https://raw.githubusercontent.com/harry-cpp/code-nautilus/master/install.sh | bash -s "code-insiders"
```

## Install Sublime Text Extension
```bash
wget -qO- https://raw.githubusercontent.com/harry-cpp/code-nautilus/master/install.sh | bash -s "sublime-text"
```

## Uninstall Extension

```
rm -f ~/.local/share/nautilus-python/extensions/open-with-code.py
rm -f ~/.local/share/nautilus-python/extensions/open-with-code-insiders.py
rm -f ~/.local/share/nautilus-python/extensions/open-with-subl.py
```

## Making your own extension for a different application
```python
# line 1 (optional): update "APP_TITLE"
# APP_TITLE Nautilus Extension

# line 13: update "MY_CUSTOM_APP_EXEC" with application launch command or path
APP_EXEC = 'MY_CUSTOM_APP_EXEC'

# line 16: update "MY_CUSTOM_APP_NAME" with application name
# this name will show up in the context menu in Nautilus
APP_NAME = 'MY_CUSTOM_APP_NAME'

# line 23: update "MY_EXTENSION_CLASS_NAME" with something unique, preferably related to the application
# This name must not clash with the class name of another extension.
class MY_EXTENSION_CLASS_NAME(GObject.GObject, Nautilus.MenuProvider):

```
An example for say **Sublime Merge**
```python
# line 1
# Sublime Merge Nautilus Extension

# line 13
APP_EXEC = 'smerge'

# line 16: update "MY_CUSTOM_APP_NAME" with application name
# this name will show up in the context menu in Nautilus
APP_NAME = 'Sublime Merge'

# line 23: update "MY_EXTENSION_CLASS_NAME" with something unique, preferably related to the application
# This name must not clash with the class name of another extension.
class SublimeMergeExtension(GObject.GObject, Nautilus.MenuProvider):

```
