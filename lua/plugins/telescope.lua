return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local actions = require("telescope.actions")
			require("telescope").setup({
				defaults = {
					-- Define custom mappings
					mappings = {
						i = { -- Insert mode mappings
							["<A-y>"] = actions.select_vertical,
						},
						n = { -- Normal mode mappings
							["<A-y>"] = actions.select_vertical,
						},
					},
				},
			})

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "te", builtin.find_files, {})
			vim.keymap.set("n", "tg", builtin.live_grep, {})

			-- Keymap to search only in Zig files
			vim.keymap.set("n", "tz", function()
				require("telescope.builtin").find_files({
					prompt_title = "Find Zig Files",
					find_command = { "rg", "--files", "--glob", "*.zig" },
				})
			end, { desc = "Search only Zig files" })
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})

			require("telescope").load_extension("ui-select")
		end,
	},
}
