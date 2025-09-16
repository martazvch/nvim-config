return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "saghen/blink.cmp" },
        config = function()
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            local function on_attach(client, bufnr)
                local opts = { buffer = bufnr }
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "za", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "zs", vim.lsp.buf.workspace_symbol, opts)
                vim.keymap.set("n", "zi", vim.diagnostic.open_float, opts)
                vim.keymap.set("n", "zn", vim.diagnostic.goto_next, opts)
                vim.keymap.set("n", "zp", vim.diagnostic.goto_prev, opts)
                vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})

                if client.server_capabilities.documentFormattingProvider then
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        callback = function()
                            vim.lsp.buf.format({ async = false })
                        end,
                    })
                end
            end

            -- Mason installs binaries in this path
            local bin_path = vim.fn.stdpath("data") .. "/mason/bin/"

            -- Lua LS
            vim.lsp.config("lua_ls", {
                capabilities = capabilities,
                on_attach = on_attach,
                cmd = { bin_path .. "lua-language-server" .. (vim.loop.os_uname().sysname == "Windows_NT" and ".cmd" or "") },
            })
            vim.lsp.enable("lua_ls")

            -- Zig LS
            vim.lsp.config("zls", {
                capabilities = capabilities,
                on_attach = on_attach,
                settings = { zls = { enable_build_on_save = true } },
                cmd = { "zls" },
            })
            vim.lsp.enable("zls")

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

            -- Python
            vim.lsp.config("pyright", {
                capabilities = capabilities,
                on_attach = on_attach,
                cmd = { bin_path .. "pyright-langserver", "--stdio" },
            })
            vim.lsp.enable("pyright")

            -- Rust
            vim.lsp.config("rust_analyzer", {
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    on_attach(client, bufnr)
                    local opts = { buffer = bufnr }
                    vim.keymap.set("n", "rt", ":RustLsp testables<CR>", opts)
                    vim.keymap.set("n", "re", ":RustLsp explainError<CR>", opts)
                    vim.keymap.set("n", "rd", ":RustLsp renderDiagnostic<CR>", opts)
                    vim.keymap.set("n", "rc", ":RustLsp openCargo<CR>", opts)
                    vim.keymap.set({ "n", "v" }, "rj", ":RustLsp joinLines<CR>", opts)
                    vim.keymap.set({ "n", "v" }, "<A-up>", ":RustLsp moveItem up<CR>", opts)
                    vim.keymap.set({ "n", "v" }, "<A-down>", ":RustLsp moveItem down<CR>", opts)
                end,
                cmd = { bin_path .. "rust-analyzer" },
            })
            vim.lsp.enable("rust_analyzer")
        end,
    },
}
