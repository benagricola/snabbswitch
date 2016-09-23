-- Use of this source code is governed by the Apache 2.0 license; see COPYING.

module(..., package.seeall)

local pcap = require("apps.pcap.pcap")
local raw = require("apps.socket.raw")
local basic_apps = require("apps.basic.basic_apps")

function run (parameters)
   if not (#parameters == 2) then
      print("Usage: example_spray <input> <output>")
      main.exit(1)
   end
   local input = parameters[1]
   local output = parameters[2]

   local c = config.new()
   config.app(c, "capture", pcap.PcapReader, input)
   config.app(c, "repeater_app", basic_apps.Repeater)
   config.app(c, "output", raw.RawSocket, output)

   config.link(c, "capture.output -> repeater_app.input")
   config.link(c, "repeater_app.output -> output.rx")

   engine.configure(c)
   engine.main({duration=30, report = {showlinks=true}})
end