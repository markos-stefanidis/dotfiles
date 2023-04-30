local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local calendar_widget = {}

local function worker(user_args)
  local args = user_args or {}

  local radius = args.radius or 8
  local next_month_button = args.next_month_button or 4
  local previous_month_button = args.previous_month_button or 5
  local start_sunday = args.start_sunday or false

  local styles = {}
  local function rounded_shape(size)
    return function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, size)
    end
  end

  styles.month = {
    padding = 4,
    opacity = 0.0
  }

  styles.normal = {
    opacity = 0.0,
    markup = function(t) return t end,
    shape = rounded_shape(4)
  }

  styles.focus = {
    markup = function(t) return '<b>' .. t .. '</b>' end,
    opacity = 0.0,
    shape = rounded_shape(4)
  }

  styles.weekend = {
    markup = function(t) return '<b>' .. t .. '</b>' end,
    opacity = 0.0,
    shape = rounded_shape(4)
  }

  styles.header = {
    markup = function(t) return '<b>' .. t .. '</b>' end,
  }

  styles.weekday = {
    markup = function(t) return '<b>' .. t .. '</b>' end,
  }

  local function decorate_cell(widget, flag, date)
    if flag == 'monthheader' and not styles.monthheader then
      flag = 'header'
    end

    -- highlight only today's day
    if flag == 'focus' then
      local today = os.date('*t')
      if not (today.month == date.month and today.year == date.year) then
        flag = 'normal'
      end
    end

    local props = styles[flag] or {}
    if props.markup and widget.get_text and widget.set_markup then
      widget:set_markup(props.markup(widget:get_text()))
    end
    -- Change bg color for weekends
    local ret = wibox.widget {
      {
        {
          widget,
          halign = 'center',
          widget = wibox.container.place
        },
        margins = (props.padding or 2) + (props.border_width or 0),
          widget = wibox.container.margin
        },
        shape = props.shape,
        -- shape_border_color = props.border_color or '#000000',
        shape_border_width = props.border_width or 0,
        fg = beautiful.light_white,
        border_color = beautiful.light_white,
        bg = "#00000000",
        widget = wibox.container.background
    }
    return ret
  end

  local cal = wibox.widget {
    date = os.date('*t'),
    font = "UbuntuMono Nerd Font 15",
    fn_embed = decorate_cell,
    long_weekdays = true,
    week_numbers = true,
    start_sunday = start_sunday,
    widget = wibox.widget.calendar.month
  }

  local popup = awful.popup {
    ontop = true,
    visible = false,
    shape = rounded_shape(radius),
    offset = { y = 5 },
    border_width = 2,
    border_color = beautiful.light_white,
    opacity = 0.7,
    bg = beautiful.background,
    widget = cal
  }

  popup:buttons(
    awful.util.table.join(
      awful.button({}, next_month_button, function()
        local a = cal:get_date()
        a.month = a.month + 1
        cal:set_date(nil)
        cal:set_date(a)
        popup:set_widget(cal)
      end),
      awful.button({}, previous_month_button, function()
        local a = cal:get_date()
        a.month = a.month - 1
        cal:set_date(nil)
        cal:set_date(a)
        popup:set_widget(cal)
      end)
    )
  )

  function calendar_widget.toggle()

    if popup.visible then
      -- to faster render the calendar refresh it and just hide
      cal:set_date(nil) -- the new date is not set without removing the old one
      cal:set_date(os.date('*t'))
      popup:set_widget(nil) -- just in case
      popup:set_widget(cal)
      popup.visible = not popup.visible
    else
      awful.placement.top_right(popup, { margins = { top = 30, right = 10 }, parent = awful.screen.focused() })
      popup.visible = true
    end
  end

  return calendar_widget

end

return setmetatable(calendar_widget, { __call = function(_, ...)
  return worker(...)
end })
