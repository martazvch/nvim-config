return {
    "https://github.com/LukasPietzschmann/telescope-tabs",
    config = function ()
        vim.keymap.set("n", "tt", ":lua require('telescope-tabs').list_tabs()<CR>")
    end
}
