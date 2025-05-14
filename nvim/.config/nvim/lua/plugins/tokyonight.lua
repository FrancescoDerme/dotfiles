return {
	--"folke/tokyonight.nvim",
	"ellisonleao/gruvbox.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		--vim.cmd([[colorscheme tokyonight]])

		vim.o.background = "dark"
		vim.cmd([[colorscheme gruvbox]])
	end,
}
