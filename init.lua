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

-- require("vim._core.ui2").enable({})

require("vim-options")
require("diagnostics")

vim.o.winborder = "rounded"

-- Allow to move selected lines up and down
require("lazy").setup("plugins")

-- Default theme
-- vim.cmd.colorscheme("kanagawa-wave")
vim.cmd.colorscheme("catppuccin-mocha")
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
        rayn = "rust",
    },
})

vim.cmd("packadd nvim.undotree")
vim.keymap.set("n", "<leader>u", require("undotree").open)



-- -- Kanagawa Wave highlight
-- vim.api.nvim_set_hl(0, "ZigEnumLiteral", { fg = "#E6C384", bold = false })

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
