return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local auto = require("lualine.themes.auto")
        local lualine_modes = { "insert", "normal", "visual", "command", "replace", "inactive", "terminal" }
        for _, field in ipairs(lualine_modes) do
            if auto[field] and auto[field].c then
                auto[field].c.bg = "NONE"
            end
        end

        require("lualine").setup({
            options = {
                theme = auto,
                -- theme = "auto",
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "diagnostics" },
                lualine_c = { "filename" },
                lualine_x = {},
                lualine_y = { "filetype" },
                lualine_z = { "os.date('%H:%M')" },
            },
        })
    end,
}
