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

    vim.api.nvim_create_user_command("NoteToday", function()
        api.open_daily_note(os.time())
    end, { nargs = 0 })

    vim.api.nvim_create_user_command("NoteYesterday", function()
        local time = os.time()
        local time_yesterday = time - (24 * 60 * 60)

        api.open_daily_note(time_yesterday)
    end, { nargs = 0 })

    vim.api.nvim_create_user_command("NoteTomorrow", function()
        local time = os.time()
        local time_tomorrow = time + (24 * 60 * 60)

        api.open_daily_note(time_tomorrow)
    end, { nargs = 0 })
return M
