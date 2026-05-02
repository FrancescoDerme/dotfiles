return {
	"williamboman/mason.nvim",

	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},

	config = function()
		local mason = require("mason")
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		local mason_tool_installer = require("mason-tool-installer")
		mason_tool_installer.setup({
			ensure_installed = {
				-- C++
				"clangd",
				"clang-format",

				-- CMake
				"neocmakelsp",
				"cmakelang",

				-- Lua
				"lua_ls",
				"stylua",

				-- Markdown
				"prettier",

				-- Latex
				"texlab",
				"ltex-ls-plus",
			},

			auto_update = true,
		})
	end,
}
