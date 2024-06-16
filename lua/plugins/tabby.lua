local function tab_modified(tab)
    local wins = require("tabby.module.api").get_tab_wins(tab)
    for _, x in pairs(wins) do
        if vim.bo[vim.api.nvim_win_get_buf(x)].modified then
            return ""
        end
    end
    return ""
end

local function lsp_diag(buf)
    local diagnostics = vim.diagnostic.get(buf)
    local count = {0, 0, 0, 0}

    for _, diagnostic in ipairs(diagnostics) do
        count[diagnostic.severity] = count[diagnostic.severity] + 1
    end
    if count[1] > 0 then
        return vim.bo[buf].modified and "" or ""
    elseif count[2] > 0 then
        return vim.bo[buf].modified and "" or ""
    end
    return vim.bo[buf].modified and "" or ""
end

local function buffer_name(buf)
    if string.find(buf,"NvimTree") then
        return "NvimTree"
    end
    return buf
end

-- Color scheme
local palette = require("catppuccin.palettes").get_palette("macchiato")

local theme = {
  fill = 'TabLineFill',
  head = 'TabLine',
  current_tab = { fg = palette.blue, bg = palette.base },
  inactive_tab = 'TabLine',
  tab = 'TabLine',
  win = 'TabLine',
  tail = 'TabLine',
}

return {
    "nanozuki/tabby.nvim",
    config = function ()
        require("tabby").setup({
            option = {
                theme = theme,
            },
        })

        require('tabby.tabline').set(function(line)
            return {
                line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
                    local hl = win.is_current() and theme.current_tab or theme.inactive_tab
                    local win_nb = win.id
                    local bg = theme.head

                    return {
                        line.sep('', hl, bg, theme.fill),
                        win.file_icon(),
                        buffer_name(win.buf_name()),
                        lsp_diag(win.buf().id),
                        line.sep('', hl, theme.head, theme.fill),
                        hl = hl,
                        margin = ' ',
                    }
                end),
                line.spacer(),
                line.tabs().foreach(function(tab)
                    local hl = tab.is_current() and theme.current_tab or theme.tab
                    return {
                        line.sep('', hl, theme.head, theme.fill),
                        tab.number(),
                        tab_modified(tab.id),
                        line.sep('', hl, theme.head, theme.fill),
                        hl = hl,
                        margin = ' ',
                    }
                end),
                hl = theme.head,
            }
        end)
    end
}

