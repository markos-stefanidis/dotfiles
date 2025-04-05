#!/bin/python3
import os
import json
import pprint

ws_icons = [" ",
            " ",
            " ",
            " ",
            "󰞍 ",
            "󰊗 ,"
            ""]

def workspaces():
    # Number of monitors
    n_monitors = os.system("hyprctl monitors | grep Monitor | wc -l")
    # Workspaces
    hyprctl_ws = os.popen("hyprctl -j workspaces").read()
    workspaces = json.loads(hyprctl_ws)
    final      = ""
    
    pprint.pp(workspaces)

    for i in range(n_monitors):




if __name__ == "__main__":
    workspaces()    
