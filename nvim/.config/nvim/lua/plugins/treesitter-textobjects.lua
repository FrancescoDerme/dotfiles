return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	lazy = true,
	config = function()
		require("nvim-treesitter.configs").setup({
			textobjects = {
				select = {
					enable = true,
					lookahead = true,

					keymaps = {
						["=o"] = { query = "@assignment.outer", desc = "Select outer assignment" },
						["=i"] = { query = "@assignment.inner", desc = "Select inner assignment" },
						["=l"] = { query = "@assignment.lhs", desc = "Select left assignment" },
						["=r"] = { query = "@assignment.rhs", desc = "Select right assignment" },
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					-- The specific mappings are specified inside the demicolon plugin configuration file
				},
			},
		})
	end,
}
