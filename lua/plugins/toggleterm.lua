return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        local settings = {
            direction = "float",
            persist_mode = false,
        }

        if vim.loop.os_uname().sysname == "Windows_NT" then
            settings.shell = "powershell"
        else
            settings.on_create = function(term)
                vim.api.nvim_chan_send(term.job_id, "source ~/.zprofile\n")
            end
        end

        require("toggleterm").setup(settings)

        -- Floating terminal (default direction)
        local float_term = require("toggleterm.terminal").Terminal:new({
            direction = "float",
        })

        vim.keymap.set("n", "<A-z>", function()
            float_term:toggle()
        end)
        vim.keymap.set("t", "<A-z>", "<C-\\><C-n>:ToggleTerm<CR>")

        local Terminal = require("toggleterm.terminal").Terminal

        -- Vertical terminal with manual resize
        local vterm = Terminal:new({
            direction = "vertical",
            on_open = function(term)
                -- Resize to half the screen width *after* terminal opens
                local win_id = vim.api.nvim_get_current_win()
                local half_width = math.floor(vim.o.columns / 2)
                vim.api.nvim_win_set_width(win_id, half_width)
            end,
        })

        vim.api.nvim_create_user_command("VTerm", function()
            vterm:toggle()
        end, {})

        vim.keymap.set("n", "<A-v>", function() vterm:toggle() end)
        vim.keymap.set("t", "<A-v>", "<C-\\><C-n>:VTerm<CR>")
    end,
}
