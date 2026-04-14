-- Code runner
vim.keymap.set("n", "<leader>r", function()
	vim.cmd("write")
	vim.cmd("RunCode")
	vim.cmd("wincmd l")
	vim.schedule(function()
		vim.cmd("startinsert")
	end)
end, { buffer = true, desc = "Run code" })

-- Competitest
local target_line = 25
vim.keymap.set("n", "<leader>ca", ":CompetiTest add_testcase <CR>", { buffer = true, desc = "Add testcase" })
vim.keymap.set("n", "<leader>ce", ":CompetiTest edit_testcase <CR>", { buffer = true, desc = "Edit testcase" })
vim.keymap.set("n", "<leader>cr", ":CompetiTest run <CR>", { buffer = true, desc = "Run testcases" })
vim.keymap.set("n", "<leader>cu", ":CompetiTest show_ui <CR>", { buffer = true, desc = "Show ui" })
vim.keymap.set("n", "<leader>cdt", ":CompetiTest receive testcases <CR>", { buffer = true, desc = "Testcases" })
vim.keymap.set(
	"n",
	"<leader>cdp",
	":CompetiTest receive problem <CR> :" .. target_line .. "<CR>",
	{ buffer = true, desc = "Problem" }
)
vim.keymap.set(
	"n",
	"<leader>cdc",
	":CompetiTest receive contest <CR> :" .. target_line .. "<CR>",
	{ buffer = true, desc = "Contest" }
)

local submit_term = nil
vim.keymap.set("n", "<leader>cs", function()
	vim.cmd("write")

	-- Extract URL and filepath
	local lines = vim.api.nvim_buf_get_lines(0, 2, 3, false)
	local line = lines[1] or ""
	local url = line:match("submit at:%s*(%S+)")

	if not url then
		vim.notify("Submitter: no URL found on line 3 after 'submit at:'", vim.log.levels.ERROR)
		return
	end

	local file_path = vim.fn.expand("%:p")
	local bash_cmd = string.format('subwithoutcred "%s" "C++" "%s"', url, file_path)

	local ok, terminal_module = pcall(require, "toggleterm.terminal")
	if not ok then
		vim.notify("Submitter: toggleterm.terminal is not installed", vim.log.levels.ERROR)
		return
	end

	if not submit_term then
		submit_term = terminal_module.Terminal:new({
			direction = "vertical",
			close_on_exit = false,
		})
	end

	if not submit_term.job_id then
		submit_term:spawn()
	end

	submit_term:send(bash_cmd)
end, { buffer = true, desc = "Submit" })

local function navigate_problem(offset, direction_name)
	-- Get current file and directory info
	local file = vim.fn.expand("%:p:h")
	local head = vim.fn.fnamemodify(file, ":h") -- Parent directory path
	local tail = vim.fn.fnamemodify(file, ":t") -- Current directory name (e.g., 'ProblemA')

	-- Get sibling dirs and normalize names
	local dirs = vim.fn.globpath(head, "*/", 0, 1) -- e.g., {'/path/to/Contest/ProblemA/', ...}

	for i, d in ipairs(dirs) do
		-- Convert to just the directory name (e.g., 'ProblemA')
		dirs[i] = vim.fn.fnamemodify(d, ":h:t")
	end

	table.sort(dirs) -- Sort them alphabetically

	-- Find the target sibling index
	local target_name, target_idx
	for i, d in ipairs(dirs) do
		if d == tail then
			-- i is the index of the current directory (tail)
			target_name = dirs[i + offset]
			target_idx = i + offset
			break
		end
	end

	-- Execute navigation
	if target_name then
		local target_path = head .. "/" .. target_name .. "/main.cpp"
		if vim.fn.filereadable(target_path) == 1 then
			vim.cmd("edit " .. target_path)

			-- Right line to start editing the template
			vim.cmd(tostring(target_line))

			local msg = string.format("Problem (%d/%d): %s", target_idx, #dirs, target_name)
			vim.notify(msg, vim.log.levels.INFO)
		else
			vim.notify("No main.cpp found in: " .. target_name, vim.log.levels.WARN)
		end
	else
		vim.notify("Already at the " .. direction_name .. " problem", vim.log.levels.WARN)
	end
end

-- Keymap to go to the next problem (offset = 1)
vim.keymap.set("n", "<leader>cn", function()
	navigate_problem(1, "last")
end, { buffer = true, desc = "Next problem" })

-- Keymap to go to the previous problem (offset = -1)
vim.keymap.set("n", "<leader>cp", function()
	navigate_problem(-1, "first")
end, { buffer = true, desc = "Previous problem" })
