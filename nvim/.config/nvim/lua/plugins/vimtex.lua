return {
	"lervag/vimtex",
	lazy = false, -- do not lazy load VimTeX
	init = function()
		-- Set Zathura as the default PDF viewer
		vim.g.vimtex_view_method = "zathura"

		-- Use latexmk as the compiler
		vim.g.vimtex_compiler_method = "latexmk"

		-- Don't open QuickFix for compilation warnings, only errors
		vim.g.vimtex_quickfix_open_on_warning = 0
	end,
}
