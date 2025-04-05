#!/bin/python3
from hyprpy import Hyprland
import sys
import subprocess
import os
import json
import glob
import configparser

DEFAULT_ICON = "application-x-executable"

instance = Hyprland()
# UTF-8 stdou for nerdfonts
sys.stdout.reconfigure(encoding='utf-8', errors='surrogateescape')

def callback_clients(sender, **kwargs):
    get_clients()

def get_active_icon_theme():
    # Retrieve the active icon theme using geticons -U.
    try:
        result = subprocess.run(['geticons', '-U'], capture_output=True, text=True, check=True)
        return result.stdout.strip() or None
    except (subprocess.CalledProcessError, FileNotFoundError):
        return None

def find_best_icon(icon_name):
    # Find the best icon using geticons, prioritizing the active theme if possible.
    active_theme = get_active_icon_theme()
    best_match = None

    try:
        # Run geticons without specifying a theme
        result = subprocess.run(['geticons', icon_name], capture_output=True, text=True, check=True)
        icon_paths = result.stdout.strip().split('\n')
        
        for path in icon_paths:
            # If we find an icon from the active theme, return immediately
            if active_theme and f"/{active_theme}/" in path:
                return path

            # Otherwise, store the first available icon as a fallback
            if best_match is None:
                best_match = path

    except (subprocess.CalledProcessError, FileNotFoundError):
        pass

    if not best_match:
        result = subprocess.run(['geticons', DEFAULT_ICON], capture_output=True, text=True, check=True)
        icon_paths = result.stdout.strip().split('\n')
        return icon_paths[0] if icon_paths else None

    return best_match

def find_icon_name(app_class):
    desktop_dirs = [
        os.path.expanduser("~/.local/share/applications"),
        "/usr/share/applications"
    ]

    for directory in desktop_dirs:
        for desktop_file in glob.glob(os.path.join(directory, "*.desktop")):
            config = configparser.ConfigParser()
            config.read(desktop_file)

            # Check for `StartupWMClass` match or fallback to filename
            startup_class = config.get("Desktop Entry", "StartupWMClass", fallback=None)
            if startup_class == app_class or os.path.basename(desktop_file).startswith(app_class):
                return config.get("Desktop Entry", "Icon", fallback=None)

    return DEFAULT_ICON

def get_clients():
    hypr_monitors   = instance.get_monitors()
    clients = []

    for monitor in hypr_monitors:
        workspace = instance.get_workspace_by_id(monitor.active_workspace_id)
        ws_clients = [] # Clients on workspace

        for window in workspace.windows:
            print(monitor)
            client = {} # Client details
            icon_name = find_icon_name(window.initial_wm_class)

            try:
                client["active"] = instance.get_active_window().address == window.address
            except:
                client["active"] = False

            client["title"]  = window.title
            client["class"]  = window.initial_wm_class
            client["pid"]    = window.pid
            client["icon"]   = find_best_icon(icon_name)

            ws_clients.append(client)
            # pprint.pprint(ws_clients)

        clients.append(ws_clients)

    sys.stdout.write(json.dumps(clients) + "\n")
    sys.stdout.flush()


get_clients()
instance.signals.openwindow.connect(callback_clients)
instance.signals.closewindow.connect(callback_clients)
instance.signals.activewindowv2.connect(callback_clients)
# instance.signal_active_workspace_changed.connect(callback_clients)
instance.watch()
