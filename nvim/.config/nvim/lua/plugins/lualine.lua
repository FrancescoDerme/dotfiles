return {
    "nvim-lualine/lualine.nvim",
    config = function()
        -- Stopped clients stay attached for a few seconds while the server shuts down
        local function live_lsp_clients()
            return vim.tbl_filter(function(client)
                return not client:is_stopped()
            end, vim.lsp.get_clients({ bufnr = 0 }))
        end

        require("lualine").setup({
            options = {
                theme = "palenight",
                globalstatus = true,
                -- tuna's floats (results UI, menu, prompts) have filetype "tuna":
                -- keep describing the file underneath while one has focus.
                ignore_focus = { "tuna" },
            },
            extensions = {
                "neo-tree",
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = {
                    {
                        "branch",
                        -- The branch is looked up on BufEnter from the buffer entered, so a
                        -- tuna float (tuna://…, no repository) blanks it while ignore_focus
                        -- keeps the statusline on the file underneath. This runs in that
                        -- file's window, so look the branch up again from there.
                        fmt = function(str)
                            if str ~= "" then
                                return str
                            end
                            local git_branch = require("lualine.components.branch.git_branch")
                            git_branch.find_git_dir()
                            return git_branch.get_branch()
                        end,
                    },
                    "diff",
                    "diagnostics",
                },
                lualine_c = { "filename" },
                lualine_x = {
                    {
                        function()
                            return require("tuna").lualine_component()
                        end,
                        cond = function()
                            local ok, download = pcall(require, "tuna.download")
                            return ok and download.is_downloading()
                        end,
                        color = { fg = "#82aaff", gui = "bold" },
                    },
                    {
                        -- Submit verdict (watch mode): per-problem, persistent, colored
                        -- by verdict via tuna's TunaCorrect/TunaWrong/TunaWarning groups.
                        function()
                            return require("tuna.submit").status()
                        end,
                        cond = function()
                            local ok, submit = pcall(require, "tuna.submit")
                            return ok and submit.is_submitting()
                        end,
                        color = function()
                            return require("tuna.submit").status_hl()
                        end,
                    },
                    {
                        function()
                            local names = vim.iter(live_lsp_clients())
                                :map(function(client)
                                    return client.name
                                end)
                                :totable()
                            if #names == 0 then
                                return "LSP OFF"
                            end
                            return "LSP: " .. table.concat(names, ", ")
                        end,
                        color = function()
                            return { fg = #live_lsp_clients() > 0 and "#98be65" or "#ff6c6b" }
                        end,
                    },
                    "filetype",
                },
                lualine_y = {},
                lualine_z = { "location" },
            },
        })
    end,
}
