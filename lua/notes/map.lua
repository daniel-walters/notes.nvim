local cfg = require("notes.config")
local api = require("notes.api")
local project = require("notes.project_notes")

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

M.open_linked_note = function()
    local line = vim.api.nvim_get_current_line()
    local cursor_position = vim.fn.col(".")

    for start_col, end_col in string.gmatch(line, "()%[%[.-%]%]()") do
        if cursor_position >= start_col and cursor_position < end_col then
            local note_name = string.sub(line, start_col + 2, end_col - 3)

            for _, ext in pairs(cfg.options.note_extensions) do
                local findCmd = "find "
                    .. cfg.options.notes_folder
                    .. " -type f -name '"
                    .. note_name
                    .. "."
                    .. ext
                    .. "'"

                local handle = io.popen(findCmd)

                if handle ~= nil then
                    local res = handle:read("*a")
                    handle:close()

                    if res ~= "" then
                        api.open_note(note_name .. "." .. ext)
                        return
                    end
                end
            end
        end
    end
end

M.add_project_note = function()
    local key = project._get_git_key()
    if key == "/" then
        return
    end

    local file_string = vim.fn.readfile(cfg.project_store)
    local store = vim.json.decode(file_string[1])

    local cur_file = vim.api.nvim_buf_get_name(0)

    store[key] = cur_file

    local file = io.open(vim.fn.expand(cfg.project_store), "w")

    if file then
        file:write(vim.json.encode(store))
        file:flush()
        file:close()
    end

    print("NOTES.nvim: Project note set to " .. cur_file)
end

M.open_project_note = function()
    local key = project._get_git_key()
    if key == "/" then
        return
    end

    local file_string = vim.fn.readfile(cfg.project_store)
    local store = vim.json.decode(file_string[1])

    local note = store[key]

    if note then
        vim.cmd.edit(note)
    end
end

return M
