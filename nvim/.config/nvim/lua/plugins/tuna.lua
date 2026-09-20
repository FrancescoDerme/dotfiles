return {
    "FrancescoDerme/tuna.nvim",
    dir = "~/projects/tuna.nvim",
    config = function()
        -- Only non-default settings are listed; everything else uses the plugin
        -- defaults (see tuna's config.lua).
        require("tuna").setup({
            -- Directional pane focus with <M-hjkl> everywhere. The plugin-wide
            -- switch_window_keys (results UI + clean form) default to <C-hjkl>; the
            -- two-pane testcase editor keeps its own <C-h>/<C-l>/<C-i> default.
            switch_window_keys = { "<M-h>", "<M-j>", "<M-k>", "<M-l>" },
            editor_ui = {
                normal_mode_mappings = { switch_window = { "<M-h>", "<M-j>", "<M-k>", "<M-l>" } },
                insert_mode_mappings = { switch_window = { "<M-h>", "<M-j>", "<M-k>", "<M-l>" } },
            },
            compile_command = {
                c = { exec = "gcc", args = { "-Wall", "$(FNAME)", "-o", "/tmp/$(FNOEXT)" } },
                cpp = {
                    -- These cpp flags are pretty heavy (both in terms of compilation and of runtime),
                    -- this is alleviated by the fact that this setup has another way of running code,
                    -- and by the presence of a precompiled bits header (which was compiled with these exact flags)
                    -- inside ~/cp/bits/stdc++.h.gch. One must strictly follow the rules of precompiled headers
                    -- for this to work
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
                        "/tmp/$(FNOEXT)",
                    },
                },
            },
            -- The binary is built into /tmp (see compile_command); the running
            -- directory stays the problem folder (the default) so it still finds
            -- the input.
            run_command = {
                c = { exec = "/tmp/$(FNOEXT)" },
                cpp = { exec = "/tmp/$(FNOEXT)" },
            },

            -- Store problems/contests under ~/cp, one dir per problem, from a template.
            -- Tried in order, first that exists wins: a judge with its own template
            -- gets it, everything else falls back to the general one.
            template_file = { "~/cp/template.$(JUDGE).$(FEXT)", "~/cp/template.$(FEXT)" },
            evaluate_template_modifiers = true,
            -- Start on the first line of solve(), where typing actually begins,
            -- instead of on the template's header. Anchored to the function rather
            -- than to a line number, so editing the template can't move it. Applied
            -- whenever tuna opens a file made from the template — a downloaded problem,
            -- `:Tuna next`/`prev`, `:Tuna temp`.
            template_cursor = { pattern = "^void solve", offset = 1 },
            downloaded_problems_path = "$(HOME)/cp/problems/$(JUDGE)/$(PROBLEM)/main.$(FEXT)",
            downloaded_contests_directory = "$(HOME)/cp/contests/$(JUDGE)/$(CONTEST)",
            downloaded_contests_problems_path = "$(PROBLEM)/main.$(FEXT)",

            -- Submit via "subwithoutcred <URL> <LANG> <FILE>" (the Rust submitter),
            -- tracked as an async job (watch) so the judge verdict shows in lualine
            -- per problem until the next submit. The URL comes from the template's
            -- "// submit at: $(URL)" header line or the downloaded-problem sidecar.
            submit = {
                command = 'subwithoutcred "$(URL)" "$(LANG)" "$(FABSPATH)"',
                watch = true,
                -- Verdict colors, matching the statusline palette (same green/red as
                -- the LSP indicator) rather than the plugin's default highlight groups.
                verdict_hl = {
                    pending = { fg = "#ECBE7B" },
                    accepted = { fg = "#98be65" },
                    partial = { fg = "#ECBE7B" },
                    rejected = { fg = "#ff6c6b" },
                    error = { fg = "#ff6c6b" },
                },
                -- Per-judge routing. AtCoder gates submission behind a Cloudflare
                -- Turnstile challenge that no headless client / CLI submitter
                -- can solve, so command-line submission is impossible.
                -- Hand off to the browser instead: the "browser" provider opens the
                -- submit page with the task preselected and copies the source to the
                -- system clipboard.
                judges = {
                    atcoder = {
                        provider = "browser",
                    },
                },
            },

            -- Algorithm library for `:Tuna lib` (<leader>tl). Files are offered by
            -- extension; parts of a file worth copying on their own are marked in
            -- place with a pair of comments:
            --   // TUNALIB: binary exp start   …   // TUNALIB: binary exp end
            -- A file with no such guards is still offered, whole.
            library = {
                path = "~/cp/snippets",
            },

            -- The whole default keymap set under <leader>t (buffer-local on solution
            -- files, global for what is reached for with no solution open):
            --   tt{a,e,d} testcases   tr run       tu show ui   ts submit
            --   tn/tp problem back and forth       tm menu tl library
            --   tw scratch                         td{t,p,c,s} download testcases/problem/contest/sync
            --   tg{p,c} back to the last problem/contest (cwd included, across restarts)
            keymaps = {
                preset = "<leader>t",
            },
        })
    end,
}
