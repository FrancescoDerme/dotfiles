return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
        styles = {
            -- Set italic to false to keep the standard code font
            comments = { italic = false },
            keywords = { italic = false },
        },
    },
    config = function(_, opts)
        -- Feed the opts table into the setup function
        require("tokyonight").setup(opts)
        -- Apply the colorscheme
        vim.cmd([[colorscheme tokyonight]])
    end,
}
