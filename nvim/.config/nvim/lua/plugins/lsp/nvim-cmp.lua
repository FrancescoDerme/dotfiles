return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		--"hrsh7th/cmp-path", -- source for file system paths
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
			performance = {
				-- Limit the computed results for speed
				max_view_entries = 5,
			},

			--[[
			window = {
				completion = {
					-- Limit the window entries for clutter
					max_height = 5,
				},
			},
            --]]

			completion = {
				--menu: shows a completion menu when there is more than one match,
				--menuone: shows a completion menu when there is only one match,
				--preview: shows a preview window with documentation for the selected item,
				--noselect: do not autoselect any item from the menu.
				completeopt = "menu, menuone, preview, noselect",
			},
			snippet = { -- configure how nvim-cmp interacts with snippet engine
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<M-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				["<M-j>"] = cmp.mapping.select_next_item(), -- next suggestion
				["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
				["<C-e>"] = cmp.mapping.abort(), -- close completion window

				-- Sometimes Alt key is still pressed when pressing Enter, this should behave as standard Enter
				["<CR>"] = cmp.mapping.confirm({ select = false }),
				["<M-CR>"] = cmp.mapping.confirm({ select = false }),

				["<M-u>"] = cmp.mapping.scroll_docs(-4),
				["<M-d>"] = cmp.mapping.scroll_docs(4),

				-- Explicitly disable arrow keys in the cmp menu
				["<Down>"] = cmp.config.disable,
				["<Up>"] = cmp.config.disable,
			}),
			-- sources for autocompletion
			-- keyword_length is the number of characters to be typed before a suggestion is generated
			-- max_item_count is self-explanatory
			sources = cmp.config.sources({
				-- suggestion coming from the lsp
				{
					name = "nvim_lsp",
					entry_filter = function(entry, ctx)
						-- Get the word currently typed in the buffer
						local word = ctx.cursor_before_line:match("[%w_]+$")
						-- Compare it to the completion label
						return entry:get_insert_text() ~= word
					end,
				},
				-- snippets
				{ name = "luasnip" },
				-- text within current buffer
				{ name = "buffer" },
				-- file system paths
				{ name = "path", keyword_length = 3, max_item_count = 1 },
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
