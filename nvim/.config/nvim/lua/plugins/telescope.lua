return {
    "nvim-telescope/telescope.nvim",
    branch = "master",
    -- Loaded by :Telescope, or when its modules are required (e.g. by <leader>fb)
    cmd = "Telescope",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-telescope/telescope-ui-select.nvim",
    },

    init = function()
        -- Replaced by telescope-ui-select when telescope loads (e.g. code actions)
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.ui.select = function(...)
            require("telescope")
            return vim.ui.select(...)
        end
    end,

    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                mappings = {
                    i = {
                        ["<M-j>"] = actions.move_selection_next,
                        ["<M-k>"] = actions.move_selection_previous,
                    },
                },
            },
        })

        telescope.load_extension("fzf")
        telescope.load_extension("ui-select")
    end,
}
