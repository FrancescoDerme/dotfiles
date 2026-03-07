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
							local clients = vim.lsp.get_clients({ bufnr = 0 })
							if #clients == 0 then
								return "LSP OFF"
							end

							local names = {}
							for _, client in ipairs(clients) do
								table.insert(names, client.name)
							end
							return "LSP: " .. table.concat(names, ", ")
						end,
						color = function()
							local clients = vim.lsp.get_clients({ bufnr = 0 })
							return { fg = #clients > 0 and "#98be65" or "#ff6c6b" }
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
