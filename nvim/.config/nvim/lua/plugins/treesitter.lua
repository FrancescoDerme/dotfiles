return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},

	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			ensure_installed = {
				"lua",
				"c",
				"cpp",
				"markdown",
				"markdown_inline",
				"bash",
				"gitignore",
			},

			auto_install = false,
			highlight = { enable = true },
			indent = { enable = true },
			incremental_selection = {
				enable = false,

				-- This is made useless by Flash
				--[[
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                }
                ]]
			},
		})
	end,
}
