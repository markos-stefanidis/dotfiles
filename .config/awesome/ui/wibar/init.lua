local gears     = require("gears")
local awful     = require("awful")
local wibox     = require("wibox")
local cal       = require("ui.widgets.calendar")
local layout    = require("ui.widgets.layout")
local beautiful = require("beautiful")

local bar_font = "UbuntuMono Nerd Font Bold 15"

-- Create keyboard layout widget
local function keyboardlayout_with_font(font)
    local result = awful.widget.keyboardlayout()
    result.widget.font = font
    return result
end

local keyboard_widget = wibox.widget {
  font = bar_font,
  {
    {
      widget = keyboardlayout_with_font(bar_font)
    },
    widget = wibox.container.background
  },
  widget = wibox.container.margin
}

local keyboard_container = wibox.widget {
  keyboard_widget,
  bg    = beautiful.black,
  shape = gears.shape.rounded_bar,
  widget = wibox.container.background
}


-------------------------
-- Create audio widget
-------------------------
local audio_widget = wibox.widget{
  widget = wibox.widget.textbox,
  headphones = 1,
  forced_width = 40,
  halign = "center",
  markup = " "
}

audio_widget:connect_signal("button::press", function()
  awful.spawn.easy_async("/home/markos/.config/sh/sound_control.sh", function(stdout)
  if audio_widget.headphones == 1 then
    audio_widget.headphones = 0
    audio_widget.markup = " "
  else
    audio_widget.headphones = 1
    audio_widget.markup = " "
  end
    -- local whatisgoingon = (stdout == "1")
    -- -- if audio_widget.headphones == 1 then
    -- --   audio_widget.text = " "
    -- --   awful.spawn('dunstify "That is stdout" 1 ')
    -- --   audio_widget.headphones = 2
    -- -- else
    -- --   awful.spawn('dunstify "That is stdout" 2 ')
    -- --   audio_widget.text = "墳 "
    -- --   audio_widget.headphones = 1
    -- -- end
    -- if whatisgoingon then
    --   awful.spawn('dunstify "That is stdout" ' .. stdout)
    -- else
    --   awful.spawn('dunstify "That is not stdout" ' .. stdout)
    -- end
  end)
end)

local audio_container = wibox.widget {
  audio_widget,
  bg    = beautiful.black,
  shape = gears.shape.rounded_bar,
  widget = wibox.container.background
}

-------------------------
-- Create a seperator
-------------------------
local seperator = wibox.widget{
  widget = wibox.widget.textbox,
  text = "  " ,
  font = beautiful.bar_font
};

-------------------------
-- Create callendar widget
-------------------------

-- Create a textclock widget
local calendar_widget = wibox.widget{
  font = beautiful.bar_font,
  fg_color = beautiful.fg_normal,
  widget = wibox.widget.textclock('   %a %b %d ', 15)
}

local cw = cal()
local calendar_active = false

calendar_widget:connect_signal("button::press",
    function(_, _, _, button)
        if button == 1 then calendar_active = not calendar_active end
    end)

calendar_widget:connect_signal("mouse::enter", function()
  cw.show()
end)

calendar_widget:connect_signal("mouse::leave", function()
  if not calendar_active then
    cw.hide()
  end
end)

local calendar_container = wibox.widget {
  calendar_widget,
  bg    = beautiful.black,
  shape = gears.shape.rounded_bar,
  widget = wibox.container.background
}

-------------------------
-- Create clock widget
-------------------------

-- local uptime
local update_int = 120
local uptime_cmd = [[ sh -c "echo $(awk '{print $1}' /proc/uptime) / 60 | bc" ]]

local time_bar = wibox.widget{
  {
    text = "",
    widget = wibox.widget.textbox,
  },
  thickness = 3,
  bg = beautiful.fg_normal,
  colors = {beautiful.green},
  forced_width  = 28,
  max_value = 40,
  min_value = 0,
  widget = wibox.container.arcchart
}

local update_uptime = function(uptime)
  local alert = false
  if (uptime < 40) then
    time_bar.value = uptime
  elseif (uptime < 50) then
    time_bar.max_value = 50
    time_bar.min_value = 40
    time_bar.bg = beautiful.green
    time_bar.colors = {beautiful.red}
    time_bar.value = uptime
  else
    if (alert) then
      time_bar.colors = {beautiful.green}
      alert = false
    else
      time_bar.colors = {beautiful.red}
      alert = true
    end
  end
end

awful.widget.watch(uptime_cmd, update_int, function(_, stdout)
  local uptime = tonumber(stdout)
  update_uptime(uptime)
end)

local textclock = wibox.widget{
  font = bar_font,
  widget = wibox.widget.textclock(' %H:%M ', 15)
}

