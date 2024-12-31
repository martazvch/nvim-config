return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                no_italic = true,
                styles = {
                    comments = { "italic" },
                    conditionals = {},
                },
                highlight_overrides = {
                    all = function(colors)
                        return {
                            ["@keyword.self"] = { fg = colors.mauve },
                            ["@parameter"] = { fg = colors.flamingo },
                            ["@lsp.type.enumMember"] = { fg = "#81c8be" },
                        }
                    end,
                },
            })
        end,
    },
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        lazy = true,
        config = function()
            require("tokyonight").setup({
                styles = {
                    -- Default set it to italic, it disables it
                    comments = { italic = false },
                    keywords = { italic = false },
                },
            })
        end,
    },
    {
        "rebelot/kanagawa.nvim",
        priority = 1000,
        lazy = false,
        config = function()
            require("kanagawa").setup({
                commentStyle = { italic = false },
                keywordStyle = { italic = false, bold = false },
                transparent = true,
                colors = {
                    theme = {
                        all = {
                            ui = {
                                bg_gutter = "none",
                            },
                        },
                    },
                },
                -- Floating windows nicer
                overrides = function(colors)
                    local theme = colors.theme
                    return {
                        Boolean = { bold = false },
                        NormalFloat = { bg = "none" },
                        FloatBorder = { bg = "none" },
                        FloatTitle = { bg = "none" },
                        ["@keyword.exception"] = { bold = false },
                        ["@string.escape"] = { bold = false },

                        -- Save an hlgroup with dark background and dimmed foreground
                        -- so that you can use it where your still want darker windows.
                        -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
                        NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

                        -- Popular plugins that open floats will link to NormalFloat by default;
                        -- set their background accordingly if you wish to keep them dark and borderless
                        LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                        MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

                        -- Telescope nice borders
                        TelescopePromptBorder = { bg = "none" },
                        TelescopeResultsBorder = { bg = "none" },
                        TelescopePreviewBorder = { bg = "none" },

                        illuminateWord = { bg = "#51576d" },
                        IlluminatedWordText = { bg = "#51576d" },
                        IlluminatedWordRead = { bg = "#51576d" },
                        IlluminatedWordWrite = { bg = "#51576d" },
                    }
                end,
            })
        end,
    },
    {
        "neanias/everforest-nvim",
        lazy = true,
        priority = 1000,
        config = function()
            require("everforest").setup({
                background = "hard",
                show_eob = false, -- Deletes ~ until Eof
                ui_contrast = "high",
            })
        end,
    },
    {
        "EdenEast/nightfox.nvim",
        lazy = true,
    },
    {
        "sam4llis/nvim-tundra",
        lazy = true,
    },
    {
        "rose-pine/neovim",
        lazy = true,
    },
    {
        "AlexvZyl/nordic.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("nordic").setup({
                on_highlight = function(highlights, palette)
                    -- Highlight parameters
                    highlights["@parameter"] = { italic = false }

                    -- Highlight the '&' operator
                    highlights["@operator"] = { fg = "#99d1db" } -- Applies to all operators, including '&'
                    highlights["@punctuation.delimiter"] = { fg = "#949cbb" }
                    highlights["@punctuation.bracket"] = { fg = "#949cbb" }
                    highlights["@function.builtin"] = { fg = palette.orange.base }

                    highlights["@lsp.type.enumMember"] = { fg = "#81c8be" }
                end,
                italic_comments = false,
                bright_border = true,
                transparent = {
                    -- Enable transparent background.
                    bg = true,
                    -- Enable transparent background for floating windows.
                    float = true,
                },
                telescope = {
                    -- Available styles: `classic`, `flat`.
                    style = "classic",
                },
            })

            vim.cmd("hi Beacon guibg=grey")
        end,
    },
    {
        "shaunsingh/nord.nvim",
        config = function()
            vim.g.nord_borders = false
            vim.g.nord_disable_background = true
            vim.g.nord_italic = false
            vim.g.nord_bold = false
            vim.g.nord_cursorline_transparent = false
        end,
    },
}
