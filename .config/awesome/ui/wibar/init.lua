local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local cal   = require("ui.widgets.calendar")

local bar_font = "UbuntuMono Nerd Font Bold 15"

-- Create keyboard layout widget
local function keyboardlayout_with_font(font)
    local result = awful.widget.keyboardlayout()
    result.widget.font = font
    return result
end

local keyboard_layout = wibox.widget {
  font = bar_font,
  {
    {
      widget = keyboardlayout_with_font(bar_font)
    },
    widget = wibox.container.background
  },
  widget = wibox.container.margin
}

-------------------------
-- Create audio widget
-------------------------
local audio_widget = wibox.widget{
  font = bar_font,
  fg = "#FFFFFF",
  widget = wibox.widget.textbox
}

awful.spawn.easy_async("/home/markos/.config/sh/sound_control.sh", function(stdout)
  audio_widget:set_text(stdout)
end)

audio_widget:connect_signal("button::press", function(c)
  awful.spawn("/home/markos/.config/sh/sound_control.sh")
end)

-------------------------
-------------------------

-------------------------
-- Create callendar widget
-------------------------

-- Create a textclock widget
local calendar_widget = wibox.widget{
  font = bar_font,
  fg = "#FF0000",
  widget = wibox.widget.textclock('|  %a %b %d', 15)
}

local cw = cal()

calendar_widget:connect_signal("button::press",
    function(_, _, _, button)
        if button == 1 then cw.toggle() end
    end)

-------------------------
-- Create clock widget
-------------------------
local textclock = wibox.widget{
  font = bar_font,
  fg = "#FF0000",
  widget = wibox.widget.textclock(' |  %H:%M ', 15)
}

-- Create taglist widget
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

-- Create tasklist widget
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

awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  --set_wallpaper(s)
  --
  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gears.table.join(
    awful.button({ }, 1, function () awful.layout.inc( 1) end),
    awful.button({ }, 3, function () awful.layout.inc(-1) end),
    awful.button({ }, 4, function () awful.layout.inc( 1) end),
    awful.button({ }, 5, function () awful.layout.inc(-1) end)))
  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen  = s,
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
  s.mytasklist = awful.widget.tasklist {
    screen  = s,
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

  -- Create the wibox
  s.mywibox = awful.wibar({
    position = "top",
    ontop = false,
    screen = s,
    height = 23,
    bg = '#000000',
    opacity = 0.8
  })


  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      s.mytaglist,
      s.mypromptbox,
    },
    s.mytasklist, -- Middle widget
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      -- BAT0,
      keyboard_layout,
      audio_widget,
      -- mybatterywidget,
      wibox.widget.systray(),
      calendar_widget,
      textclock,
      s.mylayoutbox,
    },
  }
end)
