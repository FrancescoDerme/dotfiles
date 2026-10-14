return {
    "stevearc/oil.nvim",
    opts = {},
    dependencies = {
        {
            "nvim-mini/mini.icons",
            opts = {},
            config = function(_, opts)
                require("mini.icons").setup(opts)
                -- Pretend to be nvim-web-devicons, for plugins that use it (neo-tree, telescope, ...)
                require("mini.icons").mock_nvim_web_devicons()
            end,
        },
    },
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
}
