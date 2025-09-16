return {
	"RRethy/vim-illuminate",
    config  = function ()
        vim.keymap.del("x", "<A-i>")
        vim.keymap.del("o", "<A-i>")
    end
}
