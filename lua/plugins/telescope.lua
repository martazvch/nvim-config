local action_state = require("telescope.actions.state")

return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim",     build = "make" },
            { "nvim-telescope/telescope-live-grep-args.nvim", version = "^1.0.0" },
            { "nvim-telescope/telescope-ui-select.nvim" },
            { "LukasPietzschmann/telescope-tabs" },
        },
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")
            local lga_actions = require("telescope-live-grep-args.actions")
            local themes = require("telescope.themes")

            -- Global dropdown theme config
            local dropdown = themes.get_dropdown({
                previewer = false,
                layout_config = { width = 0.8, height = 0.6 },
            })

            -- With preview
            local dropdown_preview = themes.get_dropdown({
                layout_config = {
                    width = 0.8,
                    height = 0.6,
                    preview_cutoff = 10,
                },
            })

            telescope.setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<A-a>"] = function(prompt_bufnr)
                                local entry = action_state.get_selected_entry()
                                local path = entry.path or entry.filename
                                if path then
                                    actions.close(prompt_bufnr)
                                    vim.cmd("let g:splitright_backup = &splitright")
                                    vim.cmd("set splitright")
                                    vim.cmd("vsplit " .. vim.fn.fnameescape(path))
                                    vim.cmd("let &splitright = g:splitright_backup")
                                    vim.cmd("unlet g:splitright_backup")
                                end
                            end,
                            ["<esc>"] = actions.close,
                        },
                        n = {
                            ["<A-a>"] = function(prompt_bufnr)
                                local entry = action_state.get_selected_entry()
                                local path = entry.path or entry.filename
                                if path then
                                    actions.close(prompt_bufnr)
                                    vim.cmd("let g:splitright_backup = &splitright")
                                    vim.cmd("set splitright")
                                    vim.cmd("vsplit " .. vim.fn.fnameescape(path))
                                    vim.cmd("let &splitright = g:splitright_backup")
                                    vim.cmd("unlet g:splitright_backup")
                                end
                            end,
                        },
                    },
                },
                pickers = {
                    find_files = dropdown,
                    live_grep = dropdown_preview,
                    lsp_document_symbols = dropdown_preview,
                    diagnostics = dropdown_preview,
                    lsp_references = dropdown_preview,
                    current_buffer_fuzzy_find = dropdown_preview,
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                    live_grep_args = vim.tbl_deep_extend("force", dropdown, {
                        auto_quoting = true,
                        mappings = {
                            i = {
                                ["<M-q>"] = lga_actions.quote_prompt(),
                                ["<M-i>"] = lga_actions.quote_prompt({ postfix = " -g '*." }),
                                ["<C-space>"] = lga_actions.to_fuzzy_refine,
                            },
                        },
                    }),
                    ["ui-select"] = dropdown,
                    ["telescope-tabs"] = dropdown,
                },
            })

            -- Load all extensions
            telescope.load_extension("fzf")
            telescope.load_extension("live_grep_args")
            telescope.load_extension("ui-select")
            telescope.load_extension("telescope-tabs")

            -- Keymaps
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "te", builtin.find_files, {})
            vim.keymap.set("n", "tg", telescope.extensions.live_grep_args.live_grep_args, {})
            vim.keymap.set("n", "ts", builtin.lsp_document_symbols, {})
            vim.keymap.set("n", "tr", builtin.lsp_references, {})
            vim.keymap.set("n", "tf", builtin.current_buffer_fuzzy_find, {})
            vim.keymap.set("n", "td", builtin.diagnostics, {})
            vim.keymap.set("n", "tfd", function() builtin.diagnostics({ bufnr = 0 }) end, {})
            vim.keymap.set("n", "tz", function()
                builtin.find_files({
                    prompt_title = "Find Zig Files",
                    find_command = { "rg", "--files", "--glob", "*.zig" },
                })
            end, { desc = "Search only Zig files" })

            vim.keymap.set("n", "tt", telescope.extensions["telescope-tabs"].list_tabs, { desc = "Switch Tabs" })
        end,
    },
}
