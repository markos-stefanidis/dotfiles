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
local hotkeys_popup = require("awful.hotkeys_popup")
local sharedtags = require("sharedtags")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

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
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
--beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
-- Custom theme
beautiful.init("/home/markos/.config/awesome/theme.lua")
beautiful.font = "UbuntuMono Nerd Font 10"

-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
-- Keys
--key_Volume_Up                 =  "#115"
--key_Volume_Down               =  "#114"
key_Esc                       =  "#9"
key_F1                        =  "#67"
key_F2                        =  "#68"
key_F3                        =  "#69"
key_F4                        =  "#70"
key_F5                        =  "#71"
key_F6                        =  "#72"
key_F7                        =  "#73"
key_F8                        =  "#74"
key_F9                        =  "#75"
key_F10                       =  "#76"
key_F11                       =  "#95"
key_F12                       =  "#96"
key_Scroll_Lock               =  "#78"
key_tilda                     =  "#49"
key_1                         =  "#10"
key_2                         =  "#11"
key_3                         =  "#12"
key_4                         =  "#13"
key_5                         =  "#14"
key_6                         =  "#15"
key_7                         =  "#16"
key_8                         =  "#17"
key_9                         =  "#18"
key_0                         =  "#19"
key_dash                      =  "#20"
key_equal                     =  "#21"
key_Backspace                 =  "#22"
key_Insert                    =  "#118"
key_Home                      =  "#110"
key_Page_Up                   =  "#112"
key_Num_Lock                  =  "#77"
key_KP_slash                  =  "#106"
key_KP_star                   =  "#63"
key_KP_dash                   =  "#82"
key_Tab                       =  "#23"
key_Q                         =  "#24"
key_W                         =  "#25"
key_E                         =  "#26"
key_R                         =  "#27"
key_T                         =  "#28"
key_Y                         =  "#29"
key_U                         =  "#30"
key_I                         =  "#31"
key_O                         =  "#32"
key_P                         =  "#33"
key_open_bracket              =  "#34"
key_close_bracket             =  "#35"
key_Delete                    =  "#119"
key_End                       =  "#115"
key_Page_Down                 =  "#105"
key_KP_7                      =  "#79"
key_KP_8                      =  "#80"
key_KP_9                      =  "#81"
key_KP_plus                   =  "#86"
key_Caps_Lock                 =  "#66"
key_A                         =  "#38"
key_S                         =  "#39"
key_D                         =  "#40"
key_F                         =  "#41"
key_G                         =  "#42"
key_H                         =  "#43"
key_J                         =  "#44"
key_K                         =  "#45"
key_L                         =  "#46"
key_semicolon                 =  "#47"
key_apostrophe                =  "#48"
key_Enter                     =  "#36"
key_KP_4                      =  "#83"
key_KP_5                      =  "#84"
key_KP_6                      =  "#85"
key_Shift_Left                =  "#50"
key_Z                         =  "#52"
key_X                         =  "#53"
key_C                         =  "#54"
key_V                         =  "#55"
key_B                         =  "#56"
key_N                         =  "#57"
key_M                         =  "#58"
key_comma                     =  "#59"
key_period                    =  "#60"
key_slash                     =  "#61"
key_Shift_Right               =  "#62"
key_backslash                 =  "#51"
key_Up                        =  "#111"
key_KP_1                      =  "#87"
key_KP_2                      =  "#88"
key_KP_3                      =  "#89"
key_KP_Enter                  =  "#104"
key_Ctrl_Left                 =  "#37"
key_Alt_Left                  =  "#64"
key_Space                     =  "#65"
key_Alt_Right                 =  "#108"
key_Menu                      =  "#135"
key_Ctrl_Right                =  "#105"
key_Left                      =  "#113"
key_Down                      =  "#116"
key_Right                     =  "#114"
key_KP_0                      =  "#90"
key_KP_period                 =  "#91"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.fair,
    awful.layout.suit.max,
    awful.layout.suit.floating,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
--myawesomemenu = {
--   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
--   { "manual", terminal .. " -e man awesome" },
--   { "edit config", editor_cmd .. " " .. awesome.conffile },
--   { "restart", awesome.restart },
--   { "quit", function() awesome.quit() end },
--}

-- Create power button menu
mypowerbuttonmenu = awful.menu( {items = {{ "Shut Down" },
				  { "Reboot" },
				  { "Log Out" }
			  }
})


mypowerbuttonlauncher = awful.widget.launcher({ image = " ",
				        menu = mypowerbuttonmenu })

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }, height = 1
})



--mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
--                                    menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
--mykeyboardlayout = awful.widget.keyboardlayout()

local bar_font = "UbuntuMono Nerd Font Bold 15"

function keyboardlayout_with_font(font)
	local result = awful.widget.keyboardlayout()
	result.widget.font = font
	return result
end

--mykeyboardloayout = wibox.widget{
--	{
--		{
--			widget = keyboardlayout_with_font("UbuntuMono Nerd Font 10")
--		},
--
--		fg = "white",
--		bg = "black",
--		widget = wibox.container.background
--	},
--	bottom = 3,
--	color = "red",
--	widget = wibox.container.margin
--
--}
mykeyboardlayout = wibox.widget {
	{
		{
			widget = keyboardlayout_with_font(bar_font)
		},
		widget = wibox.container.background
	},
	widget = wibox.container.margin
}

-- {{{ Wibar
-- Create a textclock widget
--mytextclock = wibox.widget.textclock()
--mytextclock = wibox.widget.textclock('<span font="UbuntuMono Nerd Font 15"> %A %d.%m.%Y %H:%M:</span> ', 15)

mytextclock = wibox.widget{
	font = bar_font,
	fg = "#FF0000",
	widget = wibox.widget.textclock('|  %a %b %d |  %H:%M | ', 15)
}
-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

--local function set_wallpaper(s)
--    -- Wallpaper
--    if beautiful.wallpaper then
--        local wallpaper = beautiful.wallpaper
--        -- If wallpaper is a function, call it with the screen
--        if type(wallpaper) == "function" then
--            wallpaper = wallpaper(s)
--        end
--        gears.wallpaper.maximized(wallpaper, s, true)
--    end
--end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
--screen.connect_signal("property::geometry", set_wallpaper)
local tags = sharedtags({
	{name = " ", layout = awful.layout.layouts[1]},
	{name = " ", layout = awful.layout.layouts[1]},
	{name = "阮 ", layout = awful.layout.layouts[1]},
	{name = " ", layout = awful.layout.layouts[1]},
	{name = "5", layout = awful.layout.layouts[1]},
	{name = "6", layout = awful.layout.layouts[1]},
	{name = "7", layout = awful.layout.layouts[1]},
	{name = "8", layout = awful.layout.layouts[1]},
	{name = "9", layout = awful.layout.layouts[1]},
})

--awful.screen.connect_for_each_screen(function(s)
--	s.tags[4]:view_only()
--end)
--
--awful.screen.connect_for_each_screen(function(s)
--	-- Wallpaper
--	--set_wallpaper(s)
--
--	-- Each screen has its own tag table.
--	--awful.tag({ "", "", "阮", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])
--
--	-- Create a promptbox for each screen
--	--s.mypromptbox = awful.widget.prompt()
--	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
--	-- We need one layoutbox per screen.
--	mylayoutbox = awful.widget.layoutbox(s)
--	mylayoutbox:buttons(gears.table.join(
--		awful.button({ }, 1, function () awful.layout.inc( 1) end),
--		awful.button({ }, 3, function () awful.layout.inc(-1) end),
--		awful.button({ }, 4, function () awful.layout.inc( 1) end),
--		awful.button({ }, 5, function () awful.layout.inc(-1) end)))
--	-- Create a taglist widget
--	mytaglist = awful.widget.taglist {
--		screen  = s,
--		filter  = awful.widget.taglist.filter.all,
--		buttons = taglist_buttons,
--		style   = {
--			bg_occupied = '#000000',
--			bg_focus    = '#000000',
--			fg_occupied = '#7F7F7F',
--			fg_empty    = '#3F3F3F',
--			fg_focus    = '#FFFFFF',
--		}
--	}
--
--
--end)

-- Change the default tag
--function def_tag ()
--	local def_tag_dvi = tags[2]
--	sharedtags.viewonly(def_tag_dvi,2)
--end


--We need one layoutbox per screen
mylayoutbox_hdmi = awful.widget.layoutbox(1)
mylayoutbox_hdmi:buttons(gears.table.join(
	awful.button({ }, 1, function () awful.layout.inc( 1) end),
	awful.button({ }, 3, function () awful.layout.inc(-1) end),
	awful.button({ }, 4, function () awful.layout.inc( 1) end),
	awful.button({ }, 5, function () awful.layout.inc(-1) end)))

mylayoutbox_dvi = awful.widget.layoutbox(2)
mylayoutbox_dvi:buttons(gears.table.join(
	awful.button({ }, 1, function () awful.layout.inc( 1) end),
	awful.button({ }, 3, function () awful.layout.inc(-1) end),
	awful.button({ }, 4, function () awful.layout.inc( 1) end),
	awful.button({ }, 5, function () awful.layout.inc(-1) end)))

-- Create a taglist widget
mytaglist_hdmi = awful.widget.taglist {
	screen  = 1,
	filter  = awful.widget.taglist.filter.all,
	buttons = taglist_buttons,
	style   = {
		font = bar_font,
		bg_occupied = '#000000',
		bg_focus    = '#000000',
		fg_occupied = '#FFFFFF',
		fg_occupied = '#7F7F7F',
		fg_empty    = '#3F3F3F',
		fg_focus    = '#FFFFFF',
	}
}

mytaglist_dvi = awful.widget.taglist {
	screen  = 2,
	filter  = awful.widget.taglist.filter.all,
	buttons = taglist_buttons,
	style   = {
		font = bar_font,
		bg_occupied = '#000000',
		bg_focus    = '#000000',
		fg_occupied = '#7F7F7F',
		fg_empty    = '#3F3F3F',
		fg_focus    = '#FFFFFF',
	}
}
-- Create a tasklist widget

mytasklist_hdmi = awful.widget.tasklist {
	screen  = 1,
	filter  = awful.widget.tasklist.filter.currenttags,
	buttons = tasklist_buttons,
	style   = {
		font = bar_font,
		bg_normal = '#000000',
		bg_focus  = '#000000',
		bg_minimize = '#000000',
		bg_urgent = '#000000',
		fg_normal = '#7F7F7F',
		fg_focus  = '#FFFFFF',
		fg_minimize = '#3F3F3F',
		fg_urgent = '#FF0000'
	}
}

mytasklist_dvi = awful.widget.tasklist {
	screen  = 2,
	filter  = awful.widget.tasklist.filter.currenttags,
	buttons = tasklist_buttons,
	style   = {
		font = bar_font,
		bg_normal = '#000000',
		bg_focus  = '#000000',
		bg_minimize = '#000000',
		bg_urgent = '#000000',
		fg_normal = '#7F7F7F',
		fg_focus  = '#FFFFFF',
		fg_minimize = '#3F3F3F',
		fg_urgent = '#FF0000'
	}
}
-- Functio for round corners (add shape = custom_shape to bar instance)
--function custom_shape(cr,width,height)
--	gears.shape.rounded_rect(cr,width,height, 10)
--end

-- Create the wibox
mystatusbar_hdmi = awful.wibar(
	{
		visible = true,
		ontop = false,
		screen = 1,
		height = 23,
		--width = 2540,
		--x = 1290,
		--y = 5,
		bg = '#000000',
		opacity = 0.8,
	}
)

mystatusbar_dvi = awful.wibar(
	{
		visible = true,
		ontop = false,
		screen = 2,
		height = 18,
		--width = 2540,
		--x = 1290,
		--y = 5,
		bg = '#000000',
		opacity = 0.8,
	}
)
-- Add widgets to the wibox
mystatusbar_hdmi:setup {
	layout = wibox.layout.align.horizontal,
	expand = 'none',
	{ -- Left widgets
		layout = wibox.layout.fixed.horizontal,
		--mylauncher,
		mytaglist_hdmi,
		--s.mypromptbox,
	},
	-- Middle widget
	mytasklist_hdmi,

	{ -- Right widgets
		layout = wibox.layout.fixed.horizontal,
		mykeyboardlayout,
		wibox.widget.systray(),
		mytextclock,
		mylayoutbox_hdmi,
		mypowerbuttonlauncher
	},
}

mystatusbar_dvi:setup {
	layout = wibox.layout.align.horizontal,
	expand = 'none',
	{ -- Left widgets
		layout = wibox.layout.fixed.horizontal,
		--mylauncher,
		mytaglist_dvi,
		--s.mypromptbox,
	},
	-- Middle widget
	mytasklist_dvi,

	{ -- Right widgets
		layout = wibox.layout.fixed.horizontal,
		mykeyboardlayout,
		wibox.widget.systray(),
		mytextclock,
		mylayoutbox_dvi,
	},
}



-- {{{ Mouse bindings
--root.buttons(gears.table.join(
    --awful.button({ }, 3, function () mymainmenu:toggle() end)
    --awful.button({ }, 4, awful.tag.viewnext),
    --awful.button({ }, 5, awful.tag.viewprev)
--))
-- }}}

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
		kbdcfg.switch()
		awful.spawn("/home/markos/.config/bin/layout.sh")
	end,
	{description = "change keyboard layout", group = "awesome"}
	),

	--Left_Shift + Alt switches the current keyboard layout
	awful.key({ "Mod1"  }, key_Shift_Left,
	function()
		kbdcfg.switch()
		awful.spawn("/home/markos/.config/bin/layout.sh")
	end,
	{description = "change keyboard layout", group = "awesome"}
	),

	-- Volume Control
	awful.key({ modkey , }, key_U, function () awful.util.spawn("/home/markos/.config/bin/volume_control.sh -u") end),
	awful.key({ modkey,  }, key_D, function () awful.util.spawn("/home/markos/.config/bin/volume_control.sh -d") end),



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

--	awful.key({ modkey, }, key_U,
--		function()
--			local def_tag = tags[4]
--			sharedtags.viewonly(def_tag, screen[2])
--		end, { ... })

--    -- Prompt
--    awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
--              {description = "run prompt", group = "launcher"}),
--
--    awful.key({ modkey }, "x",
--              function ()
--                  awful.prompt.run {
--                    prompt       = "Run Lua code: ",
--                    textbox      = awful.screen.focused().mypromptbox.widget,
--                    exe_callback = awful.util.eval,
--                    history_path = awful.util.get_cache_dir() .. "/history_eval"
--                  }
--              end,
--              {description = "lua execute prompt", group = "awesome"}),
--    -- Menubar
--    awful.key({ modkey }, "p", function() menubar.show() end,
--              {description = "show the menubar", group = "launcher"})
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

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
--for i = 1, 9 do
--    globalkeys = gears.table.join(globalkeys,
--        -- View tag only.
--        awful.key({ modkey }, "#" .. i + 9,
--                  function ()
--                        local screen = awful.screen.focused()
--                        local tag = screen.tags[i]
--                        if tag then
--                           tag:view_only()
--                        end
--                  end,
--                  {description = "view tag #"..i, group = "tag"}),
--        -- Toggle tag display.
--        awful.key({ modkey, "Control" }, "#" .. i + 9,
--                  function ()
--                      local screen = awful.screen.focused()
--                      local tag = screen.tags[i]
--                      if tag then
--                         awful.tag.viewtoggle(tag)
--                      end
--                  end,
--                  {description = "toggle tag #" .. i, group = "tag"}),
--        -- Move client to tag.
--        awful.key({ modkey, "Shift" }, "#" .. i + 9,
--                  function ()
--                      if client.focus then
--                          local tag = client.focus.screen.tags[i]
--                          if tag then
--                              client.focus:move_to_tag(tag)
--                          end
--                     end
--                     local screen = awful.screen.focused()
--                     local tag = screen.tags[i]
--                     if tag then
--                        tag:view_only()
--                     end
--                  end,
--                  {description = "move focused client to tag #"..i, group = "tag"}),
--        -- Toggle tag on focused client.
--        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
--                  function ()
--                      if client.focus then
--                          local tag = client.focus.screen.tags[i]
--                          if tag then
--                              client.focus:toggle_tag(tag)
--                          end
--                      end
--                  end,
--                  {description = "toggle focused client on tag #" .. i, group = "tag"})
--    )
--end