local function rounded_shape(size)
  return function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, size)
  end
end

local radius = 8

local uptime_widget = wibox.widget {
  markup = "",
  font = beautiful.bar_font,
  halign = "center",
  valign = "center",
  widget = wibox.widget.textbox,
}


local clock_popup = awful.popup {
  ontop = true,
  visible = false,
  shape = rounded_shape(radius),
  offset = { y = 5 },
  border_width = 2,
  border_color = beautiful.light_white,
  opacity = 0.7,
  bg = beautiful.background,
  widget = uptime_widget
}

local clock_widget = wibox.widget{
  time_bar,
  textclock,
  layout = wibox.layout.fixed.horizontal

}

clock_widget:connect_signal("mouse::enter", function()
  awful.placement.top_right(clock_popup, { margins = { top = 40, right = 10 }, parent = awful.screen.focused() })
  awful.spawn.easy_async([[
    sh -c 'uptime -p | cut -d " " -f2-'
  ]], function(stdout)
    uptime_widget.markup = " Uptime: " .. stdout .. " "
  end)
  clock_popup.visible = true
end)

clock_widget:connect_signal("mouse::leave", function()
  clock_popup.visible = false
end)


local clock_container = wibox.widget{
  clock_widget,
  bg    = beautiful.black,
  shape = gears.shape.rounded_bar,
  widget = wibox.container.background
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

function custom_shape(cr, width, height)
  gears.shape.rounded_rect(cr, width, height, 15)
end

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
  end)
)

awful.screen.connect_for_each_screen(function(s)
  s.mylayoutbox = layout(s)
  s.mylayoutbox:buttons(gears.table.join(
    awful.button({ }, 1, function () awful.layout.inc( 1) end),
    awful.button({ }, 3, function () awful.layout.inc(-1) end),
    awful.button({ }, 4, function () awful.layout.inc( 1) end),
    awful.button({ }, 5, function () awful.layout.inc(-1) end)))

  s.layout_place_container = wibox.widget{
    s.mylayoutbox,
    halign = "center",
    forced_width = 40,
    widget = wibox.container.place
  }

  s.layout_bg_container = wibox.widget{
    s.layout_place_container,
    shape = gears.shape.rounded_bar,
    bg = beautiful.black,
    fg = beautiful.green,
    widget = wibox.container.background
  }


  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.all,
    buttons = taglist_buttons,
    style   = {
      shape       = gears.shape.circle,
      font        = bar_font,
      bg_occupied = beautiful.background,
      bg_focus    = beautiful.green,
      fg_occupied = beautiful.fg_occupied,
      fg_empty    = beautiful.fg_empty,
      fg_focus    = beautiful.fg_focus,
    }
  }

  s.tasklist = awful.widget.tasklist {
    screen  = s,
    buttons = tasklist_buttons,
    filter  = awful.widget.tasklist.filter.currenttags,
    -- update_function = list_update,
    style   = {
      font = "UbuntuMono Nerd Font 0",
      font_focus = bar_font,
      disable_icon = false,
      disable_task_name = true,
      bg_normal   = beautiful.bg_normal ,
      bg_focus    = beautiful.bg_focus  ,
      bg_minimize = beautiful.bg_minimize ,
      bg_urgent   = beautiful.bg_urgent ,
      fg_normal   = beautiful.fg_normal ,
      fg_focus    = beautiful.white,
      fg_minimize = beautiful.fg_minimize ,
      fg_urgent   = beautiful.fg_urgent,
      shape       = gears.shape.rounded_bar,
    },
    widget_template = {
      {
        {
          {
            {
              id     = "icon_role",
              widget = wibox.widget.imagebox,
            },
            margins = 2,
            widget  = wibox.container.margin,
          },
          {
            id     = "text_role",
            widget = wibox.widget.textbox,
          },
          layout = wibox.layout.fixed.horizontal,
        },
        left  = 10,
        right = 10,
        widget = wibox.container.margin
      },
      id     = "background_role",
      widget = wibox.container.background,
    },
  }

  -- Create the wibox
  s.mywibox = awful.wibar({
    position = "top",
    shape    = custom_shape,
    screen   = s,
    -- height   = 30,
    bg       = beautiful.background,
    fg       = beautiful.foreground,
    opacity  = beautiful.opacity,
    margins  = 5,
  })

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    expand = "none",
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      s.mytaglist,
      seperator,
      s.test_wibox
    },
      s.tasklist,
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      -- BAT0,
      keyboard_container,
      audio_container,
      -- mybatterywidget,
      wibox.widget.systray(),
      calendar_container,
      clock_container,
      s.layout_bg_container,
    },
  }
end)

awesome.set_preferred_icon_size(32)
