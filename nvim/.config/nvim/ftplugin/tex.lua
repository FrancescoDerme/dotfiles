-- Name the group in Which-Key
local ok, wk = pcall(require, "which-key")
if ok then
	wk.add({
		{ "<localleader>l", group = "VimTeX", buffer = 0 },
	})
end

-- Core compilation and viewing
vim.keymap.set("n", "<localleader>ll", "<plug>(vimtex-compile)", { buffer = true, desc = "Compile" })
vim.keymap.set("n", "<localleader>lv", "<plug>(vimtex-view)", { buffer = true, desc = "View PDF" })
vim.keymap.set("n", "<localleader>li", "<plug>(vimtex-info)", { buffer = true, desc = "Info" })
vim.keymap.set("n", "<localleader>lI", "<plug>(vimtex-info-full)", { buffer = true, desc = "Info (Full)" })

-- Utility commands
vim.keymap.set("n", "<localleader>lc", "<plug>(vimtex-clean)", { buffer = true, desc = "Clean Aux Files" })
vim.keymap.set("n", "<localleader>lC", "<plug>(vimtex-clean-full)", { buffer = true, desc = "Clean All Files" })
vim.keymap.set("n", "<localleader>lk", "<plug>(vimtex-stop)", { buffer = true, desc = "Stop Compilation" })
vim.keymap.set("n", "<localleader>lK", "<plug>(vimtex-stop-all)", { buffer = true, desc = "Stop All" })
vim.keymap.set("n", "<localleader>le", "<plug>(vimtex-errors)", { buffer = true, desc = "Show Errors" })

-- Navigation / TOC
vim.keymap.set("n", "<localleader>lt", "<plug>(vimtex-toc-open)", { buffer = true, desc = "Open TOC" })
vim.keymap.set("n", "<localleader>lT", "<plug>(vimtex-toc-toggle)", { buffer = true, desc = "Toggle TOC" })
