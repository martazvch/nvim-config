return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "rust_analyzer" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")

            local on_attach = function(client, bufnr)
                local opts = { buffer=bufnr }

                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
                -- Show a tab with all symbols of workspace and we can jump to them
                vim.keymap.set({ "n", "v" }, "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
                -- Open a file dialog with diagnostic of element under cursor
                vim.keymap.set({ "n", "v" }, "<leader>di", vim.diagnostic.open_float, opts)
                -- Go to next element in file that has a diagnostic
                vim.keymap.set({ "n", "v" }, ")d", vim.diagnostic.goto_next, opts)
                -- Go to previous element in file that has a diagnostic
                vim.keymap.set({ "n", "v" }, "(d", vim.diagnostic.goto_prev, opts)
            end

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
                on_attach = on_attach,
			})
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
                on_attach = on_attach,
			})

		end,
	},
}
