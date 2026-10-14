return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        -- Prettier takes ~1s on long markdown files (more on prettierd's start)
        local slow_filetypes = { markdown = true }

        local function format_opts(bufnr)
            return {
                lsp_format = "fallback",
                async = false,
                timeout_ms = slow_filetypes[vim.bo[bufnr].filetype] and 3000 or 1000,
            }
        end

        conform.setup({
            formatters_by_ft = {
                cpp = { "clang-format" },
                cmake = { "cmake_format" },
                python = { "ruff_organize_imports", "ruff_format" },
                lua = { "stylua" },
                markdown = { "prettierd", "prettier", stop_after_first = true },
            },
            formatters = {
                ["clang-format"] = {
                    prepend_args = {
                        "--style={BasedOnStyle: google, IndentWidth: 4, ColumnLimit : 75, BreakBeforeBraces: Custom, BraceWrapping: {AfterFunction: false, BeforeElse: true}}",
                    },
                },
                stylua = {
                    -- 4 spaces, unless the project has its own stylua.toml (this config has one)
                    prepend_args = function(_, ctx)
                        if vim.fs.root(ctx.dirname, { "stylua.toml", ".stylua.toml" }) then
                            return {}
                        end
                        return { "--indent-type", "Spaces", "--indent-width", "4" }
                    end,
                },
            },

            format_on_save = function(bufnr)
                return format_opts(bufnr)
            end,
        })

        vim.keymap.set({ "n", "v" }, "<leader>p", function()
            conform.format(format_opts(0))
        end, { desc = "Format" })
    end,
}
