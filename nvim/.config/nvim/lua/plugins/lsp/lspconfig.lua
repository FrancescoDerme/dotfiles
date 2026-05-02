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
			init_options = {
				-- Used if build/compile_commands.json is not found
				fallbackFlags = { "-std=c++23" },
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

		-- Latex (code)
		vim.lsp.config("texlab", {
			filetypes = { "tex", "plaintex", "bib" },
			settings = {
				texlab = {
					-- We leave compiling and PDF syncing to VimTeX,
					-- we only need TexLab for code completion/diagnostics
					diagnosticsDelay = 300,
					formatterLineLength = 80,
					chktex = {
						onOpenAndSave = false,
					},
				},
			},
		})

		-- Latex (grammar)
		vim.lsp.config("ltex_plus", {
			filetypes = { "tex", "plaintex", "markdown", "text" },
			settings = {
				ltex = {
					language = "en-US",
					diagnosticSeverity = "information",
					sentenceCacheSize = 2000,
					additionalRules = {
						enablePickyRules = true,
						motherTongue = "en-US",
					},
				},
			},
		})
	end,
}
