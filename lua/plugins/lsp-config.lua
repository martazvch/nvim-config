-- https://www.reddit.com/r/neovim/comments/1cx05ws/spawning_lsp_servers_fails_regularly/
local bin_path = "C:/Users/33634/AppData/Local/nvim-data/mason/bin/"

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
                vim.keymap.set({ "n", "v" }, "ca", vim.lsp.buf.code_action, opts)
                -- Show a tab with all symbols of workspace and we can jump to them
                vim.keymap.set({ "n", "v" }, "ds", vim.lsp.buf.workspace_symbol, opts)
                -- Open a file dialog with diagnostic of element under cursor
                vim.keymap.set({ "n", "v" }, "di", vim.diagnostic.open_float, opts)
                -- Go to next element in file that has a diagnostic
                vim.keymap.set({ "n", "v" }, "dn", vim.diagnostic.goto_next, opts)
                -- Go to previous element in file that has a diagnostic
                vim.keymap.set({ "n", "v" }, "dp", vim.diagnostic.goto_prev, opts)
            end

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
                on_attach = on_attach,
                cmd = { bin_path .. "lua-language-server.cmd" },
			})

            -- Rust config via rustacean
            vim.g.rustaceanvim = {
                server = {
                    on_attach = function(client, bufnr)
                        local opts = { buffer=bufnr }

                        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                        vim.keymap.set({ "n", "v" }, "da", vim.lsp.buf.code_action, opts)
                        -- Show a tab with all symbols of workspace and we can jump to them
                        vim.keymap.set({ "n", "v" }, "ds", vim.lsp.buf.workspace_symbol, opts)
                        -- Open a file dialog with diagnostic of element under cursor
                        vim.keymap.set({ "n", "v" }, "di", vim.diagnostic.open_float, opts)
                        -- Go to next element in file that has a diagnostic
                        vim.keymap.set({ "n", "v" }, "dn", vim.diagnostic.goto_next, opts)
                        -- Go to previous element in file that has a diagnostic
                        vim.keymap.set({ "n", "v" }, "dp", vim.diagnostic.goto_prev, opts)
                        -- Launch tests
                        vim.keymap.set("n", "rt", ":RustLsp testables<CR>")
                        -- Explain error
                        vim.keymap.set("n", "re", ":RustLsp explainError<CR>")
                        -- Render diagnostic (cycles like goto_next diag)
                        vim.keymap.set("n", "rd", ":RustLsp renderDiagnostic<CR>")
                        -- Open Cargo.toml
                        vim.keymap.set("n", "rc", ":RustLsp openCargo<CR>")
                        -- Join lines
                        vim.keymap.set({ "n", "v" }, "rj", ":RustLsp joinLines<CR>")
                        -- Move item up/down
                        vim.keymap.set({"n", "v" }, "<A-up>", ":RustLsp moveItem up<CR>")
                        vim.keymap.set({"n", "v" }, "<A-down>", ":RustLsp moveItem down<CR>")
                    end
                }
            }
		end,
	},
}
