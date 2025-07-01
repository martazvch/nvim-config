local function focus_or_open(filename)
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		local bufname = vim.api.nvim_buf_get_name(buf)
		if vim.fn.fnamemodify(bufname, ":p") == vim.fn.fnamemodify(filename, ":p") then
			vim.api.nvim_set_current_win(win)
			return
		end
	end
	vim.cmd("tabnew " .. vim.fn.fnameescape(filename))
end

return {
	"otavioschwanck/arrow.nvim",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
		-- or if using `mini.icons`
		-- { "echasnovski/mini.icons" },
	},
	opts = {
		show_icons = true,
		leader_key = "ù", -- Recommended to be a single key
		buffer_leader_key = "=", -- Per Buffer Mappings
		custom_actions = {
			open = function(target_file_name, current_file_name)
				focus_or_open(target_file_name)
			end,
		},
	},
}
