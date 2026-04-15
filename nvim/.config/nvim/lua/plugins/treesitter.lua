return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	event = { "BufReadPre", "BufNewFile" },

	dependencies = {
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			branch = "main",
		},
	},

	config = function()
		require("nvim-treesitter").setup()

		require("nvim-treesitter").install({
			"lua",
			"c",
			"cpp",
			"markdown",
			"markdown_inline",
			"bash",
			"gitignore",
		})

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("treesitter_highlight_indent", { clear = true }),
			callback = function(args)
				local ok = pcall(vim.treesitter.start, args.buf)

				if ok then
					vim.bo[args.buf].indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
				end
			end,
		})
	end,
}
