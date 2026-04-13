return {
    "folke/noice.nvim",
    event = "VeryLazy",
    enabled = true,
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("noice").setup({
            cmdline   = { enabled = true },
            messages  = { enabled = true },
            popupmenu = { enabled = true },
            notify    = { enabled = false },
            lsp       = { progress = { enabled = false }, hover = { enabled = false }, signature = { enabled = false } },
            health    = { checker = false },
        })
    end,
}
