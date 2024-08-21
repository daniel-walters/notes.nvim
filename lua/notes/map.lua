local cfg = require("notes.config")
local api = require("notes.api")

local M = {}

M._set_keymaps = function()
    for fn, mapping in pairs(cfg.options.mappings) do
        vim.api.nvim_set_keymap(
            "n",
            mapping[1],
            "<cmd>lua require('notes.map')." .. fn .. "()<cr>",
            mapping[2]
        )
    end
end

M.note_today = function()
    api.open_daily_note(os.time())
end

--- Prompt user for input and open the note relative to the notes_folder
M.open_note = function()
    vim.ui.input({
        prompt = "Note: ",
    }, api.open_note)
end

--- Launch telescope to search for notes by filename in the notes_folder
M.find_note = function()
    require("telescope.builtin").find_files({
        prompt_title = "Find Note",
        cwd = cfg.options.notes_folder,
        find_command = {
            "rg",
            "--files",
            "--iglob",
            "*.{" .. table.concat(cfg.options.note_extensions, ",") .. "}",
        },
        hidden = true,
        no_ignore = true,
    })
end

--- Launch telescope to search for notes by content in the notes_folder
M.grep_notes = function()
    require("telescope.builtin").live_grep({
        prompt_title = "Search Notes",
        cwd = cfg.options.notes_folder,
        find_command = {
            "rg",
            "--files",
            "--iglob",
            "*.{" .. table.concat(cfg.options.note_extensions, ",") .. "}",
        },
        hidden = true,
        no_ignore = true,
    })
end


return M
