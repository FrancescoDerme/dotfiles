return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				cpp = { "clang_format" },
				cmake = { "cmake_format" },
				lua = { "stylua" },
				markdown = { "prettier" },
			},
			formatters = {
				clang_format = {
					prepend_args = {
						"--style={BasedOnStyle: google, IndentWidth: 4, ColumnLimit : 74, BreakBeforeBraces: Custom, BraceWrapping: {AfterFunction: false, BeforeElse: true}}",
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
		end, { desc = "Format" })
	end,
}
