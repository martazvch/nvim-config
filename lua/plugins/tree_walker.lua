return {
    "aaronik/treewalker.nvim",
    config = function()
        -- movement
        vim.keymap.set({ "n", "v" }, "<C-k>", "<cmd>Treewalker Up<cr>", { silent = true })
        vim.keymap.set({ "n", "v" }, "<C-j>", "<cmd>Treewalker Down<cr>", { silent = true })
        vim.keymap.set({ "n", "v" }, "<C-h>", "<cmd>Treewalker Left<cr>", { silent = true })
        vim.keymap.set({ "n", "v" }, "<C-l>", "<cmd>Treewalker Right<cr>", { silent = true })

        -- swapping
        if vim.loop.os_uname().sysname == "Windows_NT" then
            vim.keymap.set("n", "♠", "<cmd>Treewalker SwapUp<cr>", { noremap = true }) -- ctrl + shift + k
            vim.keymap.set("n", "♡", "<cmd>Treewalker SwapDown<cr>", { noremap = true }) -- ctrl + shift + j
            vim.keymap.set("n", "♢", "<cmd>Treewalker SwapLeft<cr>", { noremap = true }) -- ctrl + shift + h
            vim.keymap.set("n", "♣", "<cmd>Treewalker SwapRight<cr>", { noremap = true }) -- ctrl + shift + l
        else
            vim.keymap.set("n", "<C-S-K>", "<cmd>Treewalker SwapUp<cr>", { silent = true })
            vim.keymap.set("n", "<C-S-J>", "<cmd>Treewalker SwapDown<cr>", { silent = true })
            vim.keymap.set("n", "<C-S-H>", "<cmd>Treewalker SwapLeft<cr>", { silent = true })
            vim.keymap.set("n", "<C-S-L>", "<cmd>Treewalker SwapRight<cr>", { silent = true })
        end
    end,
}
