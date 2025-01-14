local typedefs = require "kong.db.schema.typedefs"

return {
  name = "encode-plugin",
  fields = {
    { consumer = typedefs.no_consumer },
    { protocols = typedefs.protocols_http },  -- Supports only HTTP/HTTPS
    { config = {
        type = "record",
        fields = {},
      },
    },
  },
}
