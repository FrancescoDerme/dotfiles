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
            -- clang-format and stylua read their style from ~/.clang-format and ~/.stylua.toml
            -- (the clang-format and stylua packages in the dotfiles)

            format_on_save = function(bufnr)
                return format_opts(bufnr)
            end,
        })

        vim.keymap.set({ "n", "v" }, "<leader>p", function()
            conform.format(format_opts(0))
        end, { desc = "Format" })
    end,
}
