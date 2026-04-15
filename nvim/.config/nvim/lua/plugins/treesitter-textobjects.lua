return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	lazy = true,
	config = function()
		require("nvim-treesitter-textobjects").setup({
			select = {
				lookahead = true,
			},
			move = {
				set_jumps = true,
			},
		})

		local select = require("nvim-treesitter-textobjects.select")

		vim.keymap.set({ "x", "o" }, "=o", function()
			select.select_textobject("@assignment.outer", "textobjects")
		end, { desc = "Select outer assignment" })

		vim.keymap.set({ "x", "o" }, "=i", function()
			select.select_textobject("@assignment.inner", "textobjects")
		end, { desc = "Select inner assignment" })

		vim.keymap.set({ "x", "o" }, "=l", function()
			select.select_textobject("@assignment.lhs", "textobjects")
		end, { desc = "Select left assignment" })

		vim.keymap.set({ "x", "o" }, "=r", function()
			select.select_textobject("@assignment.rhs", "textobjects")
		end, { desc = "Select right assignment" })

		-- The move keympas are handled by the demicolon plugin
	end,
}
