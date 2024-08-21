local cfg = require("notes.config")
local map = require("notes.map")
local cmd = require("notes.cmd")

local M = {}

---@param options? Config User defined configuration options
M.setup = function(options)
    cfg.options = vim.tbl_deep_extend("force", cfg.defaults, options or {})

    if options and options.mappings then
        local new_mappings = cfg.default_mappings

        for fn, mapping in pairs(options.mappings) do
            if type(mapping) == "string" then
                local default = cfg.default_mappings[fn]
                default[1] = mapping
                new_mappings[fn] = default
            else
                new_mappings[fn] = mapping
            end
        end

        cfg.options.mappings = new_mappings
    else
        cfg.options.mappings = cfg.default_mappings
    end

    if package.loaded["telescope"] == nil then
        cfg.options.mappings["find_note"] = nil
        cfg.options.mappings["grep_notes"] = nil
    end

    map._set_keymaps()
    cmd.create_commands()

    local exists = vim.fn.filereadable(vim.fn.expand(cfg.project_store))

    if exists == 0 then
        local data_folder = vim.fn.stdpath("data") .. "/notes.nvim"
        vim.fn.system("mkdir " .. data_folder)

        local file = io.open(vim.fn.expand(cfg.project_store), "w")

        if file ~= nil then
            file:write(vim.json.encode({ foo = "bar" }))
            file:flush()
            file:close()
        end
    end
end

return M
