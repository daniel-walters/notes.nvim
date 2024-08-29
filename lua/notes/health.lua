local cfg = require("notes.config")

local M = {}

M.check = function()
    vim.health.start("notes.nvim")

    local success = M._check_health()

    if success then
        vim.health.ok("notes.nvim configured correctly.")
    end
end

M._check_health = function()
    local success = true

    if package.loaded["telescope"] == nil then
        success = false
        vim.health.warn(
            "Telescope is not installed. Some functionality will be disabled.",
            {
                "Install telescope: https://github.com/nvim-telescope/telescope.nvim",
            }
        )
    end

    if cfg.options.notes_folder == "" then
        success = false
        vim.health.error("Notes folder is not defined.", {
            "Set notes_folder in your configuration.",
        })
    end

    if cfg.options.templates_folder == "" then
        success = false
        vim.health.warn(
            "Templates folder is not defined. Daily note functionality will not work.",
            {
                "Set templates_folder in your configuration. ",
            }
        )
    end

    if
        cfg.options.date_format == ""
        or cfg.options.daily_note_format == ""
        or cfg.options.daily_note_template == ""
    then
        success = false
        vim.health.warn(
            "Set date_format, daily_note_format, and daily_note_template in your configuration for daily note functionality to work."
        )
    end

    if #cfg.options.note_extensions == 0 then
        success = false
        vim.health.warn(
            "No note extensions defined. Searching for notes will not work.",
            {
                "Set note_extensions in your configuration.",
            }
        )
    end

    local notes_folder_stat =
        vim.loop.fs_stat(vim.fn.expand(cfg.options.notes_folder))
    if notes_folder_stat == nil or notes_folder_stat.type ~= "directory" then
        success = false
        vim.health.error(
            "The notes_folder specified in the config does not exist"
        )
    end

    local template_folder_stat =
        vim.loop.fs_stat(vim.fn.expand(cfg.options.templates_folder))
    if
        template_folder_stat == nil
        or template_folder_stat.type ~= "directory"
    then
        success = false
        vim.health.error(
            "The templates_folder specified in the config does not exist"
        )
    end

    return success
end

return M
