return {
	"mason-org/mason.nvim",
	"mason-org/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",

	require("mason-lspconfig").setup({
		automatic_enable = {
			"clangd",
			"lua_ls",
		},
	}),
}
