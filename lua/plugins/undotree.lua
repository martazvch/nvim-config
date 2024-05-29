return {
    "mbbill/undotree",
    config = function()
        vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
        -- Name of the 'diff' exe for windows
        vim.g.undotree_DiffCommand = "FC"
    end
}
