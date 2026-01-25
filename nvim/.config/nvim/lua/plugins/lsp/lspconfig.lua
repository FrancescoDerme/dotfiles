return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},

	config = function()
		vim.lsp.config("*", {
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		})

		vim.lsp.config("clangd", {
			cmd = {
				"clangd",
				"--clang-tidy",
				"--header-insertion=never", -- Stops automatic header imports
				"--background-index",
				"--offset-encoding=utf-8",
				"--compile-commands-dir=cmake",
			},
			root_markers = { ".clangd", "compile_commands.json" },
			filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
		})

		vim.lsp.config("lua_ls", {
			settings = {
				["Lua"] = {
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
						disable = { "missing-fields" },
					},
					completion = {
						callSnippet = "Replace",
					},
				},
			},
		})
	end,
}
