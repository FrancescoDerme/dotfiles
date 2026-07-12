return {
    "Aasim-A/scrollEOF.nvim",
    event = { "CursorMoved", "WinScrolled" },
    opts = {
        insert_mode = true,
        -- scrollEOF's vim_resized_cb writes the *global* scrolloff off the focused
        -- window's height on BufEnter, without excluding floats. A short float (e.g.
        -- tuna's 1-line input prompt -> height/2 = 0) would clobber global scrolloff
        -- to 0. Disabling it for "tuna"-filetype floats prevents that. "terminal" is
        -- re-listed because setting this key replaces the plugin's default
        disabled_filetypes = { "terminal", "tuna" },
    },
}
