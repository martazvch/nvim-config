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
                            -- ["@lsp.type.enumMember"] = { fg = "#81c8be" },
                            ["@lsp.type.parameter"] = { fg = colors.flamingo },
                            ["@variable.parameter"] = { fg = colors.flamingo },
                            -- BlinkCmpMenuSelection = { bg = colors.surface0 },
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

                    return {
                        Boolean = { bold = false },
                        ["@keyword.exception"] = { link = "@lsp.type.keyword", bold = false },
                        ["@string.escape"] = { bold = false },
                        ["@keyword.return.zig"] = { link = "@lsp.type.keyword" },
                        ["@lsp.type.property.zig"] = { link = "@variable.zig" },
                        ["@variable.member.zig"] = { link = "@variable.zig" },

                        ["@lsp.type.enumMember.zig"] = { fg = "#E6C384" },
                        -- Colors unions and structure fields
                        -- ["@lsp.typemod.property.declaration.zig"] = { fg = "#E6C384" },

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
