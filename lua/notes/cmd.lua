local api = require("notes.api")
local cfg = require("notes.config")

local M = {}

M.create_commands = function()
    vim.api.nvim_create_user_command("NoteOpen", function(args)
        api.open_note(args.args)
    end, {
        nargs = 1,
        complete = function(arg_lead)
            local files = vim.fn.glob(
                cfg.options.notes_folder .. "/**/" .. arg_lead .. "*.{md,txt}",
                false,
                true
            )

            for i, file in ipairs(files) do
                files[i] = file:gsub(
                    "^" .. vim.fn.expand(cfg.options.notes_folder) .. "/",
                    ""
                )
            end

            return files
        end,
    })


return M
