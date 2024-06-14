return {
    "folke/flash.nvim",
    event = "VeryLazy",
    config = function ()
        require("flash").setup({
            jump = {
                autojump = true, -- Auto jump is there is only one match
            },
            modes = {
                char = {
                    enabled = false, -- Disable activation when use of 'f', 't', ...
                }
            },
        })
    end,
    keys = {
        { "m", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
        { "M", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        { "<C-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
}
