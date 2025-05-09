return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	--[[
	opts = {
		event_handlers = {
			{
				event = "neo_tree_buffer_enter",
				handler = function()
					vim.opt_local.relativenumber = true
				end,
			},
		},
	},
    ]]
	config = function()
		require("neo-tree").setup({
			window = {
				--[[
				mappings = {
					["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = true } },
					["l"] = "focus_preview",
					["<C-b>"] = { "scroll_preview", config = { direction = 10 } },
					["<C-f>"] = { "scroll_preview", config = { direction = -10 } },
				},
				]]
			},
		})
	end,
}
