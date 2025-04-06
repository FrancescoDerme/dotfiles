return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        spec = {
            {
                mode = {"n"},
                {"<leader>", group = "Plugins"},
                {"<leader>f", group = "Find"},
                {"<leader>c", group = "Competitest"},
                {"<leader>cd", group = "Competitest download"},
                {"<leader>o", group = "Oil"},
            },
        },
    },
    keys = {
        {
            "<leader>?",
            function() require("which-key").show({ global = false }) end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
}
