local M = {}

---@class Config
---@field notes_folder string The path to the users top level notes directory
---@field templates_folder? string The path to the users templates folder
---@field note_extensions? table<string> A list of note extensions to search for
---@field mappings? table<string, string> A list of keymap overrides
---@field date_format? string A format string for the date
---@field daily_note_format? string A format string for the daily note. Must include %DATE%
---@field daily_note_template? string The path to the daily note template relative to the templates_folder

---@type Config
M.defaults = {
    notes_folder = "",
    templates_folder = "",
    note_extensions = { "md", "txt" },
    mappings = M.default_mappings,
    date_format = "%d-%m-%y",
    daily_note_format = "%DATE%.md",
    daily_note_template = "",
}

M.options = M.defaults

M.default_mappings = {
    find_note = { "<leader>ns", { silent = true, desc = "[N]otes [S]earch" } },
    grep_notes = { "<leader>ng", { silent = true, desc = "[N]otes [G]rep" } },
    open_note = { "<leader>no", { silent = true, desc = "[N]ote [O]pen" } },
    note_today = { "<leader>nd", { silent = true, desc = "[N]ote [D]aily" } },
    open_linked_note = {
        "<leader>nl",
        { silent = true, desc = "[N]ote [L]ink" },
    },
    add_project_note = {
        "<leader>na",
        { silent = true, desc = "[N]ote [A]dd" },
    },
    open_project_note = {
        "<leader>np",
        { silent = true, desc = "[N]ote [P]roject" },
    },
}

M.project_store = vim.fn.stdpath("data") .. "/notes.nvim/projectNotes.json"

return M
