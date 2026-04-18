local helpers = require("core.helpers")

-- Code runner
vim.keymap.set("n", "<leader>r", function()
	vim.cmd("write")

	local function execute_and_focus()
		-- Run the code
		vim.cmd("RunCode")

		-- Jump to the terminal window and enter insert mode
		vim.cmd("wincmd l")
		vim.schedule(function()
			vim.cmd("startinsert")
		end)
	end

	-- Find the terminal channel
	local chan = 0
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.bo[buf].buftype == "terminal" then
			chan = vim.bo[buf].channel
			if chan > 0 then
				-- \x03 is Ctrl-C (cancels running process)
				vim.api.nvim_chan_send(chan, "\x03")
				break
			end
		end
	end

	-- Delay the execution slightly if the terminal was cleared
	if chan > 0 then
		vim.defer_fn(function()
			-- \x15 is Ctrl-U (clears the line)
			-- \x0c is Ctrl-L (scroll the terminal window so that the new line is uptop)
			vim.api.nvim_chan_send(chan, "\x15\x0c")

			vim.defer_fn(function()
				execute_and_focus()
			end, 100)
		end, 100)
	else
		-- If no terminal was found, we want to prewarm a new one so the shell has time to boot and suppress the PTY echo
		-- However, we need to get back to the original window before calling the code_runner plugin
		local original_win = vim.api.nvim_get_current_win()

		vim.cmd("ToggleTerm")
		vim.api.nvim_set_current_win(original_win)

		-- Wait for the shell to finish booting, then execute
		vim.defer_fn(function()
			execute_and_focus()
		end, 100)
	end
end, { buffer = true, desc = "Run code" })

-- Competitest
vim.keymap.set("n", "<leader>ca", ":CompetiTest add_testcase <CR>", { buffer = true, desc = "Add testcase" })
vim.keymap.set("n", "<leader>ce", ":CompetiTest edit_testcase <CR>", { buffer = true, desc = "Edit testcase" })
vim.keymap.set("n", "<leader>cr", ":CompetiTest run <CR>", { buffer = true, desc = "Run testcases" })
vim.keymap.set("n", "<leader>cu", ":CompetiTest show_ui <CR>", { buffer = true, desc = "Show ui" })
vim.keymap.set("n", "<leader>cdt", ":CompetiTest receive testcases <CR>", { buffer = true, desc = "Testcases" })

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
			vim.cmd(tostring(helpers.target_line))

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
