#!/bin/python3

from hyprpy import Hyprland
import sys

instance = Hyprland()

def switch_to_workspace(ws_id, active_monitor):
    instance.dispatch(['moveworkspacetomonitor', f'{ws_id} {active_monitor}'])
    instance.dispatch(['workspace', f'{ws_id}'])

def swap_workspaces(active_monitor, passive_monitor):
    instance.dispatch(['swapactiveworkspaces', f'{active_monitor} {passive_monitor}'])

def get_monitor(ws_id):
    monitors = instance.get_monitors()
    active_monitor = -1
    passive_monitor = -1

    for monitor in monitors:
        if monitor.is_focused:
            active_monitor = monitor.id
            continue

        if monitor.active_workspace_id == ws_id:
            passive_monitor = monitor.id

    return active_monitor, passive_monitor

def move_to(ws_id):
    active_monitor, passive_monitor = get_monitor(ws_id)

    if (passive_monitor == -1):
        switch_to_workspace(ws_id, active_monitor)
        return

    swap_workspaces(active_monitor, passive_monitor)

def main():
    ws_id = int(sys.argv[1]);
    move_to(ws_id)

if __name__ == "__main__":
    main()

