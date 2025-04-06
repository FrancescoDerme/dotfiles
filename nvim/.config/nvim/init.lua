local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)
local opts = {}

-- Attemp at writing a lua script to compile and run inside neovim, replaced by competitest!
--require("compile-and-run")

require("vim-options")
require("lazy").setup("plugins")
require("mappings")
require("flash").toggle()
