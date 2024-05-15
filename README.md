# code-nautilus

This repo provides an extension for Nautilus that lets you open files or folders in applications.

Allows you to add Nautilus context menu options to open files and folders in
VS Code, VS Code Insiders and Sublime text, and now folders in Alacritty. It is
extensible to other applications as well. Examples for all four are included in the `examples`
folder.

It is fork of an extension of the same name by [harry-cpp](https://github.com/harry-cpp),
[code-nautilus](https://github.com/harry-cpp/code-nautilus). I have made several changes
to add different apps with minimal effort, making this branch incompatible with the original
repository. Check the `master` branch or original repository for original code.

## Install VSCode Extension

```bash
wget -qO- https://raw.githubusercontent.com/anujdatar/code-nautilus/main/install.sh | bash -s "code"
```

## Install VSCode-Insiders Extension

```bash
wget -qO- https://raw.githubusercontent.com/anujdatar/code-nautilus/main/install.sh | bash -s "code-insiders"
```

## Install Sublime Text Extension

```bash
wget -qO- https://raw.githubusercontent.com/anujdatar/code-nautilus/main/install.sh | bash -s "sublime-text"
```

## Install Alacritty Extension

For Alacritty, please see the example, don't use the auto installer, there are some extra
customizations because of the application.

- New window is always true
- And extension should not show options if you right-click on a file, but should show if you right-click on folder

## Uninstall Extension

```
rm -f ~/.local/share/nautilus-python/extensions/open_with_code.py
rm -f ~/.local/share/nautilus-python/extensions/open_with_code-insiders.py
rm -f ~/.local/share/nautilus-python/extensions/open_with_subl.py
rm -f ~/.local/share/nautilus-python/extensions/open_with_alacritty.py
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
