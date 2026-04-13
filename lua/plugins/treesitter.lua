return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    branch = "main",
    config = function()
        require("nvim-treesitter").setup({
            auto_install = true,
            ensure_installed = { "zig", "markdown", "markdown_inline" },
        })

        -- Enable treesitter highlighting for filetypes not covered by nvim's own ftplugins
        vim.api.nvim_create_autocmd("FileType", {
            callback = function(ev)
                pcall(vim.treesitter.start, ev.buf)
            end,
        })
    end,
}
