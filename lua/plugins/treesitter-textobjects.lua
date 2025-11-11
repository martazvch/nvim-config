return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    version = false,
    config = function()
        require("nvim-treesitter.configs").setup({
            textobjects = {
                -- Smart selections: inside/outside objects
                select = {
                    enable = true,
                    lookahead = true, -- Automatically jump forward

                    keymaps = {
                        -- Functions
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",

                        -- Classes / structs / types
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",

                        -- Conditionals
                        ["ai"] = "@conditional.outer",
                        ["ii"] = "@conditional.inner",

                        -- Loops
                        ["al"] = "@loop.outer",
                        ["il"] = "@loop.inner",

                        -- Parameters/arguments
                        ["ap"] = "@parameter.outer",
                        ["ip"] = "@parameter.inner",
                    },
                },

                -- Swap parameters and similar nodes
                swap = {
                    enable = true,
                    swap_next = {
                        ["<C-l>"] = "@parameter.inner",
                    },
                    swap_previous = {
                        ["<C-h>"] = "@parameter.inner",
                    },
                },

                -- Movement between functions and classes
                move = {
                    enable = true,
                    set_jumps = true, -- add to jumplist

                    goto_next_start = {
                        ["]f"] = "@function.outer",
                        ["]c"] = "@class.outer",
                        ["]p"] = "@parameter.inner",
                    },
                    goto_next_end = {
                        ["]F"] = "@function.outer",
                        ["]C"] = "@class.outer",
                    },
                    goto_previous_start = {
                        ["[f"] = "@function.outer",
                        ["[c"] = "@class.outer",
                        ["[p"] = "@parameter.inner",
                    },
                    goto_previous_end = {
                        ["[F"] = "@function.outer",
                        ["[C"] = "@class.outer",
                    },
                },
            },
        })

        -- Repeatable treesitter motions
        local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

        -- Repeat move with ; and ,
        vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
        vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

        -- Optional: override built-in f/F/t/T to also be repeatable with ; and ,
        vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
        vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
        vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
        vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
    end,
}
