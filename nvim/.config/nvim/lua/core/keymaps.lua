--[[ Remap '^' to '&' to match the way keys are placed on an
--   american keyboard (it makes sense for '&' to be close to
--   '$' since they have complementary functions). '&' did something
--   too, probably something quite important and useful, but we're
--   gonna ignore it for now.
--]]
vim.keymap.set("n", "&", "^", { desc = "^" })

-- Deactivating arrow keys in both normal and insert mode
vim.keymap.set({ "n", "i" }, "<Down>", "<Nop>", { desc = "Ignored" })
vim.keymap.set({ "n", "i" }, "<Up>", "<Nop>", { desc = "Ignored" })
vim.keymap.set({ "n", "i" }, "<Left>", "<Nop>", { desc = "Ignored" })
vim.keymap.set({ "n", "i" }, "<Right>", "<Nop>", { desc = "Ignored" })

-- Keymaps to switch focus faster
vim.keymap.set("n", "<M-h>", "<C-w>h", { desc = "Switch focus left" })
vim.keymap.set("n", "<M-j>", "<C-w>j", { desc = "Switch focus down" })
vim.keymap.set("n", "<M-k>", "<C-w>k", { desc = "Switch focus up" })
vim.keymap.set("n", "<M-l>", "<C-w>l", { desc = "Switch focus right" })

-- Keymaps for tabs and splits
vim.keymap.set("n", "<Tab>t", ":tabnew <CR>", { desc = "Open new tab" })
vim.keymap.set("n", "<Tab>v", ":vsplit | wincmd =<CR>", { desc = "Open vertical window" })
vim.keymap.set("n", "<Tab>h", ":split | wincmd =<CR>", { desc = "Open horizontal window" })
-- vim.keymap.set("n", "<Tab>v", ":vsplit <CR>", { desc = "Open vertical window" })
-- vim.keymap.set("n", "<Tab>h", ":split <CR>", { desc = "Open horizontal window" })

-- Change directory
vim.keymap.set("n", "<leader>dp", ":cd %:p:h <CR>", { desc = "cd to file", silent = true })
vim.keymap.set("n", "<leader>du", ":cd %:p:h:h <CR>", { desc = "cd to above file", silent = true })

-- Neotree
vim.keymap.set("n", "<leader>e", ":Neotree filesystem toggle left <CR>", { desc = "File tree", silent = true })

-- Telescope
vim.keymap.set("n", "<leader>fd", ":Telescope live_grep <CR>", { desc = "Text in directory" })
vim.keymap.set("n", "<leader>fb", ":Telescope current_buffer_fuzzy_find <CR>", { desc = "Text in buffer" })
vim.keymap.set("n", "<leader>ff", ":Telescope find_files <CR>", { desc = "File in directory" })

-- Competitest
vim.keymap.set("n", "<leader>ca", ":CompetiTest add_testcase <CR>", { desc = "Add testcase" })
vim.keymap.set("n", "<leader>ce", ":CompetiTest edit_testcase <CR>", { desc = "Edit testcase" })
vim.keymap.set("n", "<leader>cr", ":CompetiTest run <CR>", { desc = "Run testcases" })
vim.keymap.set("n", "<leader>cs", ":CompetiTest show_ui <CR>", { desc = "Show ui" })
vim.keymap.set("n", "<leader>cdt", ":CompetiTest receive testcases <CR>", { desc = "Testcases" })
vim.keymap.set("n", "<leader>cdp", ":CompetiTest receive problem <CR>", { desc = "Problem" })
vim.keymap.set("n", "<leader>cdc", ":CompetiTest receive contest <CR>", { desc = "Contest" })

local function navigate_problem(offset, direction_name)
	-- 1. Get current file and directory info
	local file = vim.fn.expand("%:p:h")
	local head = vim.fn.fnamemodify(file, ":h") -- Parent directory path
	local tail = vim.fn.fnamemodify(file, ":t") -- Current directory name (e.g., 'ProblemA')

	-- 2. Get sibling dirs and normalize names
	local dirs = vim.fn.globpath(head, "*/", 0, 1) -- e.g., {'/path/to/Contest/ProblemA/', ...}

	for i, d in ipairs(dirs) do
		-- Convert to just the directory name (e.g., 'ProblemA')
		dirs[i] = vim.fn.fnamemodify(d, ":h:t")
	end

	table.sort(dirs) -- Sort them alphabetically

	-- 3. Find the target sibling index
	local target_name
	for i, d in ipairs(dirs) do
		if d == tail then
			-- i is the index of the current directory (tail)
			target_name = dirs[i + offset]
			break
		end
	end

	-- 4. Execute navigation
	if target_name then
		local target_path = head .. "/" .. target_name .. "/main.cpp"
		if vim.fn.filereadable(target_path) == 1 then
			vim.cmd("edit " .. target_path)
		else
			print("No main.cpp found in: " .. target_name)
		end
	else
		print("Already at the " .. direction_name .. " problem")
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
vim.keymap.set("n", "<leader>r", ":RunCode <CR>", { desc = "Run code" })

-- LSP
function stop_lsp_and_unmap()
	vim.keymap.del("n", "<leader>lg")
	vim.keymap.del("n", "<leader>lf")
	vim.keymap.del("n", "<leader>li")
	vim.keymap.del("n", "<leader>lt")
	vim.keymap.del({ "n", "v" }, "<leader>la")
	vim.keymap.del("n", "<leader>lr")
	vim.keymap.del("n", "<leader>lD")
	vim.keymap.del("n", "<leader>ld")
	vim.keymap.del("n", "[d")
	vim.keymap.del("n", "]d")
	vim.keymap.del("n", "<leader>lp")
	vim.keymap.set("n", "<leader>ls", start_lsp_and_map, { desc = "Start LSP" })
	vim.cmd("LspStop")
end

function start_lsp_and_map()
	vim.keymap.set("n", "<leader>lg", vim.lsp.buf.declaration, { desc = "Go to declaration" })
	vim.keymap.set("n", "<leader>lf", "<cmd>Telescope lsp_definitions<CR>", { desc = "Show definitions" })
	vim.keymap.set("n", "<leader>li", "<cmd>Telescope lsp_implementations<CR>", { desc = "Show implementations" })
	vim.keymap.set("n", "<leader>lt", "<cmd>Telescope lsp_type_definitions<CR>", { desc = "Show type definitions" })
	vim.keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, { desc = "See code actions" })
	vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Smart rename" })
	vim.keymap.set("n", "<leader>lD", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Show buffer diagnostics" })
	vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
	vim.keymap.set("n", "<leader>lp", stop_lsp_and_unmap, { desc = "Stop LSP" })
	vim.keymap.del("n", "<leader>ls")
	vim.cmd("LspStart")
end

vim.keymap.set("n", "<leader>ls", start_lsp_and_map, { desc = "Start LSP", silent = true })
--vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", { desc = "Show references" })
--vim.keymap.set("n", "<leader>lk", vim.lsp.buf.hover, { desc = "Show documentation" })
