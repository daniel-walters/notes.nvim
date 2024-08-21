local M = {}

---@class Config
---@field notes_folder string The path to the users top level notes directory
---@field templates_folder? string The path to the users templates folder
---@field note_extensions? table<string> A list of note extensions to search for
---@field date_format? string A format string for the date
---@field daily_note_format? string A format string for the daily note. Must include %DATE%
---@field daily_note_template? string The path to the daily note template relative to the templates_folder

---@type Config
M.defaults = {
    notes_folder = "",
    templates_folder = "",
    note_extensions = { "md", "txt" },
    date_format = "%d-%m-%y",
    daily_note_format = "%DATE%.md",
    daily_note_template = "",
}

M.options = M.defaults
}

return M
