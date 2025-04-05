#!/bin/python3

from hyprpy import Hyprland

instance = Hyprland()

def find_next_monitor():
    monitors = instance.get_monitors()
    target   = -1

    for monitor in monitors:
        if monitor.is_focused:
            target = monitor.id + 1

    if (target == len(monitors)):
        target = 0

    return target

def focus_monitor(target):
    instance.dispatch(['focusmonitor', f'{target}'])


def main():
    target = find_next_monitor()
    focus_monitor(target)

if __name__ == "__main__":
    main()
