vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

vim.wo.relativenumber = true
vim.wo.number = true
vim.g.mapleader = " "
vim.opt.cursorline = true

-- vim.opt.signcolumn = "yes"
-- vim.g.maplocalleader = " "

vim.diagnostic.config({
	--[[
	signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = "󰠠 ",
            [vim.diagnostic.severity.INFO] = " ",
        },
    },
    ]]
	signs = false,
	underline = true,
	virtual_text = false,
	update_in_insert = false,
})
