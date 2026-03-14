return {
	"CRAG666/code_runner.nvim",
	config = function()
		require("code_runner").setup({
			mode = "toggleterm",
			filetype = {
				cpp = "cd $dir && g++ $fileName -o /tmp/$fileNameWithoutExt && /tmp/$fileNameWithoutExt",
				c = "cd $dir && gcc $fileName -o /tmp/$fileNameWithoutExt && /tmp/$fileNameWithoutExt",
				python = "python3 -u",
			},
		})
	end,
}
