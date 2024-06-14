return {
    "https://github.com/LukasPietzschmann/telescope-tabs",
    config = function ()
        vim.keymap.set("n", "<leader>pt", ":lua require('telescope-tabs').list_tabs()<CR>")
    end
}
