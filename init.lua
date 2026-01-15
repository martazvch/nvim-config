local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("vim-options")
require("diagnostics")

-- Allow to move selected lines up and down
require("lazy").setup("plugins")

-- Default theme
vim.cmd.colorscheme("kanagawa-wave")
-- vim.cmd('colorscheme github_dark')

-- Blink theme
local k = require("kanagawa.colors").setup({ theme = "wave" })
local p = k.palette

-- Main menu
vim.api.nvim_set_hl(0, "BlinkCmpMenu", { fg = p.fujiWhite, bg = p.sumiInk4 })
vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = p.sumiInk2, bg = p.sumiInk4 })

-- Selected item (darker, clearer)
vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { fg = p.fujiWhite, bg = p.waveBlue2, bold = true })

-- Completion kinds
vim.api.nvim_set_hl(0, "BlinkCmpKind", { fg = p.springGreen })
vim.api.nvim_set_hl(0, "BlinkCmpKindText", { fg = p.springGreen })

vim.cmd("hi Beacon guibg=grey")

vim.filetype.add({
    extension = {
        ray = "rust",
    },
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "TextChanged", "TextChangedI" }, {
    pattern = { "*.zig" },
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        local ns = vim.api.nvim_create_namespace("zig_enum_literals")

        vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

        for i, line in ipairs(lines) do
            -- Skip commented lines (starting with //, ignoring whitespace)
            if line:match("^%s*//") then
                goto continue
            end

            -- Pattern 1: simple .Tag
            local start = 1
            while true do
                local s, e = string.find(line, "[%s%(={,]%.%a[%w_]*", start)
                if not s then break end

                -- exclude the prefix from highlight
                local dot_start = s + 1 -- the dot itself
                local next_char = line:sub(e + 1, e + 1) or ""
                if next_char ~= "(" then
                    vim.api.nvim_buf_add_highlight(bufnr, ns, "ZigEnumLiteral", i - 1, dot_start - 1, e)
                end
                start = e + 1
            end

            -- Pattern 2: quoted .@"foo"
            start = 1
            while true do
                local s, e = string.find(line, '[%s%(={,]%.@"[^"]-"', start)
                if not s then break end

                local dot_start = s + 1
                local next_char = line:sub(e + 1, e + 1) or ""
                if next_char ~= "(" then
                    vim.api.nvim_buf_add_highlight(bufnr, ns, "ZigEnumLiteral", i - 1, dot_start - 1, e)
                end
                start = e + 1
            end

            ::continue::
        end
    end,
})

-- Kanagawa Wave highlight
vim.api.nvim_set_hl(0, "ZigEnumLiteral", { fg = "#E6C384", bold = false })

-- autocmds
vim.api.nvim_create_autocmd('BufWinEnter', {
    pattern = { '*.md' },
    callback = function()
        vim.keymap.set({ "n", "o", "x" }, "j", "gj", {})
        vim.keymap.set({ "n", "o", "x" }, "k", "gk", {})
        vim.cmd([[set wrap]])
    end,
})

vim.api.nvim_create_autocmd({ 'BufWinLeave' }, {
    pattern = { '*.md' },
    callback = function()
        vim.keymap.set({ "n", "o", "x" }, "j", "j", {})
        vim.keymap.set({ "n", "o", "x" }, "k", "k", {})
        vim.cmd([[unset wrap]])
    end,
})
