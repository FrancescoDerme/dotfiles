return {
    "FrancescoDerme/tuna.nvim",
    dir = "~/projects/tuna.nvim",
    config = function()
        -- Only non-default settings are listed; everything else uses the plugin
        -- defaults (see tuna's config.lua).
        require("tuna").setup({
            -- Directional pane focus with <M-hjkl> (the editor UI defaults to
            -- <C-h>/<C-l>/<C-i>); the runner UI already uses <M-hjkl>.
            editor_ui = {
                normal_mode_mappings = { switch_window = { "<M-h>", "<M-j>", "<M-k>", "<M-l>" } },
                insert_mode_mappings = { switch_window = { "<M-h>", "<M-j>", "<M-k>", "<M-l>" } },
            },
            runner_ui = {
                -- also close with <esc>/<C-c> (default is just q/Q), and a bigger viewer
                mappings = { close = { "<esc>", "<C-c>", "q", "Q" } },
                viewer = { width = 0.8, height = 0.8 },
            },
            popup_ui = {
                -- taller testcase selector; wider detail panes
                layout = {
                    { 4, "tc" },
                    { 5, { { 1, "so" }, { 1, "si" } } },
                    { 5, { { 1, "eo" }, { 1, "se" } } },
                },
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
            template_file = "~/cp/template.$(FEXT)",
            evaluate_template_modifiers = true,
            received_problems_path = "$(HOME)/cp/problems/$(JUDGE)/$(PROBLEM)/main.$(FEXT)",
            received_contests_directory = "$(HOME)/cp/contests/$(JUDGE)/$(CONTEST)",
            received_contests_problems_path = "$(PROBLEM)/main.$(FEXT)",

            -- Submit via "subwithoutcred <URL> <LANG> <FILE>" (the Rust submitter),
            -- tracked as an async job (watch) so the judge verdict shows in lualine
            -- per problem until the next submit. The URL comes from the template's
            -- "// submit at: $(URL)" header line or the received-problem sidecar.
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

            -- Opt-in buffer-local keymap on solution files (c/cpp/rust/java/python).
            keymaps = {
                mappings = { submit = "<leader>cs" },
            },
        })
    end,
}
