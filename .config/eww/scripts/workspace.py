#!/bin/python3
from hyprpy import Hyprland
import sys
import json

ws_icons = [" ",
            " ",
            " ",
            "󰈎 ",
            " ",
            "󰞍 ",
            "󰊗 ",
            ""]

instance = Hyprland()

sys.stdout.reconfigure(encoding='utf-8', errors='surrogateescape')

def callback_workspace(sender, **kwargs):
    workspace_changed()

def workspace_changed():
    hypr_monitors   = instance.get_monitors()
    # hypr_workspaces = instance.get_workspaces()
    monitors = []

    for monitor in hypr_monitors:
        monitor_ws = {}
        monitor_ws["monitorID"] = monitor.id
        monitor_ws["focused"]   = f'{ws_icons[monitor.active_workspace_id-1]}'
        monitor_ws["workspaces"] = []

        # for workspace in hypr_workspaces:
        for i in range(len(ws_icons)):
            print(i)
            workspace = instance.get_workspace_by_id(i+1)

            if (workspace.id == monitor.active_workspace_id):
                continue
            ws = {}
            ws["id"] = workspace.id
            ws["name"] = ws_icons[workspace.id-1]

            if (workspace.window_count == 0):
                ws["status"] = "workspaceInactive"
            elif (workspace.monitor_name == monitor.name):
                ws["status"] = "workspaceActive"
            else:
                ws["status"] = "workspaceOther"

            monitor_ws["workspaces"].append(ws)
        monitors.append(monitor_ws)

    sys.stdout.write(json.dumps(monitors) + "\n")
    sys.stdout.flush()


workspace_changed()
instance.signals.workspace.connect(callback_workspace)
instance.watch()