-- Shared Tags Code
for i = 1, 9 do
	globalkeys = gears.table.join(globalkeys,
		-- View tag only.
		awful.key({ modkey }, "#" .. i + 9,
			function ()
				local screen = awful.screen.focused()
				local tag = tags[i]
				if tag then
					sharedtags.viewonly(tag, screen)
					sharedtags.viewonly(current_tag, next_screen)
				end
			end,
			{description = "view tag #"..i, group = "tag"}),
		-- Toggle tag display.
		awful.key({ modkey, "Control" }, "#" .. i + 9,
			function ()
				local screen = awful.screen.focused()
				local tag = tags[i]
				if tag then
					sharedtags.viewtoggle(tag, screen)
				end
			end,
			{description = "toggle tag #" .. i, group = "tag"}),
		-- Move client to tag.
		awful.key({ modkey, "Shift" }, "#" .. i + 9,
			function ()
				if client.focus then
					local tag = tags[i]
					if tag then
						client.focus:move_to_tag(tag)
					end
				end

				local screen = awful.screen.focused()
				local tag = tags[i]
				if tag then
					sharedtags.viewonly(tag, screen)
				end
			end,
			{description = "move focused client to tag #"..i, group = "tag"}),
		-- Toggle tag on focused client.
		awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
			function ()
				if client.focus then
					local tag = tags[i]
					if tag then
						client.focus:toggle_tag(tag)
					end
				end
			end,
			{description = "toggle focused client on tag #" .. i, group = "tag"})

	)
