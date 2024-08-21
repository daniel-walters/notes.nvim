local cfg = require("notes.config")

local M = {}

--- Open or create a note in the notes_folder
---@param note string Path to the note relative to your notes_folder
M.open_note = function(note)
    if not note then
        return
    end

    vim.cmd.edit(cfg.options.notes_folder .. "/" .. note)
end

return M
