return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        ---@param mapping wk.Mapping
        filter = function(mapping)
            -- Hide keys whose description starts with "Disabled"
            if mapping.desc and mapping.desc:match("^Disable") then
                return false
            end

            return mapping.desc and mapping.desc ~= ""
        end,
        win = {
            height = { min = 4, max = 8 },
        },
        spec = {
            {
                mode = { "n" },
                { "<leader>", group = "Keymaps" },
                { "<leader>d", group = "Directory" },
                { "<leader>l", group = "LSP" },
                { "<leader>f", group = "Find" },
                { "<leader>t", group = "Tuna" },
                { "<leader>td", group = "Download" },
                { "<leader>tg", group = "Go to" },
                { "]", group = "Next" },
                { "[", group = "Previous" },
            },
        },
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "",
        },
    },
}
