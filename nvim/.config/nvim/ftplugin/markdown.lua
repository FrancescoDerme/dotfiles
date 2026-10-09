-- Preview markdown files
vim.keymap.set("n", "<leader>m", ":MarkdownPreviewToggle<CR>", {
	buffer = true,
	desc = "Markdown preview",
})

-- Prewarm prettierd so the first save doesn't pay Node's startup cost
-- (no-op if it's already running)
vim.system({ vim.fn.stdpath("data") .. "/mason/bin/prettierd", "start" })
