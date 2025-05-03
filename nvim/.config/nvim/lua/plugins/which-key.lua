return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		---@param mapping wk.Mapping
		filter = function(mapping)
			-- return true
			return mapping.desc and mapping.desc ~= ""
		end,
		win = {
			height = { min = 4, max = 8 },
		},
		spec = {
			{
				mode = { "n" },
				{ "<leader>", group = "Plugins" },
				{ "<leader>l", group = "LSP" },
				{ "<leader>f", group = "Find" },
				{ "<leader>c", group = "Competitest" },
				{ "<leader>cd", group = "Download" },
				{ "<leader>o", group = "Oil" },
				{ "<leader>s", group = "Swap" },
				{ "<leader>sn", group = "Swap next" },
				{ "<leader>sp", group = "Swap previous" },
				{ "g", group = "Goto" },
				{ "]", group = "Goto next" },
				{ "[", group = "Goto previous" },
			},
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			--desc = "Buffer Local Keymaps (which-key)",
			desc = "",
		},
	},
}
