return {
    "maan2003/lsp_lines.nvim",
    config = function()
        vim.keymap.set("n", "<leader>l", require('lsp_lines').toggle)
    end
}
