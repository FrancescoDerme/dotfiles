return {
	"folke/flash.nvim",
	event = "VeryLazy",
	---@type Flash.Config
	opts = {
		modes = {
			search = {
				enabled = false,
			},
			char = {
				enabled = false,
				jump_labels = false,
			},
		},
	},
	keys = {
		{
			"S",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash textobject jump",
		},
	},
}
