local cfg = require("notes.config")
local cmd = require("notes.cmd")

local M = {}

---@param options? Config User defined configuration options
M.setup = function(options)
    cfg.options = vim.tbl_deep_extend("force", cfg.defaults, options or {})
    cmd.create_commands()
end

return M
