local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
require("config.keybindings.keycodes")

-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = os.getenv("EDITOR") or "vim"

editor_cmd = terminal .. " -e " .. editor

-- {{{ Key bindings
globalkeys = gears.table.join(
awful.key({ modkey,           }, key_S,      hotkeys_popup.show_help,
{description="show help", group="awesome"}),
awful.key({ modkey,           }, key_Left,   awful.tag.viewprev,
{description = "view previous", group = "tag"}),
awful.key({ modkey,           }, key_Right,  awful.tag.viewnext,
{description = "view next", group = "tag"}),
awful.key({ modkey,           }, key_Esc, awful.tag.history.restore,
{description = "go back", group = "tag"}),
--Alt + Left Shift switches the current keyboard layout
awful.key({ "Shift"  }, key_Alt_Left,
function()
   -- kbdcfg.switch()
   awful.spawn("/home/markos/.config/sh/layout.sh")
end,
{description = "change keyboard layout", group = "awesome"}
),

--Left_Shift + Alt switches the current keyboard layout
awful.key({ "Mod1"  }, key_Shift_Left,
function()
   -- kbdcfg.switch()
   awful.spawn("/home/markos/.config/sh/layout.sh")
end,
{description = "change keyboard layout", group = "awesome"}
),

-- Volume Control
awful.key({}, key_Volume_Up, function () awful.util.spawn("/home/markos/.config/sh/volume_control.sh -u") end),
awful.key({}, key_Volume_Down, function () awful.util.spawn("/home/markos/.config/sh/volume_control.sh -d") end),



awful.key({ modkey,           }, key_J,
function ()
   awful.client.focus.byidx( 1)
   awful.spawn("/home/markos/.config/bin/window_notify.sh")
end,
{description = "focus next by index", group = "client"}
),

awful.key({ modkey,           }, key_K,
function ()
   awful.client.focus.byidx(-1)
   awful.spawn("/home/markos/.config/bin/window_notify.sh")
end,
{description = "focus previous by index", group = "client"}
),

awful.key({ modkey,           }, key_W, function () mymainmenu:show() end,
{description = "show main menu", group = "awesome"}),

-- Layout manipulation
awful.key({ modkey, "Shift"   }, key_J,  function () awful.client.swap.byidx(  1)    end,
{description = "swap with next client by index", group = "client"}),
awful.key({ modkey, "Shift"   }, key_K, function () awful.client.swap.byidx( -1)    end,
{description = "swap with previous client by index", group = "client"}),
--awful.key({ modkey, "Control" }, key_J, function () awful.screen.focus_relative( 1) end,
--	{description = "focus the next screen", group = "screen"}),
--awful.key({ modkey, "Control" }, key_K, function () awful.screen.focus_relative(-1) end,
--	{description = "focus the previous screen", group = "screen"}),
awful.key({ modkey,           }, key_O, function () awful.screen.focus_relative (1) end,
{description = "Focus Next Screen", group = "screen"}),

awful.key({ modkey,           }, key_U, awful.client.urgent.jumpto,
{description = "jump to urgent client", group = "client"}),
awful.key({ modkey,           }, key_Tab,
function ()
   awful.client.focus.history.previous()
   if client.focus then
      client.focus:raise()
   end
end,
{description = "go back", group = "client"}),

-- Standard program
awful.key({ modkey,           }, key_Enter, function () awful.spawn(terminal) end,
{description = "open a terminal", group = "launcher"}),
awful.key({ modkey, "Control" }, key_R, awesome.restart,
{description = "reload awesome", group = "awesome"}),
awful.key({ modkey, "Shift"   }, key_Q, awesome.quit,
{description = "quit awesome", group = "awesome"}),

awful.key({ modkey,           }, key_L,     function () awful.tag.incmwfact( 0.05)          end,
{description = "increase master width factor", group = "layout"}),
awful.key({ modkey,           }, key_H,     function () awful.tag.incmwfact(-0.05)          end,
{description = "decrease master width factor", group = "layout"}),
awful.key({ modkey, "Shift"   }, key_H,     function () awful.tag.incnmaster( 1, nil, true) end,
{description = "increase the number of master clients", group = "layout"}),
awful.key({ modkey,  "Shift"   }, key_L,     function () awful.tag.incnmaster(-1, nil, true) end,
{description = "decrease the number of master clients", group = "layout"}),
awful.key({ modkey, "Control" }, key_H,     function () awful.tag.incncol( 1, nil, true)    end,
{description = "increase the number of columns", group = "layout"}),
awful.key({ modkey, "Control" }, key_L,     function () awful.tag.incncol(-1, nil, true)    end,
{description = "decrease the number of columns", group = "layout"}),
awful.key({ modkey,           }, key_Space, function () awful.layout.inc( 1)                end,
{description = "select next", group = "layout"}),
awful.key({ modkey, "Shift"   }, key_Space, function () awful.layout.inc(-1)                end,
{description = "select previous", group = "layout"}),

awful.key({modkey, },key_R, function() awful.spawn.with_shell("rofi -show drun") end, { ...}),
awful.key({ modkey, "Control"  }, key_N,
function ()
   local c = awful.client.restore()
   -- Focus restored client
   if c then
      c:emit_signal(
      "request::activate", "key.unminimize", {raise = true}
      )
   end
   awful.spawn('/home/markos/.config/bin/window_notify.sh')
end,
{description = "restore minimized", group = "client"})
)

clientkeys = gears.table.join(
awful.key({ modkey,           }, key_F,
function (c)
   c.fullscreen = not c.fullscreen
   c:raise()
end,
{description = "toggle fullscreen", group = "client"}),
awful.key({ modkey, "Shift"  }, key_C,      function (c) c:kill()
   awful.spawn('/home/markos/.config/bin/window_notify.sh')
end,
{description = "close", group = "client"}),
awful.key({ modkey, key_Control_Left }, key_Space,  awful.client.floating.toggle                     ,
{description = "toggle floating", group = "client"}),
awful.key({ modkey, "Control" }, key_Enter, function (c) c:swap(awful.client.getmaster()) end,
{description = "move to master", group = "client"}),
-- awful.key({ modkey,           }, key_O,      function (c) c:move_to_screen()               end,
--           {description = "move to screen", group = "client"}),
awful.key({ modkey,           }, key_T,      function (c) c.ontop = not c.ontop            end,
{description = "toggle keep on top", group = "client"}),
awful.key({ modkey,           }, key_N,
function (c)
   -- The client currently has the input focus, so it cannot be
   -- minimized, since minimized clients can't have the focus.
   c.minimized = true
   awful.spawn('/home/markos/.config/bin/window_notify.sh')
end ,
{description = "minimize", group = "client"}),
awful.key({ modkey,           }, key_M,
function (c)
   c.maximized = not c.maximized
   c:raise()
end ,
{description = "(un)maximize", group = "client"}),
awful.key({ modkey, "Control" }, key_M,
function (c)
   c.maximized_vertical = not c.maximized_vertical
   c:raise()
end ,
{description = "(un)maximize vertically", group = "client"}),
awful.key({ modkey, "Shift"   }, key_M,
function (c)
   c.maximized_horizontal = not c.maximized_horizontal
   c:raise()
end ,
{description = "(un)maximize horizontally", group = "client"})
)

