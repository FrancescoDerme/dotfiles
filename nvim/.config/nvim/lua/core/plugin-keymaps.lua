-- Neotree
vim.keymap.set("n", "<leader>e", ":Neotree filesystem toggle left <CR>", { desc = "File tree", silent = true })

-- Telescope
vim.keymap.set("n", "<leader>fd", ":Telescope live_grep <CR>", { desc = "Text in directory" })
vim.keymap.set("n", "<leader>fb", ":Telescope current_buffer_fuzzy_find <CR>", { desc = "Text in buffer" })
vim.keymap.set("n", "<leader>ff", ":Telescope find_files <CR>", { desc = "File in directory" })

-- Competitest
local target_line = 25
vim.keymap.set("n", "<leader>ca", ":CompetiTest add_testcase <CR>", { desc = "Add testcase" })
vim.keymap.set("n", "<leader>ce", ":CompetiTest edit_testcase <CR>", { desc = "Edit testcase" })
vim.keymap.set("n", "<leader>cr", ":CompetiTest run <CR>", { desc = "Run testcases" })
vim.keymap.set("n", "<leader>cu", ":CompetiTest show_ui <CR>", { desc = "Show ui" })
vim.keymap.set("n", "<leader>cdt", ":CompetiTest receive testcases <CR>", { desc = "Testcases" })
vim.keymap.set("n", "<leader>cdp", ":CompetiTest receive problem <CR> :" .. target_line .. "<CR>", { desc = "Problem" })
vim.keymap.set("n", "<leader>cdc", ":CompetiTest receive contest <CR> :" .. target_line .. "<CR>", { desc = "Contest" })

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
end, { desc = "Submit" })

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
end, { desc = "Next problem" })

-- Keymap to go to the previous problem (offset = -1)
vim.keymap.set("n", "<leader>cp", function()
	navigate_problem(-1, "first")
end, { desc = "Previous problem" })

-- Oil
vim.keymap.set("n", "<leader>oe", ":Oil <CR>", { desc = "File explorer" })
vim.keymap.set("n", "<leader>of", ":Oil --float <CR>", { desc = "Floating file explorer" })

-- Code runner
vim.keymap.set("n", "<leader>r", function()
	vim.cmd("write")
	vim.cmd("RunCode")
	vim.cmd("wincmd l")
	vim.schedule(function()
		vim.cmd("startinsert")
	end)
end, { desc = "Run code" })

-- Markdown-preview
vim.keymap.set("n", "<leader>m", ":MarkdownPreviewToggle <CR>", { desc = "Mardown preview" })

-- LSP
local lsp_mappings = {
	{ mode = "n", key = "<leader>lg", func = vim.lsp.buf.declaration, desc = "Go to declaration" },
	{ mode = "n", key = "<leader>lf", func = "<cmd>Telescope lsp_definitions<CR>", desc = "Show definitions" },
	{ mode = "n", key = "<leader>li", func = "<cmd>Telescope lsp_implementations<CR>", desc = "Show implementations" },
	{
		mode = "n",
		key = "<leader>lt",
		func = "<cmd>Telescope lsp_type_definitions<CR>",
		desc = "Show type definitions",
	},
	{ mode = { "n", "v" }, key = "<leader>la", func = vim.lsp.buf.code_action, desc = "See code actions" },
	{ mode = "n", key = "<leader>lr", func = vim.lsp.buf.rename, desc = "Smart rename" },
	{
		mode = "n",
		key = "<leader>lD",
		func = "<cmd>Telescope diagnostics bufnr=0<CR>",
		desc = "Show buffer diagnostics",
	},
	{ mode = "n", key = "<leader>ld", func = vim.diagnostic.open_float, desc = "Show line diagnostics" },
	{
		mode = "n",
		key = "[e",
		func = function()
			vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR, float = true })
		end,
		desc = "Error",
	},
	{
		mode = "n",
		key = "]e",
		func = function()
			vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR, float = true })
		end,
		desc = "Error",
	},
	{
		mode = "n",
		key = "[w",
		func = function()
			vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.WARN, float = true })
		end,
		desc = "Warning",
	},
	{
		mode = "n",
		key = "]w",
		func = function()
			vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.WARN, float = true })
		end,
		desc = "Warning",
	},
}

local lsp_group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
	group = lsp_group,
	callback = function(ev)
		for _, map in ipairs(lsp_mappings) do
			vim.keymap.set(map.mode, map.key, map.func, { buffer = ev.buf, desc = map.desc })
		end
	end,
})

vim.api.nvim_create_autocmd("LspDetach", {
	group = lsp_group,
	callback = function(ev)
		for _, map in ipairs(lsp_mappings) do
			pcall(vim.keymap.del, map.mode, map.key, { buffer = ev.buf })
		end
	end,
})

local servers = { "clangd", "neocmakelsp", "lua_ls" }

vim.keymap.set("n", "<leader>ls", function()
	-- Check if there are any active clients in the current buffer
	local active_clients = vim.lsp.get_clients({ bufnr = 0 })
	local is_active = #active_clients > 0

	if is_active then
		for _, server in ipairs(servers) do
			pcall(vim.lsp.disable, server)
		end
		vim.notify("LSP Disabled", vim.log.levels.INFO, { title = "LSP System" })
	else
		vim.lsp.enable(servers)
		vim.notify("LSP Enabled", vim.log.levels.INFO, { title = "LSP System" })
	end
end, { desc = "Toggle LSP" })

--vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", { desc = "Show references" })
--vim.keymap.set("n", "<leader>lk", vim.lsp.buf.hover, { desc = "Show documentation" })
