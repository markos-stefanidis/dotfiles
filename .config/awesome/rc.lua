-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
--local naughty = require("naughty")
local menubar = require("menubar")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:

beautiful.init("/home/markos/.config/awesome/ui/theme/init.lua")
require("config.keybindings")
require("config.tags")
-- require("config.rules")
require("ui.wibar")


-- Set keys
root.keys(globalkeys)
-- }}}

client.connect_signal("manage", function (c)
   -- Set the windows at the slave,
   -- i.e. put it at the end of others instead of setting it master.
   -- if not awesome.startup then awful.client.setslave(c) end

   if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
      -- Prevent clients from being unreachable after screen count changes.
      awful.placement.no_offscreen(c)
   end
end)

-- Autostart
-- awful.spawn.with_shell("~/.config/sh/startup.sh")
awful.spawn.with_shell("nitrogen --restore")
awful.spawn.with_shell("dunst")

--Menu and hotkeys fonts and size
beautiful.hotkeys_font = "UbuntuMono Nerd Font 10"
beautiful.hotkeys_description_font = "UbuntuMono Nerd Font 10"
beautiful.menu_font = "UbuntuMono Nerd Font 10"

