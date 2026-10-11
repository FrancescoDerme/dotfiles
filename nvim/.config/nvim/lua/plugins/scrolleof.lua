return {
    "Aasim-A/scrollEOF.nvim",
    event = { "CursorMoved", "WinScrolled" },
    opts = {
        insert_mode = true,
        -- tuna's floats set their own scrolloff (0 for a list that fits, the global value
        -- for one that scrolls), which scrollEOF would otherwise rewrite on every WinEnter.
        disabled_filetypes = { "terminal", "tuna" },
    },
    config = function(_, opts)
        require("scrollEOF").setup(opts)
        -- scrollEOF sets a window-local scrolloff, and Vim keeps a window-local value per
        -- buffer: a window that :edits a buffer it hasn't shown before falls back to the
        -- global value until the next WinEnter. Reapply it whenever a window shows a buffer.
        vim.api.nvim_create_autocmd("BufWinEnter", {
            group = vim.api.nvim_create_augroup("ScrollEOFBufWinEnter", { clear = true }),
            callback = function()
                vim.api.nvim_exec_autocmds("WinEnter", { group = "ScrollEOF" })
            end,
        })
    end,
}
