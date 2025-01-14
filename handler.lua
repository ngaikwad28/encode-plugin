local ngx = ngx
local kong = kong

local EncodePlugin = {}

-- Constructor
function EncodePlugin:new()
  local obj = {}
  setmetatable(obj, self)
  self.__index = self
  return obj
end

-- Header filter phase to prepare the body for encoding
function EncodePlugin:header_filter()
  -- Ensure Content-Length is removed for encoded responses
  ngx.header["Content-Length"] = nil
end

-- Body filter phase to encode the response body
function EncodePlugin:body_filter()
  local chunk = ngx.arg[1]
  local eof = ngx.arg[2]

  if not ngx.ctx.buffer then
    ngx.ctx.buffer = ""
  end

  if chunk then
    ngx.ctx.buffer = ngx.ctx.buffer .. chunk
    ngx.arg[1] = nil  -- Clear the chunk to avoid outputting unencoded data
  end

  if eof then
    -- Encode the entire response in Base64 and send it
    local encoded = ngx.encode_base64(ngx.ctx.buffer)
    ngx.arg[1] = encoded
  end
end

-- Define the plugin priority (mandatory)
EncodePlugin.PRIORITY = 10

-- Define the plugin version (mandatory)
EncodePlugin.VERSION = "1.0.0"

return EncodePlugin
