return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				cpp = { "clang_format" },
				lua = { "stylua" },
				--[[
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                svelte = { "prettier" },
                css = { "prettier" },
                html = { "prettier" },
                json = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
                graphql = { "prettier" },
                python = { "isort", "black" },
                ]]
			},
			formatters = {
				clang_format = {
					prepend_args = {
						"--style={BasedOnStyle: google, IndentWidth: 4, BreakBeforeBraces: Custom, BraceWrapping: {AfterFunction: false, BeforeElse: true}}",
					},
				},
			},

			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>p", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range" })
	end,
}
