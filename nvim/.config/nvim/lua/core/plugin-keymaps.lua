-- Neotree
vim.keymap.set("n", "<leader>e", ":Neotree filesystem toggle left <CR>", { desc = "File tree", silent = true })

-- Telescope
vim.keymap.set("n", "<leader>fd", ":Telescope live_grep <CR>", { desc = "Text in directory" })
vim.keymap.set("n", "<leader>fb", ":Telescope current_buffer_fuzzy_find <CR>", { desc = "Text in buffer" })
vim.keymap.set("n", "<leader>ff", ":Telescope find_files <CR>", { desc = "File in directory" })

-- Oil
vim.keymap.set("n", "<leader>oe", ":Oil <CR>", { desc = "File explorer" })
vim.keymap.set("n", "<leader>of", ":Oil --float <CR>", { desc = "Floating file explorer" })

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
			vim.cmd("lsp disable " .. server)
		end
		vim.notify("LSP Disabled", vim.log.levels.INFO, { title = "LSP System" })
	else
		for _, server in ipairs(servers) do
			vim.cmd("lsp enable " .. server)
		end
		vim.notify("LSP Enabled", vim.log.levels.INFO, { title = "LSP System" })
	end
end, { desc = "Toggle LSP" })

--vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", { desc = "Show references" })
--vim.keymap.set("n", "<leader>lk", vim.lsp.buf.hover, { desc = "Show documentation" })
