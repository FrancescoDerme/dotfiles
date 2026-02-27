--[[ Remap '^' to '&' to match the way keys are placed on an
--   american keyboard (it makes sense for '&' to be close to
--   '$' since they have complementary functions). '&' did something
--   too, probably something quite important and useful, but we're
--   gonna ignore it for now.
--]]
vim.keymap.set("n", "&", "^", { desc = "^" })

-- Disable some of the default "]" and "[" vim keymaps
local chars_to_delete = {
	"a",
	"A",
	"b",
	"B",
	"D",
	"h",
	"L",
	"q",
	"Q",
	"t",
	"T",
	" ",
	"<C-L>",
	"<C-T>",
	"<C-Q>",
}

for _, char in ipairs(chars_to_delete) do
	pcall(vim.keymap.del, { "n", "v", "o" }, "]" .. char)
	pcall(vim.keymap.del, { "n", "v", "o" }, "[" .. char)
end

-- Disable other default keymaps and hide them inside which-key
-- These are core engine motions, so vim.keymap.del doesn't work
_G.DeadKeys = {
	"]m",
	"[m",
	"]M",
	"[M",
	"]s",
	"[s",
	"]%",
	"[%",
	"](",
	"[(",
	"]<",
	"[<",
	"]{",
	"[{",
}

for _, key in ipairs(_G.DeadKeys) do
	vim.keymap.set({ "n", "v", "o" }, key, "<Nop>", { desc = "Disabled" })
end

-- Disable arrow keys
-- Can't be done in the previous section because these have to be
-- deleted for insert mode, but deleting _G.DeadKeys for insert mode
-- would cause problems when typing square brackets
vim.keymap.set({ "n", "i" }, "<Down>", "<Nop>", { desc = "Disabled" })
vim.keymap.set({ "n", "i" }, "<Up>", "<Nop>", { desc = "Disabled" })
vim.keymap.set({ "n", "i" }, "<Left>", "<Nop>", { desc = "Disabled" })
vim.keymap.set({ "n", "i" }, "<Right>", "<Nop>", { desc = "Disabled" })

-- Switch focus
vim.keymap.set("n", "<M-h>", "<C-w>h", { desc = "Switch focus left" })
vim.keymap.set("n", "<M-j>", "<C-w>j", { desc = "Switch focus down" })
vim.keymap.set("n", "<M-k>", "<C-w>k", { desc = "Switch focus up" })
vim.keymap.set("n", "<M-l>", "<C-w>l", { desc = "Switch focus right" })

-- Tabs and splits
vim.keymap.set("n", "<Tab>t", ":tabnew <CR>", { desc = "Open new tab" })
vim.keymap.set("n", "<Tab>v", ":vsplit <CR>", { desc = "Open vertical window" })
vim.keymap.set("n", "<Tab>h", ":split <CR>", { desc = "Open horizontal window" })

-- Change directory relative to current buffer
vim.keymap.set("n", "<leader>dc", ":cd %:p:h <CR>", { desc = "cd to file", silent = true })
vim.keymap.set("n", "<leader>du", ":cd %:p:h:h <CR>", { desc = "cd to above file", silent = true })

-- Keep track of the path of the last saved files to be used in directory-related keymaps
local history_path = vim.fn.stdpath("data") .. "/history.txt"
local MAX_HISTORY = 5

-- Read history from disk
local function read_history()
	local f = io.open(history_path, "r")
	if not f then
		return {}
	end

	local lines = {}
	for line in f:lines() do
		local cleaned = line:match("^%s*(.-)%s*$")
		if cleaned ~= "" then
			table.insert(lines, cleaned)
		end
	end

	f:close()
	return lines
end

-- Write history to disk
local function write_history(lines)
	local f = io.open(history_path, "w")
	if f then
		for _, line in ipairs(lines) do
			f:write(line .. "\n")
		end

		f:close()
	end
end

-- Add current buffer to history
local function add_to_history()
	local filepath = vim.api.nvim_buf_get_name(0)
	if not filepath or filepath == "" then
		return
	end

	local abs_path = vim.fn.fnamemodify(filepath, ":p")
	local history = read_history()

	-- Count valid older items
	local valid_count = 0
	for _, path in ipairs(history) do
		if path ~= abs_path then
			valid_count = valid_count + 1
		end
	end

	-- Calculate how many older items to skip to leave room for the new one
	local skip_count = math.max(0, valid_count - (MAX_HISTORY - 1))

	local new_history = {}

	-- Rebuild the list
	for _, path in ipairs(history) do
		if path ~= abs_path then
			if skip_count > 0 then
				skip_count = skip_count - 1
			else
				table.insert(new_history, path)
			end
		end
	end

	-- Append the new file to the end
	table.insert(new_history, abs_path)
	write_history(new_history)
end

-- Navigate and clean history
local function navigate_history(direction)
	local history = read_history()
	if #history == 0 then
		vim.notify("History is empty", vim.log.levels.WARN)
		return
	end

	-- Filter out files that no longer exist
	local valid_history = {}
	local cleaned = false

	for _, path in ipairs(history) do
		if vim.fn.filereadable(path) == 1 then
			table.insert(valid_history, path)
		else
			cleaned = true
		end
	end

	-- Update the disk file silently if cleanup happened
	if cleaned then
		write_history(valid_history)
	end

	if #valid_history == 0 then
		vim.notify("All files in history were deleted, history is empty", vim.log.levels.WARN)
		return
	end

	local current_path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p")
	local current_idx = nil

	-- Find current position in the history
	for i, path in ipairs(valid_history) do
		if path == current_path then
			current_idx = i
			break
		end
	end

	local target_idx
	if current_idx then
		target_idx = (direction == "prev") and (current_idx - 1) or (current_idx + 1)
	else
		if direction == "prev" then
			target_idx = #valid_history
		else
			vim.notify("Current file not in history, no 'next' available", vim.log.levels.INFO)
			return
		end
	end

	-- Bounds checking
	if target_idx < 1 then
		vim.notify("Already at the end of history", vim.log.levels.INFO)
		return
	elseif target_idx > #valid_history then
		vim.notify("Already at the beginning of history", vim.log.levels.INFO)
		return
	end

	local target_file = valid_history[target_idx]

	-- Open the file and change directory
	vim.cmd("edit " .. vim.fn.fnameescape(target_file))

	local dir = vim.fn.fnamemodify(target_file, ":h")
	vim.cmd("cd " .. vim.fn.fnameescape(dir))

	local msg = string.format("History (%d/%d): %s", target_idx, #valid_history, target_file)
	vim.notify(msg, vim.log.levels.INFO)
end

-- Automatically save to history on file saves
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*",
	callback = function()
		-- Only add actual files to the history, ignoring special plugin/help buffers
		if vim.bo.buftype == "" then
			add_to_history()
		end
	end,
	desc = "Add saved file to persistent history",
})

-- Navigate the history
vim.keymap.set("n", "<leader>dp", function()
	navigate_history("prev")
end, { desc = "Previous file in history" })

vim.keymap.set("n", "<leader>dn", function()
	navigate_history("next")
end, { desc = "Next file in history" })
