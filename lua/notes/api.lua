local cfg = require("notes.config")

local M = {}

--- Open or create a daily note for the given time
---@param time integer Unix timestamp
M.open_daily_note = function(time)
    local date = os.date(cfg.options.date_format, time)

    local daily_note_relative_path =
        string.gsub(cfg.options.daily_note_format, "%%DATE%%", date)

    local daily_note_path = cfg.options.notes_folder
        .. "/"
        .. daily_note_relative_path

    local exists = vim.fn.filereadable(vim.fn.expand(daily_note_path))

    if exists == 0 then
        vim.uv.fs_copyfile(
            vim.fn.expand(
                cfg.options.templates_folder
                    .. "/"
                    .. cfg.options.daily_note_template
            ),
            vim.fn.expand(daily_note_path)
        )
    end

    M.open_note(daily_note_relative_path)
end

--- Open or create a note in the notes_folder
---@param note string Path to the note relative to your notes_folder
M.open_note = function(note)
    if not note then
        return
    end

    vim.cmd.edit(cfg.options.notes_folder .. "/" .. note)
end

return M
