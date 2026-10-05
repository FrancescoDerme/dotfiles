return {
    "FrancescoDerme/tuna.nvim",
    dir = "~/projects/tuna.nvim",
    config = function()
        -- Only non-default settings are listed.
        require("tuna").setup({
            -- Directional pane focus.
            switch_window_keys = { "<M-h>", "<M-j>", "<M-k>", "<M-l>" },
            compile_command = {
                cpp = {
                    -- These cpp flags are pretty heavy (both in terms of compilation and of runtime),
                    -- this is alleviated by the fact that this setup has another way of running code,
                    -- and by the presence of a precompiled bits header (which was compiled with these exact flags)
                    -- inside ~/cp/bits/stdc++.h.gch.
                    exec = "g++",
                    args = {
                        "-std=c++23",
                        "-DLOCAL",
                        "-Wall",
                        "-Wextra",
                        "-Wshadow",
                        "-fsanitize=address,undefined",
                        "-D_GLIBCXX_DEBUG",
                        "-I$(HOME)/cp",
                        "$(FNAME)",
                        "-o",
                        "$(FNOEXT)",
                    },
                },
            },

            -- Template files, tried in order, and the first that exists wins, so a judge with
            -- its own template gets it, everything else falls back to the general one.
            template_file = { "~/cp/template.$(JUDGE).$(FEXT)", "~/cp/template.$(FEXT)" },

            -- Start on the first line of solve(), instead of on the template's header.
            -- Anchored to the function rather than to a line number, so editing the template
            -- doesn't move it. Applied whenever tuna opens a downloaded problem, or after
            -- `:Tuna next`/`prev`, `:Tuna scratch`, etc.
            template_cursor = { pattern = "^void solve", offset = 1 },

            -- Store problems and contests under ~/cp.
            downloaded_problems_path = "$(HOME)/cp/problems/$(JUDGE)/$(PROBLEM)/main.$(FEXT)",
            downloaded_contests_directory = "$(HOME)/cp/contests/$(JUDGE)/$(CONTEST)",
            downloaded_contests_problems_path = "$(PROBLEM)/main.$(FEXT)",

            -- Submit with submitter, run from ~/dotfiles/private so it doesn't ask for
            -- credentials. submitter is tracked as an async job (default, same as watch = true),
            -- so the judge verdict shows in lualine.
            -- The URL comes from a file's "// submit at: $(URL)" header
            -- line or the sidecar for downloaded problems.
            submit = {
                command = 'cd ~/dotfiles/private && submitter "$(URL)" "$(LANG)" "$(FABSPATH)"',

                -- Verdict colors, matching the statusline palette rather than
                -- the plugin's default highlight groups.
                verdict_hl = {
                    pending = { fg = "#ECBE7B" },
                    accepted = { fg = "#98be65" },
                    partial = { fg = "#ECBE7B" },
                    rejected = { fg = "#ff6c6b" },
                    error = { fg = "#ff6c6b" },
                },

                -- Hand off to the browser for AtCoder.
                -- The browser provider opens the submit page with the task
                -- preselected and copies the source to the system clipboard.
                judges = {
                    atcoder = {
                        provider = "browser",
                    },
                },
            },

            -- Algorithms library for `:Tuna lib`.
            library = {
                path = "~/cp/snippets",
            },

            -- The whole default keymap set under <leader>t (buffer-local for what is
            -- useful on solution files, global for what is always useful).
            keymaps = {
                preset = "<leader>t",
            },
        })
    end,
}
