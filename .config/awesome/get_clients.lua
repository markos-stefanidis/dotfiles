local awful = require("awful")

for k,v in pairs(awful.widget.tasklist.source.all_clients()) do
  print("k: " .. k .. " v: " .. v)
end
