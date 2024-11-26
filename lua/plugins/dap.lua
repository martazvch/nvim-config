return {
    "mfussenegger/nvim-dap",
    lazy = true,
    config = function()
        local dap = require("dap")

        dap.adapters.lldb = {
            type = "executable",
            command = "C:\\Users\\33634\\.vscode\\extensions\\vadimcn.vscode-lldb-1.10.0\\lldb\\bin\\lldb.exe",
            name = "lldb",
        }

        dap.configurations.zig = {
            {
                name = "launch",
                type = "lldb",
                request = "launch",
                program = "${workspaceFolder}/zig-out/bin/rizon.exe",
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
                args = {},
            }
        }

        vim.keymap.set("n", "<leader>b", ":DapToggleBreakpoint<CR>")
        vim.keymap.set("n", "<F1>", ":DapContinue<CR>")
        vim.keymap.set("n", "<F2>", ":DapStepInto<CR>")
        vim.keymap.set("n", "<F3>", ":DapStepOver<CR>")
        vim.keymap.set("n", "<F4>", ":DapStepOut<CR>")
        vim.keymap.set("n", "<F5>", ":DapRestartFrame<CR>")
        vim.keymap.set("n", "<F6>", ":DapTerminate<CR>")
    end,
}
