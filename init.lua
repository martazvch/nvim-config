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

-- Must be initialized after lsp
-- require("lsp_lines").setup()

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
--require("telescope").load_extension("fzf")

-- Default theme
vim.cmd.colorscheme("catppuccin-frappe")
-- vim.cmd.colorscheme("nordic")
-- vim.cmd.colorscheme("kanagawa")

-- Toogles between transparent bg or not
local toggle_transp_bg = function()
    local opts = require("catppuccin").options
    local bg = not opts.transparent_background
    opts.transparent_background = bg

    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin-frappe")

    if bg then
        vim.cmd("hi Normal guibg=NONE ctermbg=NONE")           -- focused buffer
        vim.cmd("hi NormalNC guibg=NONE ctermbg=NONE")         -- unfocused buffer
        vim.cmd("hi TelescopeSelection guibg=#414559 guifg=#c6d0f5") -- normal mode with catppuccin

        -- NeoTree
        -- vim.cmd("hi NeoTreeNormal guibg=NONE")
        -- vim.cmd("hi NeoTreeNormalNC guibg=NONE")
        -- vim.cmd("hi NeoTreeWinSeparator guibg=NONE")
    end

    -- Hack to make it always same color
    vim.cmd("hi Beacon guibg=grey")
end

-- vim.keymap.set("n", "<leader>b", toggle_transp_bg, { expr = true })
vim.api.nvim_create_user_command("ToggleTranspBg", toggle_transp_bg, {})

vim.cmd("hi Beacon guibg=grey")
-- Transparent on startup
-- toggle_transp_bg()

--- Arrow ---
-- Next / previous marked files
vim.keymap.set("n", "<A-p>", require("arrow.persist").previous)
vim.keymap.set("n", "<A-n>", require("arrow.persist").next)

vim.filetype.add({
    extension = {
        rv = "rust",
    },
})
