return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                transparent_background = false,
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
                            BlinkCmpMenuSelection = { bg = colors.surface0 },
                            -- BlinkCmpDoc = { bg = colors.surface1 },
                        }
                    end,
                },
                integrations = {
                    notify = true,
                    blink_cmp = true,
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
                transparent = false,
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
                    local k = require("kanagawa.colors").setup({ theme = "wave" })
                    local p = k.palette

                    return {
                        Boolean = { bold = false },
                        -- NormalFloat = { bg = p.sumiInk3 },
                        -- FloatBorder = { bg = "none" },
                        -- FloatBorder = { fg = p.sumiInk2, bg = p.sumiInk3 },
                        -- FloatTitle = { bg = "none" },
                        ["@keyword.exception"] = { link = "@lsp.type.keyword", bold = false },
                        ["@string.escape"] = { bold = false },
                        ["@lsp.type.enumMember.zig"] = { link = "@lsp.type.property.zig" },
                        ["@keyword.return.zig"] = { link = "@lsp.type.keyword" },

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
}
