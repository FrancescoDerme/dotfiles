-- Name the group in Which-Key
local ok, wk = pcall(require, "which-key")
if ok then
	wk.add({
		{ "<localleader>v", group = "VimTeX", buffer = 0 },
	})
end

-- Core compilation and viewing
vim.keymap.set("n", "<localleader>vl", "<plug>(vimtex-compile)", { buffer = true, desc = "Compile" })
vim.keymap.set("n", "<localleader>vv", "<plug>(vimtex-view)", { buffer = true, desc = "View PDF" })
vim.keymap.set("n", "<localleader>vi", "<plug>(vimtex-info)", { buffer = true, desc = "Info" })
vim.keymap.set("n", "<localleader>vI", "<plug>(vimtex-info-full)", { buffer = true, desc = "Info (Full)" })

-- Utility commands
vim.keymap.set("n", "<localleader>vc", "<plug>(vimtex-clean)", { buffer = true, desc = "Clean Aux Files" })
vim.keymap.set("n", "<localleader>vC", "<plug>(vimtex-clean-full)", { buffer = true, desc = "Clean All Files" })
vim.keymap.set("n", "<localleader>vk", "<plug>(vimtex-stop)", { buffer = true, desc = "Stop Compilation" })
vim.keymap.set("n", "<localleader>vK", "<plug>(vimtex-stop-all)", { buffer = true, desc = "Stop All" })
vim.keymap.set("n", "<localleader>ve", "<plug>(vimtex-errors)", { buffer = true, desc = "Show Errors" })

-- Navigation / TOC
vim.keymap.set("n", "<localleader>vt", "<plug>(vimtex-toc-open)", { buffer = true, desc = "Open TOC" })
vim.keymap.set("n", "<localleader>vT", "<plug>(vimtex-toc-toggle)", { buffer = true, desc = "Toggle TOC" })
