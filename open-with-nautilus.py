# APP_TITLE Nautilus Extension
#
# Place me in ~/.local/share/nautilus-python/extensions/,
# ensure you have python-nautilus package, restart Nautilus, and enjoy :)
#
# This script is released to the public domain.

from gi.repository import Nautilus, GObject
from subprocess import call
import os

# path to application executable
APP_EXEC = 'MY_CUSTOM_APP_EXEC'

# what name do you want to see in the context menu?
APP_NAME = 'MY_CUSTOM_APP_NAME'
MENU_ITEM_NAME = APP_NAME.replace(" ", "")

# always create new window?
NEWWINDOW = False


class MY_EXTENSION_CLASS_NAME(GObject.GObject, Nautilus.MenuProvider):

    def launch_application(self, menu, files):
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

        call(APP_EXEC + ' ' + args + safepaths + '&', shell=True)

    def get_file_items(self, *args):
        files = args[-1]
        item = Nautilus.MenuItem(
            name=f'{MENU_ITEM_NAME}Open',
            label=f'Open in {APP_NAME}',
            tip=f'Opens the selected files with {APP_NAME}'
        )
        item.connect('activate', self.launch_application, files)

        return [item]

    def get_background_items(self, *args):
        file_ = args[-1]
        item = Nautilus.MenuItem(
            name=f'{MENU_ITEM_NAME}OpenBackground',
            label=f'Open in {APP_NAME}',
            tip=f'Opens the current directory in {APP_NAME}'
        )
        item.connect('activate', self.launch_application, [file_])

        return [item]
