return {
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = true,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                styles = {
                    comments = { "italic" }, 
                    conditionals = {},
                },
            })
        end
    },
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                styles = {
                    -- Default set it to italic, it disables it
                    comments = { italic = false },
                    keywords = { italic = false },
                },
            })
        end
    },
    {
        "rebelot/kanagawa.nvim",
        priority = 1000,
        config = function()
            require("kanagawa").setup({
                commentStyle = { italic = false },
                keywordStyle = { italic = false },
            })
        end
    },
    {
        "neanias/everforest-nvim",
        priority = 1000,
        config = function()
            require("everforest").setup({

            })
        end
    }
}
