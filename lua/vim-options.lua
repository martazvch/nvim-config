-- Spaces instead of tabs
vim.cmd("set number relativenumber")
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

vim.g.mapleader = " "
vim.opt.smartindent = true
vim.opt.wrap = false
-- Dosen't keep highlight on searched words
vim.opt.hlsearch = false
-- Allow to search like: /vim.in*
vim.opt.incsearch = true
vim.opt.scrolloff = 12
-- Allow to copy paste in system clipboard
vim.opt.clipboard = "unnamedplus"

-- Keymaps

-- Quick save
vim.keymap.set("n", "<leader>w", ":w<CR>")

-- Auto indent when entering insert mode
local function smart_indent()
    local line = vim.api.nvim_get_current_line()
    if line == "" then
        return "\"_cc"
    else
        return "i"
    end
end

-- Blocks
vim.keymap.set("n", "vù", "vib") -- Select all inside (
vim.keymap.set("n", "v%", "vab") -- Select all inside + (
vim.keymap.set("n", "v*", "viB") -- Select all inside {
vim.keymap.set("n", "vµ", "vaB") -- Select all inside + {
vim.keymap.set("n", "yù", "yib") 
vim.keymap.set("n", "y%", "yab") 
vim.keymap.set("n", "y*", "yiB") 
vim.keymap.set("n", "yµ", "yaB") 

-- Smart ident on insert mode on blank line
-- expr = true says that it is an expression to evaluate and we take
-- the return value of the expression
vim.keymap.set("n", "i", smart_indent, { expr = true })

-- Allow to move selected lines up and down
vim.keymap.set("v", "J", "m: '>+1<CR>gv=gv")
vim.keymap.set("v", "K", "m: '>-2<CR>gv=gv")
-- Append the next line to the previous one without moving the cursor
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- When moving to next searched term, keep the cursor at the middle of the file
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
-- Paste without replacing the copy buffer
vim.keymap.set("x", "<leader>p", '"_dP')
-- Copy into system clipboard so we can paste outside nvim
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
-- Delete into void registry
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')
-- Inlay hint toggle
vim.keymap.set({ "n", "v" }, "<leader>hi", ":lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>", {})

-- Switch tabs
vim.keymap.set("n", "<leader>to", ":tabe<CR>")
vim.keymap.set("n", "<leader>tc", ":tabc<CR>")
vim.keymap.set("n", "<leader>tp", ":tabp<CR>")
vim.keymap.set("n", "<leader>tn", ":tabn<CR>")

-- Navigation
vim.keymap.set("n", "<C-Left>", "<C-w>h")
vim.keymap.set("n", "<C-Right>", "<C-w>l")

-- Return to beginning of first word on line instead of the complete beginning
vim.keymap.set("n", "0", "0w")

-- Begin replacement with word under cursor
vim.keymap.set("n", "<leader>z", ":%s/<C-r><C-w>/")

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
  local target_path = vim.fn.expand('~/.config/nvim/undodir')
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

vim.keymap.set("n", "<leader>ls", load_session)
