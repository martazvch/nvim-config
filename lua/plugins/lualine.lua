return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        -- local auto = require("lualine.themes.auto")
        -- local lualine_modes = { "insert", "normal", "visual", "command", "replace", "inactive", "terminal" }
        -- for _, field in ipairs(lualine_modes) do
        --     if auto[field] and auto[field].c then
        --         auto[field].c.bg = "NONE"
        --     end
        -- end

        local catppuccin = require("lualine.themes.catppuccin")
        -- Colors of 'Normal' highlight group for catppuccin frappe
        catppuccin.normal.c.fg = "#c6d0f5"
        catppuccin.normal.c.bg = "#303446"

        catppuccin.inactive.a.bg = "#303446"
        catppuccin.inactive.b.bg = "#303446"
        catppuccin.inactive.c.bg = "#303446"

        require("lualine").setup({
            options = {
                -- theme = "auto",
                theme = catppuccin,
                -- component_separators = { left = "", right = "" },
                component_separators = "",
                -- section_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "diagnostics" },
                lualine_c = {},
                -- lualine_c = { "filename" },
                lualine_x = {},
                -- lualine_y = { "filetype" },
                lualine_y = {
                    {
                        "filetype",
                        colored = true, -- Displays filetype icon in color if set to true
                        icon_only = true, -- Display only an icon for filetype
                        icon = { align = "right" }, -- Display filetype icon on the right hand side
                    },
                    { "filename" },
                },
                -- lualine_z = { "os.date('%H:%M')" },
                lualine_z = { "progress" },
            },
        })
    end,
}
