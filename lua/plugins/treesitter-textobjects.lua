return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    version = false,
    config = function()
        require("nvim-treesitter-textobjects").setup({
            -- Smart selections: inside/outside objects
            select = {
                enable = true,
                lookahead = true, -- Automatically jump forward
            },
        })

        -- keymaps
        vim.keymap.set({ "x", "o" }, "af", function()
            require "nvim-treesitter-textobjects.select".select_textobject("@function.outer", "textobjects")
        end)
        vim.keymap.set({ "x", "o" }, "if", function()
            require "nvim-treesitter-textobjects.select".select_textobject("@function.inner", "textobjects")
        end)
        vim.keymap.set({ "x", "o" }, "ac", function()
            require "nvim-treesitter-textobjects.select".select_textobject("@class.outer", "textobjects")
        end)
        vim.keymap.set({ "x", "o" }, "ic", function()
            require "nvim-treesitter-textobjects.select".select_textobject("@class.inner", "textobjects")
        end)

        vim.keymap.set({ "x", "o" }, "ai", function()
            require "nvim-treesitter-textobjects.select".select_textobject("@conditional.outer", "textobjects")
        end)
        vim.keymap.set({ "x", "o" }, "ii", function()
            require "nvim-treesitter-textobjects.select".select_textobject("@conditional.inner", "textobjects")
        end)

        vim.keymap.set({ "x", "o" }, "al", function()
            require "nvim-treesitter-textobjects.select".select_textobject("@loop.outer", "textobjects")
        end)
        vim.keymap.set({ "x", "o" }, "il", function()
            require "nvim-treesitter-textobjects.select".select_textobject("@loop.inner", "textobjects")
        end)

        -- You can also use captures from other query groups like `locals.scm`
        vim.keymap.set({ "x", "o" }, "as", function()
            require "nvim-treesitter-textobjects.select".select_textobject("@local.scope", "locals")
        end)

        -- Swap
        vim.keymap.set("n", "<C-l>", function()
            require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
        end)
        vim.keymap.set("n", "<C-h>", function()
            require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.outer")
        end)

        -- Gotos
        vim.keymap.set({ "n", "x", "o" }, "]f", function()
            require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
        end)
        vim.keymap.set({ "n", "x", "o" }, "]c", function()
            require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
        end)
        -- You can also pass a list to group multiple queries.
        vim.keymap.set({ "n", "x", "o" }, "]l", function()
            require("nvim-treesitter-textobjects.move").goto_next_start({ "@loop.inner", "@loop.outer" }, "textobjects")
        end)
        -- You can also use captures from other query groups like `locals.scm` or `folds.scm`
        vim.keymap.set({ "n", "x", "o" }, "]s", function()
            require("nvim-treesitter-textobjects.move").goto_next_start("@local.scope", "locals")
        end)

        vim.keymap.set({ "n", "x", "o" }, "]F", function()
            require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
        end)
        vim.keymap.set({ "n", "x", "o" }, "]C", function()
            require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects")
        end)

        vim.keymap.set({ "n", "x", "o" }, "[f", function()
            require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
        end)
        vim.keymap.set({ "n", "x", "o" }, "[c", function()
            require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
        end)

        vim.keymap.set({ "n", "x", "o" }, "[F", function()
            require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
        end)
        vim.keymap.set({ "n", "x", "o" }, "[C", function()
            require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects")
        end)

        -- Go to either the start or the end, whichever is closer.
        -- Use if you want more granular movements
        vim.keymap.set({ "n", "x", "o" }, "]i", function()
            require("nvim-treesitter-textobjects.move").goto_next("@conditional.outer", "textobjects")
        end)
        vim.keymap.set({ "n", "x", "o" }, "[i", function()
            require("nvim-treesitter-textobjects.move").goto_previous("@conditional.outer", "textobjects")
        end)

        -- Repeatable treesitter motions
        local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

        -- Repeat move with ; and ,
        vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
        vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

        -- Optional: override built-in f/F/t/T to also be repeatable with ; and ,
        vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
    end,
}
