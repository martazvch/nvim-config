local function toggle_lsp_lines()
	require("lsp_lines").toggle()

	-- Deactivate end of line diagnostics to avoid double msg
	vim.diagnostic.config({
		virtual_text = not vim.diagnostic.config().virtual_text,
	})
end

return {
	"maan2003/lsp_lines.nvim",
    lazy = true,
	config = function()
		vim.diagnostic.config({ virtual_text = true })
		vim.keymap.set("n", "<leader>l", toggle_lsp_lines)
	end,
}
