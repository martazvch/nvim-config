return {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    config = function()
        local mc = require("multicursor-nvim")
        mc.setup()

        local set = vim.keymap.set

        -- Add or skip cursor above/below the main cursor.
        set({"n", "x"}, "<M-up>", function() mc.lineAddCursor(-1) end)
        set({"n", "x"}, "<M-down>", function() mc.lineAddCursor(1) end)
        set({"n", "x"}, "<M-k>", function() mc.lineAddCursor(-1) end)
        set({"n", "x"}, "<M-j>", function() mc.lineAddCursor(1) end)
        set({"n", "x"}, "<leader><up>", function() mc.lineSkipCursor(-1) end)
        set({"n", "x"}, "<leader><down>", function() mc.lineSkipCursor(1) end)

        -- Add or skip adding a new cursor by matching word/selection
        set({"n", "x"}, "<M-d>", function() mc.matchAddCursor(1) end)
        set({"n", "x"}, "<M-s>", function() mc.matchSkipCursor(1) end)
        set({"n", "x"}, "<M-D>", function() mc.matchAddCursor(-1) end)
        set({"n", "x"}, "<M-S>", function() mc.matchSkipCursor(-1) end)

        -- Add and remove cursors with control + left click.
        set("n", "<c-leftmouse>", mc.handleMouse)
        set("n", "<c-leftdrag>", mc.handleMouseDrag)
        set("n", "<c-leftrelease>", mc.handleMouseRelease)

        -- Pressing `<leader>miwap` will create a cursor in every match of the
        -- string captured by `iw` inside range `ap`.
        -- This action is highly customizable, see `:h multicursor-operator`.
        set({"n", "x"}, "<leader>m", mc.operator)

        -- Increment/decrement sequences, treaing all cursors as one sequence.
        set({"n", "x"}, "g<c-a>", mc.sequenceIncrement)
        set({"n", "x"}, "g<c-x>", mc.sequenceDecrement)

        -- Add a cursor for all matches of cursor word/selection in the document.
        set({"n", "x"}, "<leader>A", mc.matchAllAddCursors)

        -- Add a cursor to every search result in the buffer.
        set("n", "<leader>/A", mc.searchAllAddCursors)

        -- Disable and enable cursors.
        set({"n", "x"}, "<c-q>", mc.toggleCursor)

        -- Mappings defined in a keymap layer only apply when there are
        -- multiple cursors. This lets you have overlapping mappings.
        mc.addKeymapLayer(function(layerSet)

            -- Select a different cursor as the main one.
            layerSet({"n", "x"}, "<left>", mc.prevCursor)
            layerSet({"n", "x"}, "<right>", mc.nextCursor)

            -- Delete the main cursor.
            layerSet({"n", "x"}, "<leader>x", mc.deleteCursor)

            -- Enable and clear cursors using escape.
            layerSet("n", "<esc>", function()
                if not mc.cursorsEnabled() then
                    mc.enableCursors()
                else
                    mc.clearCursors()
                end
            end)
        end)

        -- Customize how cursors look.
        -- local hl = vim.api.nvim_set_hl
        -- hl(0, "MultiCursorCursor", { link = "Cursor" })
        -- hl(0, "MultiCursorVisual", { link = "Visual" })
        -- hl(0, "MultiCursorSign", { link = "SignColumn"})
        -- hl(0, "MultiCursorMatchPreview", { link = "Search" })
        -- hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
        -- hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
        -- hl(0, "MultiCursorDisabledSign", { link = "SignColumn"})
    end
}
