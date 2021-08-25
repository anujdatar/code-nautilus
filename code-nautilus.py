# VSCode Nautilus Extension
#
# Place me in ~/.local/share/nautilus-python/extensions/,
# ensure you have python-nautilus package, restrart Nautilus, and enjoy :)
#
# This script was written by cra0zy and is released to the public domain

from gi import require_version
require_version('Gtk', '3.0')
require_version('Nautilus', '3.0')
from gi.repository import Nautilus, GObject
from subprocess import call
import os

# path to application binary or shortcut
app_exec = 'code'

# what name do you want to see in the context menu?
app_name = 'VS Code'
menu_item_name = app_name.replace(" ", "")

# always create new window?
NEWWINDOW = False


class VSCodeExtension(GObject.GObject, Nautilus.MenuProvider):

    def launch_app(self, menu, files):
        safepaths = ''
        args = ''

        for file in files:
            filepath = file.get_location().get_path()
            safepaths += '"' + filepath + '" '

            # If one of the files we are trying to open is a folder
            # create a new instance of application
            if os.path.isdir(filepath) and os.path.exists(filepath):
                args = '--new-window '

        if NEWWINDOW:
            args = '--new-window '

        call(app_exec + ' ' + args + safepaths + '&', shell=True)

    def get_file_items(self, window, files):
        item = Nautilus.MenuItem(
            name=menu_item_name + 'Open',
            label='Open in ' + app_name,
            tip='Opens the selected files in ' + app_name
        )
        item.connect('activate', self.launch_app, files)

        return [item]

    def get_background_items(self, window, file_):
        item = Nautilus.MenuItem(
            name=menu_item_name + 'OpenBackground',
            label='Open in ' + app_name,
            tip='Opens current directory in ' + app_name
        )
        item.connect('activate', self.launch_app, [file_])

        return [item]
