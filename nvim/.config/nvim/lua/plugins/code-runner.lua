return {
	"CRAG666/code_runner.nvim",
	config = function()
		require("code_runner").setup({
			focus = false,
			filetype = {
				crunner = function(...)
					vim.cmd("wincmd k")
					vim.cmd("RunCode")
				end,
				cpp = function(...)
					vim.cmd("write")

					local cpp_base = {
						[[cd '$dir' &&]],
						[[g++ '$fileName' -o]],
						---[[g++ -std=c++23 '$fileName' -o]],
						[[/tmp/'$fileNameWithoutExt']],
					}
					local cpp_exec = {
						[[&& /tmp/'$fileNameWithoutExt' &&]],
						[[rm /tmp/'$fileNameWithoutExt']],
					}
					vim.ui.input({ prompt = "Compiler args:" }, function(input)
						cpp_base[4] = input
						vim.print(vim.tbl_extend("force", cpp_base, cpp_exec))
						require("code_runner.commands").run_from_fn(vim.list_extend(cpp_base, cpp_exec))
					end)
				end,
			},
		})
	end,
}
