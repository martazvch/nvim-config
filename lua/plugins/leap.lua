return {
    "ggandor/leap.nvim",
    config = function ()
        vim.keymap.set({'n', 'x', 'o'}, 'm',  '<Plug>(leap-forward)')
        vim.keymap.set({'n', 'x', 'o'}, 'M',  '<Plug>(leap-backward)')
        vim.keymap.set({'n', 'x', 'o'}, 'gs', '<Plug>(leap-from-window)')
    end
}
