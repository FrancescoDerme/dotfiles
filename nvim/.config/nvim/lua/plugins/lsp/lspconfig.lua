return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/lazydev.nvim", opts = {} },
	},

	config = function()
		-- Set default capabilities for all servers
		vim.lsp.config("*", {
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		})

		-- C++
		vim.lsp.config("clangd", {
			cmd = {
				"clangd",
				"--clang-tidy",
				"--header-insertion=never", -- Stops automatic header imports
				"--background-index",
				"--offset-encoding=utf-8",
				"--compile-commands-dir=build",
			},
			root_markers = { ".clangd", "compile_commands.json" },
			filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
		})

		-- CMake
		vim.lsp.config("neocmakelsp", {
			cmd = { "neocmakelsp", "stdio" },
			filetypes = { "cmake" },
			root_markers = { "CMakeLists.txt", ".git" },
			init_options = {
				buildDirectory = "build",
				semantic_token = true,
				scan_cmake_in_package = true,
				lint = {
					enable = true,
				},
				format = {
					enable = true,
				},
			},
		})

		-- Lua
		vim.lsp.config("lua_ls", {
			settings = {
				["Lua"] = {
					diagnostics = {
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
