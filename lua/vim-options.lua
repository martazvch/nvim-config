-- Spaces instead of tabs
vim.cmd("set number relativenumber")
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set showtabline=0") -- 0: never

vim.g.mapleader = " "
vim.opt.smartindent = true
vim.opt.wrap = false
-- Dosen't keep highlight on searched words
vim.opt.hlsearch = false
-- Allow to search like: /vim.in*
vim.opt.incsearch = true
vim.opt.scrolloff = 12
vim.opt.fillchars = "eob: "
-- Allow to copy paste in system clipboard
vim.opt.clipboard = "unnamedplus"
vim.keymap.set("i", "<C-v>", "<C-R>*")

-- Keymaps

-- Quick save
vim.keymap.set("n", "<leader>w", ":w<CR>")

-- Smart insert
local function smart_insert()
    local line = vim.api.nvim_get_current_line()
    if line == "" then
        return '"_cc'
    else
        return "i"
    end
end

-- expr = true says that it is an expression to evaluate
vim.keymap.set("n", "i", smart_insert, { expr = true })

-- Line concat
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "L", "kJ")

-- Centered navigation
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Centered go down, go up
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- Paragraph utils from current line
-- Copy paste paragraphe under
vim.keymap.set("n", "cp", "yap}p")
-- Delete paragraphe
vim.keymap.set("n", "dp", "^d}")
-- Copy paragraphe
vim.keymap.set("n", "yp", "^y}")

-- Copies the lines, comment it and paste it under
-- It's a command as "yygccp" would be treated as a string
vim.keymap.set("n", "<leader>p", function()
    vim.cmd.normal("yygccp")
end, { noremap = true, silent = true })

-- Registers
-- Paste without replacing the copy buffer
vim.keymap.set("x", "p", '"_dP')
-- Make 'c' don't replace what you have in clipboard
vim.keymap.set("n", "c", '"_c')
vim.keymap.set("n", "C", '"_C')

-- Inlay hint toggle
vim.keymap.set({ "n", "v" }, "<leader>hi", ":lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>")

-- Switch tabs
vim.keymap.set("n", "to", ":tabe<CR>")
vim.keymap.set("n", "tc", ":tabc<CR>")
vim.keymap.set("n", "tp", ":tabp<CR>")
vim.keymap.set("n", "tn", ":tabn<CR>")

-- Navigation
if vim.loop.os_uname().sysname == "Windows_NT" then
    vim.keymap.set("n", "<C-Left>", "<C-w>h")
    vim.keymap.set("n", "<C-Right>", "<C-w>l")
else
    vim.keymap.set("n", "<M-h>", "<C-w>h")
    vim.keymap.set("n", "<M-l>", "<C-w>l")
end

-- Begin replacement with word under cursor until EOF or whole file
vim.keymap.set("n", "<leader>ù", ":,$s/<C-r><C-w>/")
vim.keymap.set("n", "<leader>*", ":%s/<C-r><C-w>/")

-- Begin replacement in all file with selected text
vim.keymap.set("v", "<leader>!", function()
    -- Yank the selected text (without affecting other yanks) and get it from the unnamed register
    vim.cmd('normal! "vy')
    -- Get the selected text in visual mode
    local selected_text = vim.fn.escape(vim.fn.getreg('"'), "/\\")
    -- Enter command-line mode and pre-fill with search and replace text
    vim.api.nvim_feedkeys(":%s/" .. selected_text .. "/", "n", false)
end, { desc = "Search and replace selected text" })

-- Begin replacement in current to end of file with selected text
vim.keymap.set("v", "<leader>:", function()
    -- Yank the selected text (without affecting other yanks) and get it from the unnamed register
    vim.cmd('normal! "vy')
    -- Get the selected text in visual mode
    local selected_text = vim.fn.escape(vim.fn.getreg('"'), "/\\")
    -- Enter command-line mode and pre-fill with search and replace text
    vim.api.nvim_feedkeys(":,$s/" .. selected_text .. "/", "n", false)
end, { desc = "Search and replace selected text" })

-- Exit terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- Exit insert mode
vim.keymap.set("i", "<M-e>", "<Esc>:w<CR>")

-- Create an augroup for the yank highlighting
local augroup = vim.api.nvim_create_augroup("YankHighlight", {})

-- Define the autocmd for highlighting on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
    end,
})

-- Set up persistent undo
if vim.fn.has("persistent_undo") == 1 then
    local target_path = vim.fn.expand("~/.config/nvim/undodir")
    if vim.fn.isdirectory(target_path) == 0 then
        vim.fn.mkdir(target_path, "p", 0700)
    end
    vim.opt.undodir = target_path
    vim.opt.undofile = true
end

------------------------------------------------------
---          Saves and loads last session
------------------------------------------------------

local save_session = function()
    -- Automatically save the session when exiting Neovim
    local fn = vim.fn

    -- Function to check directory and create if it doesn't exist
    local nvim_dir = fn.expand("C:\\Users\\33634\\.config\\nvim")
    if fn.isdirectory(nvim_dir) == 0 then
        fn.mkdir(nvim_dir, "p")
    end

    vim.cmd("mksession! C:\\Users\\33634\\.config\\nvim\\session.vim")
end

vim.keymap.set("n", "<leader>ss", save_session)

local load_session = function()
    -- Automatically load the session when starting Neovim
    local session_file = vim.fn.expand("C:\\Users\\33634\\.config\\nvim\\session.vim")

    if vim.fn.filereadable(session_file) == 1 then
        vim.cmd("source " .. session_file)
    end
end

vim.keymap.set("n", "<leader>sl", load_session)
