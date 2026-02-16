return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({
			options = {
				theme = "palenight",
			},
			extensions = {
				"neo-tree",
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = {
					{
						function()
							return _G.lsp_active and "LSP ON" or "LSP OFF"
						end,
						color = function()
							return { fg = _G.lsp_active and "#98be65" or "#ff6c6b" }
						end,
					},
					"filetype",
				},
				lualine_y = {},
				lualine_z = { "location" },
			},
		})
	end,
}
