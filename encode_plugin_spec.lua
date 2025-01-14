local PLUGIN_NAME = "encode-plugin"
local helpers = require "spec.helpers"

for _, strategy in helpers.each_strategy() do
  describe(PLUGIN_NAME .. ": (access) [#" .. strategy .. "]", function()
    local client

    lazy_setup(function()
      local bp = helpers.get_db_utils(strategy, {
        "plugins",
      }, { PLUGIN_NAME })

      bp.plugins:insert({
        name = PLUGIN_NAME,
        config = {},
      })

      assert(helpers.start_kong({
        database = strategy,
        plugins = "bundled," .. PLUGIN_NAME,
      }))
    end)

    lazy_teardown(function()
      helpers.stop_kong()
    end)

    before_each(function()
      client = helpers.proxy_client()
    end)

    after_each(function()
      if client then
        client:close()
      end
    end)

    it("encodes the response in Base64", function()
      local res = assert(client:send {
        method = "GET",
        path = "/",
      })
      assert.response(res).has.status(200)
      local body = assert.response(res).has.body()
      assert.matches("^[A-Za-z0-9+/]+={0,2}$", body) -- Check if the response is Base64 encoded
    end)
  end)
end
