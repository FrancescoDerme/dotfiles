return {
    "akinsho/toggleterm.nvim",
    version = "*",
    -- "+" must match open_mapping below
    keys = { { "+", desc = "Toggle terminal" } },
    cmd = { "ToggleTerm", "TermExec", "TermSelect", "ToggleTermToggleAll", "ToggleTermSetName" },
    opts = {
        size = function(term)
            if term.direction == "horizontal" then
                return 15
            elseif term.direction == "vertical" then
                return vim.o.columns * 0.5
            end
        end,
        open_mapping = [[+]],
        insert_mappings = false,
        direction = "vertical",
        start_in_insert = false,
    },
}
