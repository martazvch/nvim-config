local action_state = require("telescope.actions.state")

return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.6",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        config = function()
            local actions = require("telescope.actions")

            require("telescope").setup({
                defaults = {
                    -- Define custom mappings
                    mappings = {
                        i = { -- Insert mode mappings
                            ["<C-v>"] = function(prompt_bufnr)
                                local selected_entry = action_state.get_selected_entry()
                                local file_path = selected_entry.path or selected_entry.filename
                                if file_path then
                                    actions.close(prompt_bufnr) -- Close Telescope first
                                    vim.cmd("let g:splitright_backup = &splitright") -- Backup the current 'splitright' setting
                                    vim.cmd("set splitright") -- Ensure splits open to the right
                                    vim.cmd("vsplit " .. vim.fn.fnameescape(file_path))
                                    vim.cmd("let &splitright = g:splitright_backup") -- Restore 'splitright'
                                    vim.cmd("unlet g:splitright_backup")
                                end
                            end,
                            ["<esc>"] = actions.close,
                        },
                        n = { -- Normal mode mappings
                            ["<C-v>"] = function(prompt_bufnr)
                                local selected_entry = action_state.get_selected_entry()
                                local file_path = selected_entry.path or selected_entry.filename
                                if file_path then
                                    actions.close(prompt_bufnr) -- Close Telescope first
                                    vim.cmd("let g:splitright_backup = &splitright")
                                    vim.cmd("set splitright")
                                    vim.cmd("vsplit " .. vim.fn.fnameescape(file_path))
                                    vim.cmd("let &splitright = g:splitright_backup")
                                    vim.cmd("unlet g:splitright_backup")
                                end
                            end,
                        },
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true, -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true, -- override the file sorter
                        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    },
                },
            })

            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "te", builtin.find_files, {})
            vim.keymap.set("n", "tg", builtin.live_grep, {})
            vim.keymap.set("n", "ts", builtin.lsp_document_symbols, {})
            vim.keymap.set("n", "tr", builtin.lsp_references, {})
            vim.keymap.set("n", "tf", builtin.current_buffer_fuzzy_find, {})
            vim.keymap.set("n", "td", builtin.diagnostics, {})
            vim.keymap.set("n", "tfd", function()
                require("telescope.builtin").diagnostics({ bufnr = 0 })
            end, { desc = "Telescope diagnostics for current buffer" })

            -- Keymap to search only in Zig files
            vim.keymap.set("n", "tz", function()
                require("telescope.builtin").find_files({
                    prompt_title = "Find Zig Files",
                    find_command = { "rg", "--files", "--glob", "*.zig" },
                })
            end, { desc = "Search only Zig files" })
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })

            require("telescope").load_extension("ui-select")
        end,
    },
}
