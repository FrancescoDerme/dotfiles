vim.cmd("language en_US.utf8")

-- Use spaces instead of tabs
vim.opt.expandtab = true

-- 1 tab = 4 spaces
vim.opt.tabstop = 4

-- Upon pressing press Tab, inserts 4 spaces
vim.opt.softtabstop = 4

-- Indentation level for << and >> commands
vim.opt.shiftwidth = 4

-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Enable relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Don't show the mode since it's already in the statusline
vim.opt.showmode = false

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching unless \C or one or more capital letters in the search term
-- \C is a built-in Vim regex flag that forces case-sensitivity, regardless of settings
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn off by default
vim.opt.signcolumn = "no"

-- Set how certain whitespace characters will be displayed
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions on a little window at the bottom of the screen
vim.opt.inccommand = "split"

-- Show which line the cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor
-- A high number makes the cursor stay in the middle of the screen
vim.opt.scrolloff = 999

-- Manage code indentation
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Set diagnostic options
vim.diagnostic.config({
	signs = false,
	underline = true,
	virtual_text = false,
	update_in_insert = false,
})
