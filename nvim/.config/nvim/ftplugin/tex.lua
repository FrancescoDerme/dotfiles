-- Create a unique group name for this specific buffer so reloading doesn't duplicate it
local group = vim.api.nvim_create_augroup("LatexAutoSave_" .. vim.api.nvim_get_current_buf(), { clear = true })

-- Create the autocommand specifically for the current buffer
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI", "InsertLeave" }, {
	buffer = 0, -- '0' means the current buffer
	group = group,
	callback = function()
		if vim.bo.modified then
			vim.cmd("silent! write")
		end
	end,
})
