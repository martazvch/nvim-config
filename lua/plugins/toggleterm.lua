return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup({
            shell = "powershell",
            direction = "float",
            persist_mode = false,
        })

        vim.keymap.set("n", "<A-t>", ":ToggleTerm<CR>")
        vim.keymap.set("t", "<A-t>", "<C-\\><C-n>:ToggleTerm<CR>")
    end,
}
