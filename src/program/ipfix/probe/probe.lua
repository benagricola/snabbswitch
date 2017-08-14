-- This module implements the `snabb flow_export` command

module(..., package.seeall)

local now      = require("core.app").now
local lib      = require("core.lib")
local link     = require("core.link")
local arp      = require("apps.ipv4.arp")
local ipfix    = require("apps.ipfix.ipfix")
local ipv4     = require("lib.protocol.ipv4")
local ethernet = require("lib.protocol.ethernet")
local numa     = require("lib.numa")

-- apps that can be used as an input or output for the exporter
in_out_apps = {}

function in_out_apps.pcap (path)
   return { input = "input",
            output = "output" },
          { require("apps.pcap.pcap").PcapReader, path }
end

function in_out_apps.raw (device)
   return { input = "rx",
            output = "tx" },
          { require("apps.socket.raw").RawSocket, device }
end

function in_out_apps.intel10g (device)
   local conf = { pciaddr = device }
   return { input = "rx",
            output = "tx" },
          { require("apps.intel.intel_app").Intel82599, conf }
end

local long_opts = {
   help = "h",
   duration = "D",
   port = "p",
   transport = 1,
   ["host-ip"] = "a",
   ["input-type"] = "i",
   ["output-type"] = "o",
   ["netflow-v9"] = 0,
   ["ipfix"] = 0,
   ["active-timeout"] = 1,
   ["idle-timeout"] = 1,
   ["cpu"] = 1
}

function run (args)
   local duration

   local input_type, output_type = "intel10g", "intel10g"

   local host_mac
   local host_ip = '10.0.0.1' -- Just to have a default.
   local collector_ip = '10.0.0.2' -- Likewise.
   local port = 4739

   local active_timeout, idle_timeout
   local ipfix_version = 10

   local cpu

   -- TODO: better input validation
   local opt = {
      h = function (arg)
         print(require("program.ipfix.probe.README_inc"))
         main.exit(0)
      end,
      D = function (arg)
         duration = assert(tonumber(arg), "expected number for duration")
      end,
      i = function (arg)
         assert(in_out_apps[arg], "unknown input type")
         input_type = arg
      end,
      o = function (arg)
         assert(in_out_apps[arg], "unknown output type")
         output_type = arg
      end,
      p = function (arg)
         port = assert(tonumber(arg), "expected number for port")
      end,
      m = function (arg)
         host_mac = arg
      end,
      a = function (arg)
         host_ip = arg
      end,
      c = function (arg)
         collector_ip = arg
      end,
      ["active-timeout"] = function (arg)
         active_timeout =
            assert(tonumber(arg), "expected number for active timeout")
      end,
      ["idle-timeout"] = function (arg)
         idle_timeout =
            assert(tonumber(arg), "expected number for idle timeout")
      end,
      ipfix = function (arg)
         ipfix_version = 10
      end,
      ["netflow-v9"] = function (arg)
         ipfix_version = 9
      end,
      -- TODO: not implemented
      ["transport"] = function (arg) end,
      ["cpu"] = function (arg)
         cpu = tonumber(arg)
      end
   }

   args = lib.dogetopt(args, opt, "hD:i:o:p:m:a:c:", long_opts)
   if #args ~= 2 then
      print(require("program.ipfix.probe.README_inc"))
      main.exit(1)
   end

   local in_link, in_app   = in_out_apps[input_type](args[1])
   local out_link, out_app = in_out_apps[output_type](args[2])

   local arp_config    = { self_mac = host_mac and ethernet:pton(self_mac),
                           self_ip = ipv4:pton(host_ip),
                           next_ip = ipv4:pton(collector_ip) }
   local ipfix_config    = { active_timeout = active_timeout,
                             idle_timeout = idle_timeout,
                             ipfix_version = ipfix_version,
                             exporter_ip = host_ip,
                             collector_ip = collector_ip,
                             collector_port = port }
   local c = config.new()

   config.app(c, "source", unpack(in_app))
   config.app(c, "arp", arp.ARP, arp_config)
   config.app(c, "ipfix", ipfix.IPFIX, ipfix_config)
   config.app(c, "sink", unpack(out_app))

   config.link(c, "source." .. in_link.output .. " -> arp.south")
   config.link(c, "arp.north -> ipfix.input")
   config.link(c, "ipfix.output -> arp.north")
   config.link(c, "arp.south -> sink." .. out_link.input)

   local done
   if not duration then
      done = function ()
         return engine.app_table.source.done
      end
   end

   local t1 = now()
   if cpu then numa.bind_to_cpu(cpu) end

   engine.configure(c)
   engine.busywait = true
   engine.main({ duration = duration, done = done })

   local t2 = now()
   local stats = link.stats(engine.app_table.ipfix.input.input)
   print("IPFIX probe stats:")
   local comma = lib.comma_value
   print(string.format("bytes: %s packets: %s bps: %s Mpps: %s",
                       comma(stats.rxbytes),
                       comma(stats.rxpackets),
                       comma(math.floor((stats.rxbytes * 8) / (t2 - t1))),
                       comma(stats.rxpackets / ((t2 - t1) * 1000000))))
end
