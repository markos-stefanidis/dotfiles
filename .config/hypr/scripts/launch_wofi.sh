#!/bin/bash

rm -f $HOME/.config/wofi/style.css
envsubst < $HOME/.config/wofi/style_template.css > $HOME/.config/wofi/style.css
wofi --show drun