end
clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
	-- All clients will match this rule.
	{ rule = { },
		properties = { border_width = 2,
			border_color = green,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap+awful.placement.no_offscreen
	 }
	},

	-- Firefox rules
	{ rule = { class = "firefox" },
		properties = {
			tag = " "
		}

	},
	-- Spotify Rules
	--{ rule = { name = "Spotify" },
	--	properties = {
	--		tag = "阮 "
	--	}
	--},

	-- Polybar Rules
	{ rule = {class = "Polybar" },
		properties = {border_width = 0},

	},

	-- PCSX2 Rules
	{ rule = {class = "Pcsx2" },
		properties = { floating = true }

	},

	-- Floating clients.
	{ rule_any = {
		instance = {
			"DTA",  -- Firefox addon DownThemAll.
			"copyq",  -- Includes session name in class.
			"pinentry",
		},
		class = {
			"Arandr",
			"Blueman-manager",
			"Gpick",
			"Kruler",
			"MessageWin",  -- kalarm.
			"Sxiv",
			"Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
			"Wpa_gui",
			"veromix",
			"xtightvncviewer"
		},

		-- Note that the name property shown in xprop might be set slightly after creation of the client
		-- and the name shown there might not match defined rules here.
		name = {
			"Event Tester",  -- xev.
		},
		role = {
			"AlarmWindow",  -- Thunderbird's calendar.
			"ConfigManager",  -- Thunderbird's about:config.
			"pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
		}
		}, properties = { floating = true }},

	-- Add titlebars to normal clients and dialogs
	--{ rule_any = {type = { "normal", "dialog" }
	--  }, properties = { titlebars_enabled = true }
	--}

	-- Set Firefox to always map on the tag named "2" on screen 1.
	-- { rule = { class = "Firefox" },
	--   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
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

-- These functions enable title bars only when the window is floating

-- -- This is for floating windows in tiling layout
client.connect_signal("manage", function(c)
	if c.floating or c.first_tag.layout.name == "floating" then
		awful.titlebar.show(c)
	else
		awful.titlebar.hide(c)
	end
end)

-- -- This is for floating layout
tag.connect_signal("property::layout", function(t)
	local clients = t:clients()
	for k,c in pairs(clients) do
		if c.floating or c.first_tag.layout.name == "floating" then
			awful.titlebar.show(c)
		else
			awful.titlebar.hide(c)
		end
	end
end)

--Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c, {
	bg_normal = "#000000CC",
	bg_focus = "#000000CC",
	size = 20
    }) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c, {font = "UbuntuMono Nerd Font Italic 15"})
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
--client.connect_signal("mouse::enter", function(c)
--    c:emit_signal("request::activate", "mouse_enter", {raise = false})
--end)

