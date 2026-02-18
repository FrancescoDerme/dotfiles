return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		---@param mapping wk.Mapping
		filter = function(mapping)
			-- Hide DeadKeys, these are defined in "keymaps.lua"
			if _G.DeadKeys then
				for _, dead_key in ipairs(_G.DeadKeys) do
					if mapping.lhs == dead_key then
						return false
					end
				end
			end

			-- Hide keys whose description starts with "Disabled"
			if mapping.desc and mapping.desc:match("^Disable") then
				return false
			end

			return mapping.desc and mapping.desc ~= ""
		end,
		win = {
			height = { min = 4, max = 8 },
		},
		spec = {
			{
				mode = { "n" },
				{ "<leader>", group = "Keymaps" },
				{ "<leader>d", group = "Directory" },
				{ "<leader>l", group = "LSP" },
				{ "<leader>f", group = "Find" },
				{ "<leader>c", group = "Competitest" },
				{ "<leader>cd", group = "Download" },
				{ "<leader>o", group = "Oil" },
				{ "g", group = "Goto" },
				{ "]", group = "Next" },
				{ "]f", group = "Function call" },
				{ "]d", group = "Function definition" },
				{ "]i", group = "Conditional" },
				{ "]l", group = "Loop" },
				{ "[", group = "Previous" },
				{ "[f", group = "Function call" },
				{ "[d", group = "Function definition" },
				{ "[i", group = "Conditional" },
				{ "[l", group = "Loop" },
			},
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "",
		},
	},
}
