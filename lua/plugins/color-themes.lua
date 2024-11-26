return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				no_italic = true,
				styles = {
					comments = { "italic" },
					conditionals = {},
				},
				highlight_overrides = {
					all = function(colors)
						return {
							["@keyword.self"] = { fg = colors.mauve },
							["@parameter"] = { fg = colors.flamingo },
							["@lsp.type.enumMember"] = { fg = "#81c8be" },
						}
					end,
				},
			})
		end,
	},
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		lazy = true,
		config = function()
			require("tokyonight").setup({
				styles = {
					-- Default set it to italic, it disables it
					comments = { italic = false },
					keywords = { italic = false },
				},
			})
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		priority = 1000,
		lazy = true,
		config = function()
			require("kanagawa").setup({
				commentStyle = { italic = false },
				keywordStyle = { italic = false },
			})
		end,
	},
	{
		"neanias/everforest-nvim",
		lazy = true,
		priority = 1000,
		config = function()
			require("everforest").setup({
				background = "hard",
				show_eob = false, -- Deletes ~ until Eof
				ui_contrast = "high",
			})
		end,
	},
	{
		"EdenEast/nightfox.nvim",
		lazy = true,
	},
	{
		"sam4llis/nvim-tundra",
		lazy = true,
	},
	{
		"rose-pine/neovim",
		lazy = true,
	},
}
