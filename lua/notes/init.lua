local cfg = require("notes.config")

local M = {}

---@param options? Config User defined configuration options
M.setup = function(options)
    cfg.options = vim.tbl_deep_extend("force", cfg.defaults, options or {})
end

return M
