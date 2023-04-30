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

beautiful.init("/home/markos/.config/awesome/theme.lua")
beautiful.font = "UbuntuMono Nerd Font 10"
require("config.keybindings")
require("config.rules")
require("config.tags")
require("ui.wibar")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
   naughty.notify({ preset = naughty.config.presets.critical,
   title = "Oops, there were errors during startup!",
   text = awesome.startup_errors })
end


-- Handle runtime errors after startup
do
   local in_error = false
   awesome.connect_signal("debug::error", function (err)
      -- Make sure we don't go into an endless error loop
      if in_error then return end
      in_error = true

      naughty.notify({ preset = naughty.config.presets.critical,
      title = "Oops, an error happened!",
      text = tostring(ierr) })
      in_error = false
   end)
end

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

-- Border color
client.connect_signal("focus", function(c) c.border_color = '#FF0000' end)
client.connect_signal("unfocus", function(c) c.border_color = '#000000' end)
-- }}}

-- Autostart
awful.spawn.with_shell("~/.config/sh/startup.sh")
-- awful.spawn.with_shell("~/.config/sh/todo.sh")
awful.spawn.with_shell("mserver")

--Gaps
beautiful.useless_gap = 4

--Menu and hotkeys fonts and size
beautiful.hotkeys_font = "UbuntuMono Nerd Font 10"
beautiful.hotkeys_description_font = "UbuntuMono Nerd Font 10"
beautiful.menu_font = "UbuntuMono Nerd Font 10"

