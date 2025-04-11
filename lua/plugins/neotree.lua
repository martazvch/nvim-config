return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        local components = require('neo-tree.sources.common.components')

        require("neo-tree").setup({
            window = {
                position = "right",
            },
            default_component_configs = {
                diagnostics = {
                    symbols = {
                        hint = "󰌵",
                        info = "",
                        warn = "",
                        error = "",
                    },
                    highlights = {
                        hint = "diagnosticsignhint",
                        info = "diagnosticsigninfo",
                        warn = "diagnosticsignwarn",
                        error = "diagnosticsignerror",
                    },
                },
                indent = {
                    with_markers = false,
                },
                git_status = {
                    symbols = {
                        unstaged  = "", -- Remove red square
                    },
                },
            },
            filesystem = {
                filtered_items = {
                    hide_dotfiles = false,
                    hide_hidden = false,
                    hide_gitignored = false,
                },
                follow_current_file = {
                    enabled = true,
                },
                -- Allow to show only last dir name for root node
                components = {
                    name = function(config, node, state)
                        local name = components.name(config, node, state)
                        if node:get_depth() == 1 then
                            name.text = vim.fs.basename(vim.loop.cwd() or '')
                        end
                        return name
                    end,
                },
            },
            event_handlers = {
                {
                    event = "file_opened",
                    handler = function()
                        vim.cmd("Neotree toggle")
                    end
                },
            }
        })

        vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', {})

    end
}
