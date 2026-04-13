return {
    "folke/trouble.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        { "<leader>xx", "<cmd>Trouble diagnostics toggle focus=true<cr>",              desc = "Diagnostics (Trouble)" },
        { "<leader>xw", "<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>", desc = "Buffer Diagnostics (Trouble)" },
        { "<leader>xq", "<cmd>Trouble qflist toggle<cr>",                              desc = "Quickfix (Trouble)" },
        { "<leader>xl", "<cmd>Trouble loclist toggle<cr>",                             desc = "Loclist (Trouble)" },
        { "gR",         "<cmd>Trouble lsp_references toggle<cr>",                      desc = "LSP References (Trouble)" },
    },
}
