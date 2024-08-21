local M = {}

M._run_command = function(cmd)
    local out = vim.fn.system(cmd)

    if out:find("^fatal: ") then
        return ""
    end

    return out
end

M._get_git_branch = function()
    local cmd = "git branch --show-current"
    return M._run_command(cmd)
end

M._get_git_root_folder = function()
    local cmd = "git rev-parse --show-toplevel"
    return M._run_command(cmd)
end

M._get_git_key = function()
    local branch = M._get_git_branch()
    local root = M._get_git_root_folder()

    return root .. "/" .. branch
end

return M
