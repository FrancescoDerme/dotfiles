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

		-- Keympas are setup manually so that they get picked up by Which-Key
		vim.g.vimtex_mappings_enabled = 0

		-- Don't forward search when compiling for the first time
		vim.g.vimtex_view_forward_search_on_start = 0

		vim.g.vimtex_compiler_latexmk = {
			out_dir = "build",
		}
	end,
}
