return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = true,
	opts = {
		size = function(term)
			if term.direction == "horizontal" then
				return 15
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.5
			end
		end,
		open_mapping = [[+]],
		direction = "vertical",
	},
}
