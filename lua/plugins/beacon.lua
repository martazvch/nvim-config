return {
    -- Show cursor when jumping arround to keep track visually
	"danilamihailov/beacon.nvim",
    config = function ()
        require("beacon").setup({
            speed = 3,
            winblend = 0, -- For transparency
            highlight = { bg = 'grey', ctermbg = 15 },
        })
    end
}
