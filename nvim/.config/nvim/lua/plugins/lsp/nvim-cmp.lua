return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		{
			"L3MON4D3/LuaSnip",
			-- follow latest release.
			version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
			-- install jsregexp (optional!).
			build = "make install_jsregexp",
		},
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
		"rafamadriz/friendly-snippets", -- useful snippets
		"onsails/lspkind.nvim", -- pictograms
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			completion = {
				--menu: shows a completion menu when there is more than one match,
				--menuone: shows a completion menu when there is only one match,
				--preview: shows a preview window with documentation for the selected item,
				--noselect: do not autoselect any item from the menu.
				completeopt = "menu,menuone,preview",
			},
			snippet = { -- configure how nvim-cmp interacts with snippet engine
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<M-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				["<M-j>"] = cmp.mapping.select_next_item(), -- next suggestion
				["<M-u>"] = cmp.mapping.scroll_docs(-4),
				["<M-d>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
				["<C-e>"] = cmp.mapping.abort(), -- close completion window
				["<CR>"] = cmp.mapping.confirm({ select = false }),
			}),
			-- sources for autocompletion
			sources = cmp.config.sources({
				{ name = "nvim_lsp" }, -- suggestion coming from the lsp
				{ name = "buffer" }, -- text within current buffer
				{ name = "luasnip" }, -- snippets
				{ name = "path" }, -- file system paths
			}),

			-- configure lspkind for pictograms in completion menu
			formatting = {
				format = lspkind.cmp_format({
					maxwidth = 50,
					ellipsis_char = "...",
				}),
			},
			--[[
			experimental = {
				-- Previews what the insetion would look like, but greyed out
				ghost_text = true,
			},NumericOrComplex 
            ]]
		})
	end,
}
