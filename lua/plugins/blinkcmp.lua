return {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    dependencies = {
        "rafamadriz/friendly-snippets",
        "xzbdmw/colorful-menu.nvim",
    },

    -- use a release tag to download pre-built binaries
    version = "*",
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        -- 'default' for mappings similar to built-in completion
        -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
        -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
        -- See the full "keymap" documentation for information on defining your own keymap.
        keymap = {
            preset = "default",
            ["<Up>"] = { "select_prev", "fallback" },
            ["<Down>"] = { "select_next", "fallback" },
            ["<Tab>"] = { "accept", "fallback" },
            ["<S-Tab>"] = { "snippet_forward", "fallback" },
        },

        appearance = {
            -- Sets the fallback highlight groups to nvim-cmp's highlight groups
            -- Useful for when your theme doesn't support blink.cmp
            -- Will be removed in a future release
            -- use_nvim_cmp_as_default = true,
            -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = "mono",
        },

        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },

        completion = {
            list = {
                selection = {
                    auto_insert = false,
                },
            },
            trigger = {
                -- When true, will prefetch the completion items when entering insert mode
                prefetch_on_insert = false,

                -- When false, will not show the completion window automatically when in a snippet
                -- show_in_snippet = true,

                -- When true, will show the completion window after typing any of alphanumerics, `-` or `_`
                show_on_keyword = true,

                -- When true, will show the completion window after typing a trigger character
                show_on_trigger_character = true,
            },
            menu = {
                draw = {
                    -- We don't need label_description now because label and label_description are already
                    -- conbined together in label by colorful-menu.nvim.
                    --
                    -- However, for `basedpyright`, it is recommend to set
                    -- columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },
                    -- because the `label_description` will only be import path.
                    columns = { { "kind_icon" }, { "label", gap = 1 } },
                    components = {
                        label = {
                            text = function(ctx)
                                return require("colorful-menu").blink_components_text(ctx)
                            end,
                            highlight = function(ctx)
                                return require("colorful-menu").blink_components_highlight(ctx)
                            end,
                        },
                    },
                },
            },
            -- Show documentation when selecting a completion item
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 0,
            },
        },
        signature = {
            -- enabled = true,
            enabled = false,
            window = {
                border = "single",
                direction_priority = { "s", "n" },
            },
        },
    },

    opts_extend = { "sources.default" },
}
