--[[ Remap '^' to '&' to match the way keys are placed on an
--   american keyboard (it makes sense for '&' to be close to
--   '$' since they have complementary functions). '&' did something
--   too, probably something quite important and useful, but we're
--   gonna ignore it for now
--]]
vim.keymap.set("n", "&", "^", { desc = "^" })

-- Fix AltGr combinations typing strange things, this is only a problem on non-US keyboards
local supercomb = {
	["⁰"] = "0",
	["¹"] = "1",
	["²"] = "2",
	["³"] = "3",
	["⁴"] = "4",
	["⁵"] = "5",
	["⁶"] = "6",
	["⁷"] = "7",
	["⁸"] = "8",
	["⁹"] = "9",
	["æ"] = "a",
	["”"] = "b",
	["¢"] = "c",
	["ð"] = "d",
	["€"] = "e",
	["→"] = "i",
	[" ̉"] = "j",
	["ĸ"] = "k",
	["µ"] = "m",
	["ñ"] = "n",
	["»"] = "x",
	["←"] = "y",
	["«"] = "z",
}

for lhs, rhs in pairs(supercomb) do
	vim.keymap.set("i", lhs, rhs, { noremap = true, silent = true })
end

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
local history_cache = nil
local MAX_HISTORY = 5

-- Read history from disk (only once per session)
local function load_history()
	if history_cache then
		return
	end

	history_cache = {}

	local f = io.open(history_path, "r")
	if not f then
		return
	end

	for line in f:lines() do
		if line ~= "" then
			table.insert(history_cache, line)
		end

		-- If history cointains clean absolute paths, regex can be skipped
		--[[
		local cleaned = line:match("^%s*(.-)%s*$")
		if cleaned ~= "" then
			table.insert(history_cache, cleaned)
		end
        --]]
	end

	f:close()
end

-- Write history to disk (only at the end of the session)
local function save_history()
	if not history_cache then
		return
	end

	local f = io.open(history_path, "w")
	if f then
		for _, line in ipairs(history_cache) do
			f:write(line .. "\n")
		end

		f:close()
	end
end

-- Remove current buffer from history cache
local function remove_from_history()
	local filepath = vim.api.nvim_buf_get_name(0)
	if not filepath or filepath == "" then
		return
	end

	local abs_path = vim.fn.fnamemodify(filepath, ":p")
	load_history()

	for i = #history_cache, 1, -1 do
		if history_cache[i] == abs_path then
			table.remove(history_cache, i)
			break
		end
	end
end

-- Add current buffer to history cache
local function add_to_history()
	local filepath = vim.api.nvim_buf_get_name(0)
	if not filepath or filepath == "" then
		return
	end

	local abs_path = vim.fn.fnamemodify(filepath, ":p")
	load_history()

	-- Remove the file if it's already in the history to avoid duplicates
	for i = #history_cache, 1, -1 do
		if history_cache[i] == abs_path then
			table.remove(history_cache, i)
			break
		end
	end

	-- Add to the end of the history
	table.insert(history_cache, abs_path)

	-- Enforce MAX_HISTORY limit
	while #history_cache > MAX_HISTORY do
		table.remove(history_cache, 1)
	end
end

-- Navigate memory cache
local function navigate_history(direction)
	load_history()

	if #history_cache == 0 then
		vim.notify("History is empty", vim.log.levels.WARN)
		return
	end

	-- Clean up missing files lazily from cache
	for i = #history_cache, 1, -1 do
		if vim.fn.filereadable(history_cache[i]) == 0 then
			table.remove(history_cache, i)
		end
	end

	if #history_cache == 0 then
		vim.notify("All files in history were deleted", vim.log.levels.WARN)
		return
	end

	local current_path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p")
	local current_idx = nil

	-- Find current position in the history
	for i, path in ipairs(history_cache) do
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
			target_idx = #history_cache
		else
			vim.notify("Current file not in history, no 'next' available", vim.log.levels.INFO)
			return
		end
	end

	-- Bounds checking
	if target_idx < 1 then
		vim.notify("Already at the end of history", vim.log.levels.INFO)
		return
	elseif target_idx > #history_cache then
		vim.notify("Already at the beginning of history", vim.log.levels.INFO)
		return
	end

	local target_file = history_cache[target_idx]

	-- Open the file and change directory
	vim.cmd("edit " .. vim.fn.fnameescape(target_file))
	local dir = vim.fn.fnamemodify(target_file, ":h")
	vim.cmd("cd " .. vim.fn.fnameescape(dir))

	local msg = string.format("History (%d/%d): %s", target_idx, #history_cache, target_file)
	vim.notify(msg, vim.log.levels.INFO)
end

local augroup = vim.api.nvim_create_augroup("PersistentHistory", { clear = true })

-- Save to history on file saves
vim.api.nvim_create_autocmd("BufWritePost", {
	group = augroup,
	pattern = "*",
	callback = function()
		-- Only add actual files to the history, ignoring special plugin/help buffers
		if vim.bo.buftype == "" then
			add_to_history()
		end
	end,
	desc = "Add saved file to persistent history",
})

-- Write to disk on session end
vim.api.nvim_create_autocmd("VimLeavePre", {
	group = augroup,
	callback = save_history,
	desc = "Save history to disk on exit",
})

-- Navigate and manage history
vim.keymap.set("n", "<leader>da", function()
	add_to_history()
end, { desc = "Add to history" })

vim.keymap.set("n", "<leader>dd", function()
	remove_from_history()
end, { desc = "Remove from history" })

vim.keymap.set("n", "<leader>dp", function()
	navigate_history("prev")
end, { desc = "Previous file in history" })

vim.keymap.set("n", "<leader>dn", function()
	navigate_history("next")
end, { desc = "Next file in history" })
