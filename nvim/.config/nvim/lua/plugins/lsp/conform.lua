return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                cpp = { "clang-format" },
                cmake = { "cmake_format" },
                python = { "isort", "black" },
                lua = { "stylua" },
                markdown = { "prettier" },
            },
            formatters = {
                ["clang-format"] = {
                    prepend_args = {
                        "--style={BasedOnStyle: google, IndentWidth: 4, ColumnLimit : 75, BreakBeforeBraces: Custom, BraceWrapping: {AfterFunction: false, BeforeElse: true}}",
                    },
                },
                stylua = {
                    prepend_args = { "--indent-type", "Spaces", "--indent-width", "4" },
                },
            },

            format_on_save = {
                lsp_format = "fallback",
                async = false,
                timeout_ms = 1000,
            },
        })

        vim.keymap.set({ "n", "v" }, "<leader>p", function()
            conform.format({
                lsp_format = "fallback",
                async = false,
                timeout_ms = 1000,
            })
        end, { desc = "Format" })
    end,
}
