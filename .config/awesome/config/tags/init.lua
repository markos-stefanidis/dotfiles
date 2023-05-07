local awful = require("awful")
local gears = require("gears")
local sharedtags = require("sharedtags")

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
   awful.layout.suit.tile,
   awful.layout.suit.fair,
   awful.layout.suit.max,
   awful.layout.suit.floating,
}

-- Declare tags
local tags = sharedtags({
   {name = " ", layout = awful.layout.layouts[1]},
   {name = " ", layout = awful.layout.layouts[1]},
   {name = " ", layout = awful.layout.layouts[1]},
   {name = " ", layout = awful.layout.layouts[1]},
   {name = "󰞍 ", layout = awful.layout.layouts[1]},
   {name = "󰊗 ", layout = awful.layout.layouts[1]},
   {name = " ", layout = awful.layout.layouts[1]}
})

-- Shared Tags Code
for i = 1, 9 do
   globalkeys = gears.table.join(globalkeys,
   -- View tag only.
   awful.key({ modkey }, "#" .. i + 9,
   function ()
      local screen = awful.screen.focused()
      local tag = tags[i]
      if tag then
         local old_screen = tag.screen
         local old_tag = screen.selected_tag
         sharedtags.viewonly(old_tag, old_screen)
         sharedtags.viewonly(tag, screen)
      else
         local old_screen = tag.screen
         local old_tag = screen.selected_tag
         sharedtags.viewonly(old_tag, old_screen)
         sharedtags.viewonly(tag, screen)
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

-- Tag Init Function
init = function ()
   sharedtags.viewonly(tags[3], screen[2])
   sharedtags.viewonly(tags[4], screen[1])
   sharedtags.viewonly(tags[5], screen[1])
   sharedtags.viewonly(tags[6], screen[1])
   sharedtags.viewonly(tags[7], screen[2])
   sharedtags.viewonly(tags[1], screen[1])
   sharedtags.viewonly(tags[2], screen[2])
end
awful.spawn.with_shell(init())
end