-- Border color
client.connect_signal("focus", function(c) c.border_color = '#ffffff7f' end)
client.connect_signal("unfocus", function(c) c.border_color = '#000000' end)
-- }}}

-- Autostart
awful.spawn.with_shell("/home/markos/.config/bin/startup.sh")
awful.spawn.with_shell("/home/markos/.config/bin/todo.sh")

awful.spawn.with_shell(function()
		local def_tag = tags[3]
		local def_screen = screen[2]
		sharedtags.viewonly(def_tag, def_screen)
	end)
--awful.spawn.with_shell("/home/markos/.config/polybar/launch.sh")

--Gaps
beautiful.useless_gap = 4

--Menu and hotkeys fonts and size
beautiful.hotkeys_font = "UbuntuMono Nerd Font 10"
beautiful.hotkeys_description_font = "UbuntuMono Nerd Font 10"
beautiful.menu_font = "UbuntuMono Nerd Font 10"

--Keyboard map indicator and changer
kbdcfg = {}
kbdcfg.cmd = "setxkbmap"
kbdcfg.layout = { { "us", "" }, { "gr, us", "" } }
kbdcfg.current = 1  -- us is our default layout
kbdcfg.switch = function ()
	kbdcfg.current = kbdcfg.current % #(kbdcfg.layout) + 1
	local t = kbdcfg.layout[kbdcfg.current]
	os.execute( kbdcfg.cmd .. " " .. t[1] .. " " .. t[2] )
end
