package = "kong-plugin-encode-plugin"
version = "0.1.0-1"
rockspec_format = "1.0"
description = {
  summary = "A Kong plugin to Base64 encode backend responses",
  homepage = "/home/kong/Desktop/encode-plugin",
  license = "MIT",
}

dependencies = {
  "lua >= 5.1",
  "kong >= 3.0",
}
source = {
  url = "/home/kong/Desktop/kong-plugin-master",
}

build = {
  type = "builtin",
  modules = {
    ["kong.plugins.encode-plugin.handler"] = "handler.lua",
    ["kong.plugins.encode-plugin.schema"] = "schema.lua",
  },
}
