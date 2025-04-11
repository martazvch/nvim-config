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
                ensure_installed = { "lua_ls", "rust_analyzer", "zls", "pyright" },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "saghen/blink.cmp" },

        -- example using `opts` for defining servers
        opts = {
            servers = {
                lua_ls = {},
                zls = {},
                pyright = {},
                ["rust-analyzer"] = {},
            },
        },
        config = function(_, opts)
            local lspconfig = require("lspconfig")
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            local on_attach = function(client, bufnr)
                local opts = { buffer = bufnr }

                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "gD", function()
                    vim.cmd("vsplit")
                    vim.cmd("wincmd L")
                    vim.lsp.buf.definition()

                    -- Small delay to ensure LSP loads before centering because goto is async
                    vim.defer_fn(function()
                        vim.cmd("normal! zz") -- Center the screen properly
                    end, 100)
                end, opts)
                vim.keymap.set({ "n", "v" }, "za", vim.lsp.buf.code_action, opts)
                -- Show a tab with all symbols of workspace and we can jump to them
                vim.keymap.set({ "n", "v" }, "zs", vim.lsp.buf.workspace_symbol, opts)
                -- Open a file dialog with diagnostic of element under cursor
                vim.keymap.set({ "n", "v" }, "zi", vim.diagnostic.open_float, opts)
                -- Go to next element in file that has a diagnostic
                vim.keymap.set({ "n", "v" }, "zn", vim.diagnostic.goto_next, opts)
                -- Go to previous element in file that has a diagnostic
                vim.keymap.set({ "n", "v" }, "zp", vim.diagnostic.goto_prev, opts)
            end

            local path = vim.loop.os_uname().sysname == "Windows_NT" and bin_path .. "lua-language-server.cmd"
                or "lua-language-server"

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                cmd = { path },
            })

            ----------------
            -- Zig config --
            ----------------
            lspconfig.zls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    zls = { enable_build_on_save = true },
                },
            })

            -- Don't parse error in separate window
            vim.g.zig_fmt_parse_errors = 0

            -- Code action for auto adding/removing discard
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = { "*.zig", "*.zon" },
                callback = function(ev)
                    vim.lsp.buf.format()
                    vim.lsp.buf.code_action({
                        context = { only = { "source.fixAll" } },
                        apply = true,
                    })
                end,
            })

            -- Code action for sorting imports
            -- vim.api.nvim_create_autocmd("BufWritePre", {
            --     pattern = { "*.zig", "*.zon" },
            --     callback = function(ev)
            --         vim.lsp.buf.code_action({
            --             context = { only = { "source.organizeImports" } },
            --             apply = true,
            --         })
            --     end,
            -- })

            -------------------
            -- Python config --
            -------------------
            lspconfig.pyright.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })

            -- Rust config via rustacean
            vim.g.rustaceanvim = {
                server = {
                    on_attach = function(client, bufnr)
                        local opts = { buffer = bufnr }

                        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                        vim.keymap.set({ "n", "v" }, "za", vim.lsp.buf.code_action, opts)
                        -- Show a tab with all symbols of workspace and we can jump to them
                        vim.keymap.set({ "n", "v" }, "zs", vim.lsp.buf.workspace_symbol, opts)
                        -- Open a file dialog with diagnostic of element under cursor
                        vim.keymap.set({ "n", "v" }, "zi", vim.diagnostic.open_float, opts)
                        -- Go to next element in file that has a diagnostic
                        vim.keymap.set({ "n", "v" }, "zn", vim.diagnostic.goto_next, opts)
                        -- Go to previous element in file that has a diagnostic
                        vim.keymap.set({ "n", "v" }, "zp", vim.diagnostic.goto_prev, opts)
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
                        vim.keymap.set({ "n", "v" }, "<A-up>", ":RustLsp moveItem up<CR>")
                        vim.keymap.set({ "n", "v" }, "<A-down>", ":RustLsp moveItem down<CR>")
                    end,
                },
            }
        end,
    },
}
-- 	{
-- 		"neovim/nvim-lspconfig",
-- 		config = function()
-- 			local capabilities = require("cmp_nvim_lsp").default_capabilities()
--
-- 			local lspconfig = require("lspconfig")
--
-- 			local on_attach = function(client, bufnr)
-- 				local opts = { buffer = bufnr }
--
-- 				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
-- 				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
-- 				vim.keymap.set({ "n", "v" }, "za", vim.lsp.buf.code_action, opts)
-- 				-- Show a tab with all symbols of workspace and we can jump to them
-- 				vim.keymap.set({ "n", "v" }, "zs", vim.lsp.buf.workspace_symbol, opts)
-- 				-- Open a file dialog with diagnostic of element under cursor
-- 				vim.keymap.set({ "n", "v" }, "zi", vim.diagnostic.open_float, opts)
-- 				-- Go to next element in file that has a diagnostic
-- 				vim.keymap.set({ "n", "v" }, "zn", vim.diagnostic.goto_next, opts)
-- 				-- Go to previous element in file that has a diagnostic
-- 				vim.keymap.set({ "n", "v" }, "zp", vim.diagnostic.goto_prev, opts)
-- 			end
--
-- 			local path = vim.loop.os_uname().sysname == "Windows_NT" and bin_path .. "lua-language-server.cmd"
-- 				or "lua-language-server"
--
-- 			lspconfig.lua_ls.setup({
-- 				capabilities = capabilities,
-- 				on_attach = on_attach,
-- 				cmd = { path },
-- 			})
--
-- 			lspconfig.zls.setup({
-- 				capabilities = capabilities,
-- 				on_attach = on_attach,
-- 			})
--
-- 			-- NOTE:https://github.com/zigtools/zls/issues/856#issuecomment-1511528925
-- 			-- fixes the fact of opening quickfix automatically when there are erros
-- 			vim.g.zig_fmt_parse_errors = 0
--
-- 			-- 		end,
-- 	},
-- }
