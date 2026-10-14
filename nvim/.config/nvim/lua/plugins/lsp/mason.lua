return {
    "mason-org/mason.nvim",

    dependencies = {
        "mason-org/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },

    config = function()
        local mason = require("mason")
        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        local mason_tool_installer = require("mason-tool-installer")
        mason_tool_installer.setup({
            ensure_installed = {
                -- C++
                "clangd",
                "clang-format",

                -- CMake
                "neocmakelsp",
                "cmakelang",

                -- Python
                "pyright",
                "ruff",

                -- Lua
                "lua_ls",
                "stylua",

                -- Markdown
                "prettierd",

                -- Latex
                "texlab",
                "ltex-ls-plus",
            },

            auto_update = true,
        })
    end,
}
