# notes.nvim
A simple neovim plugin for note taking
# Features
- Search through all your notes with [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- Navigate between notes that reference eachother
- Create a 'daily' note using fully customizable templates
- Save a project specific note against the git branch you're working on
# Installation
## Setup
notes.nvim requires you to point it to a directory containing your notes, and your note templates.
If you don't store your notes in this way you could point your `notes_folder` to your root directory but be aware of the added scope when searching through your notes.

## Installation
Install the plugin using any package manager of your choice. If using [Telescope](https://github.com/nvim-telescope/telescope.nvim), you must load it before notes.nvim to opt into the search functionality.
### E.g. Using Lazy
```lua
return {
  'daniel-walters/notes.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  opts = {
    notes_folder = '~/path/to/notes/folder',
    templates_folder = '~/path/to/templates/folder',
    daily_note_format = 'My daily note - %DATE%.md',
    daily_note_template = 'daily-note-template.md',
  },
}
```

For a full list of setup options, view [Configuration](#config)

# <a name="config"></a>Configuration
The following setup options with default values are provided when installing notes.nvim:
```lua
{
    --- The path to directory you keep your notes in
    notes_folder = "",
    --- The path to directory you keep your templates in
    templates_folder = "",
    --- File types to search for within the notes folder
    note_extensions = { "md", "txt" },
    --- Table of mappings which can be individually overwritten.
    --- Each value can be either a string with the keymap, or table with the keymap & options.
    mappings = {
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
    },
    --- The date format to use with the daily_note
    date_format = "%d-%m-%y",
    --- The file name daily note will be created with. NOTE: Must include `%DATE%` to be unique.
    daily_note_format = "%DATE%.md",
    --- A file relative to `templates_folder` to create a new daily note from
    daily_note_template = "",
}
```

# Usage
## Commands
- `:NoteOpen <filename>` - Opens or creates `filename`. `filename` must be relative to `notes_folder`, autocomplete is provided.
- `:NoteToday` - Open the daily note for today
- `:NoteYesterday` - Open the daily note for yesterday
- `:NoteTomorrow` - Open the daily note for tomorrow
- `:NoteProject` - Open the git branch specific project note
- `:NoteProjectAdd` - Assign the current note to the current git branch

## Mappings
- `<leader>ns` - Search through your notes by filename using Telescope
- `<leader>ng` - Grep search through your notes using Telescope
- `<leader>no` - Open or create a note
- `<leader>nd` - Open or create the daily note
- `<leader>nl` - Open the linked note under the cursor
- `<leader>na` - Assign the current note to the current git branch
- `<leader>np` - Open the git branch specific project note

## Linked notes
notes.nvim currently only supports notes referenced as such: `[[My other note]]`.
Hovering over the link and pressing the keymap (default `<leader>nl`) will search your `notes_folder` for `My other note` and open it.

# TODOs
- :checkhealth
- Extend the templating API for custom use cases
- Add autocompletion when linking other notes with `[[]]` syntax
- Extend note linking functionality to markdown links `[]()`

