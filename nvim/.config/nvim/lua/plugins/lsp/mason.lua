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

		-- It's called "ensure_installed" but for some reason also enables the LSPs,
		-- thus it's disabled cause I prefer manually toggling the LSPs
		--[[
		local mason_lspconfig = require("mason-lspconfig")
		mason_lspconfig.setup({
			ensure_installed = {
				"clangd",
				"neocmakelsp",
				"lua_ls",
			},
		})
        --]]

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
			},

			auto_update = true,
		})
	end,
}
