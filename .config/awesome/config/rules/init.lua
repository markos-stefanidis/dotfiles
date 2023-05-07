local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

require("awful.autofocus")

-- Check if mouse clicks on window border
local function check_border(mx, my, cx, cy, cw, ch)
   local onborder = nil
   if my > (cy + ch - 6) then
      if mx < (cx + 30) then onborder = "bottom_left"
      elseif mx > (cx + cw -30) then onborder = "bottom_right"
      else onborder = "bottom"
      end
   elseif mx < (cx + 4) then onborder = "left"
   elseif mx > (cx + cw - 4) then onborder = "right"
   end
   return onborder
end


local clientbuttons = gears.table.join(
  awful.button({ }, 1, function (c)
     c:emit_signal("request::activate", "mouse_click", {raise = true})
     local cx, cy, cw, ch = c:geometry().x, c:geometry().y, c:geometry().width, c:geometry().height
     local mx, my = _G.mouse.coords().x, _G.mouse.coords().y
     local onborder = check_border(mx, my, cx, cy, cw, ch)
     if onborder then
        awful.mouse.client.resize(c, onborder)
     end
  end),
  awful.button({ }, 1, function (c) client.focus = c; c:raise() end),

  awful.button({ modkey }, 1, function (c)
     c:emit_signal("request::activate", "mouse_click", {raise = true})
     awful.mouse.client.move(c)
  end),
  awful.button({ modkey }, 3, function (c)
     c:emit_signal("request::activate", "mouse_click", {raise = true})
     awful.mouse.client.resize(c)
  end)
)

-- These functions enable title bars only when the window is floating

-- -- This is for floating windows in tiling layout
client.connect_signal("list", function(c)
	if c.floating or c.first_tag.layout.name == "floating" then
		awful.titlebar.show(c)
    c.border_color = beautiful.green
    c.height = 800
    c.width = 1000
    c.placement = awful.placement.no_overlap
	else
		awful.titlebar.hide(c)
    c.border_color = beautiful.light_yellow
	end
end)

-- -- This is for floating layout
tag.connect_signal("property::layout", function(t)
	local clients = t:clients()
	for k,c in pairs(clients) do
		if c.floating or c.first_tag.layout.name == "floating" then
			awful.titlebar.show(c)
        c.border_color = beautiful.green
        c.height = 800;
        c.width = 1000;
        c.placement = awful.placement.no_overlap
		else
			awful.titlebar.hide(c)
        c.border_color = beautiful.light_yellow
		end
	end
end)

client.connect_signal("focus", function(c)
   if  c.first_tag.layout.name == "floating" then
      c.border_color = beautiful.green
   else
      c.border_color = beautiful.light_yellow
   end
end)

client.connect_signal("unfocus", function(c) c.border_color = '#000000' end)

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
-- require("config.client_mng")

-- Rules to apply to new clients (through the "manage" signal).

-- local clientbuttons = awful.util.table.join(
--     awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
--     awful.button({ modkey }, 1, awful.mouse.client.move),
--     awful.button({ modkey }, 3, awful.mouse.client.resize)
-- )
awful.rules.rules = {
   -- All clients will match this rule.
   { rule = { },
      properties = {
         border_width = beautiful.border_width,
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

   -- Modelsim rules
   { rule = { class = "Vsim"},
      properties = {
         tag = "ﲋ"
      },
   },

   { rule = { name = "Transcript"},
      properties = {
         tag = "ﲋ"
      }
   },

   -- Spotify rules
   { rule = { class = "spotify"},
      properties = {
         tag =  "阮 "
      },
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

}

-- For some reason theese will only work this way
client.connect_signal("property::class", function(c)
          if c.class == "Spotify" then
                    c:move_to_tag("阮 ")
          end
end)

client.connect_signal("property::name", function(c)
   if c.name == "Wave" then
      c:move_to_tag( "ﲋ" )
   end
end)

