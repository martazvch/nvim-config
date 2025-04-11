return {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        -- configure codelldb adapter
        dap.adapters.codelldb = {
            type = "server",
            port = "${port}",
            executable = {
                command = "/Users/mvachero/.vscode/extensions/vadimcn.vscode-lldb-1.11.4/adapter/codelldb",
                args = { "--port", "${port}" },
            },
        }

        -- setup a debugger config for zig projects
        dap.configurations.zig = {
            {
                name = "Launch",
                type = "codelldb",
                request = "launch",
                program = "${workspaceFolder}/zig-out/bin/rover",
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
                args = { "test.rv" },
            },
        }

        vim.keymap.set("n", "<leader>b", ":DapToggleBreakpoint<CR>")
        vim.keymap.set("n", "<leader>dc", dap.continue)
        vim.keymap.set("n", "<leader>di", dap.step_into)
        vim.keymap.set("n", "<leader>dn", dap.step_over)
        vim.keymap.set("n", "<leader>df", dap.step_out)
        vim.keymap.set("n", "<leader>dt", dap.terminate)

        vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
        vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#FF5555" })

        -- dapui.setup()
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        dapui.setup({
            layouts = {
                {
                    elements = {
                        {
                            id = "breakpoints",
                            size = 0.15,
                        },

                        {
                            id = "stacks",
                            size = 0.15,
                        },
                        {
                            id = "scopes",
                            size = 0.7,
                        },
                        -- {
                        --     id = "watches",
                        --     size = 0.25,
                        -- },
                    },
                    position = "left",
                    size = 60,
                },
                {
                    elements = {
                        {
                            id = "repl",
                            size = 0.5,
                        },
                        {
                            id = "console",
                            size = 0.5,
                        },
                    },
                    position = "bottom",
                    size = 15,
                },
            },
            mappings = {
                edit = "e",
                expand = { "<2-LeftMouse>" },
                open = "o",
                remove = "d",
                repl = "r",
                toggle = "t",
            },
        })
    end,
}
