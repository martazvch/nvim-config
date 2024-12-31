return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        local settings = {
            direction = "float",
            persist_mode = false,
        }

        if vim.loop.os_uname().sysname == "Windows_NT" then
             settings.shell = "powershell"
        end

        require("toggleterm").setup(settings)

        vim.keymap.set("n", "<A-z>", ":ToggleTerm<CR>")
        vim.keymap.set("t", "<A-z>", "<C-\\><C-n>:ToggleTerm<CR>")
    end,
}
