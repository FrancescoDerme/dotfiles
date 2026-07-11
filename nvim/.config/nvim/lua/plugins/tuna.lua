return {
    "FrancescoDerme/tuna.nvim",
    dir = "~/projects/tuna.nvim",
    config = function()
        require("tuna").setup({
            floating_border = "rounded",
            floating_border_highlight = "FloatBorder",
            picker_ui = {
                width = 0.2,
                height = 0.3,
                mappings = {
                    focus_next = { "j", "<down>", "<Tab>" },
                    focus_prev = { "k", "<up>", "<S-Tab>" },
                    close = { "<esc>", "<C-c>", "q", "Q" },
                    submit = "<cr>",
                },
            },
            editor_ui = {
                width = 0.4,
                height = 0.6,
                show_nu = true,
                show_rnu = false,
                normal_mode_mappings = {
                    switch_window = { "<M-h>", "<M-j>", "<M-k>", "<M-l>" },
                    save_and_close = "<C-s>",
                    cancel = { "q", "Q" },
                },
                insert_mode_mappings = {
                    switch_window = { "<M-h>", "<M-j>", "<M-k>", "<M-l>" },
                    save_and_close = "<C-s>",
                    cancel = "<C-q>",
                },
            },
            runner_ui = {
                interface = "popup",
                selector_show_nu = false,
                selector_show_rnu = false,
                show_nu = true,
                show_rnu = false,
                mappings = {
                    switch_window = { "<M-h>", "<M-j>", "<M-k>", "<M-l>" },
                    run_again = "R",
                    run_all_again = "<C-r>",
                    kill = "K",
                    kill_all = "<C-k>",
                    view_input = { "i", "I" },
                    view_output = { "a", "A" },
                    view_stdout = { "o", "O" },
                    view_stderr = { "e", "E" },
                    toggle_diff = { "d", "D" },
                    close = { "<esc>", "<C-c>", "q", "Q" },
                },
                viewer = {
                    -- the viewer closes with runner_ui.mappings.close above
                    width = 0.8,
                    height = 0.8,
                    show_nu = true,
                    show_rnu = false,
                    open_when_compilation_fails = true,
                },
            },
            popup_ui = {
                total_width = 0.8,
                total_height = 0.8,
                layout = {
                    { 4, "tc" },
                    { 5, { { 1, "so" }, { 1, "si" } } },
                    { 5, { { 1, "eo" }, { 1, "se" } } },
                },
            },
            split_ui = {
                position = "right",
                relative_to_editor = true,
                total_width = 0.3,
                vertical_layout = {
                    { 1, "tc" },
                    { 1, { { 1, "so" }, { 1, "eo" } } },
                    { 1, { { 1, "si" }, { 1, "se" } } },
                },
                total_height = 0.4,
                horizontal_layout = {
                    { 2, "tc" },
                    { 3, { { 1, "so" }, { 1, "si" } } },
                    { 3, { { 1, "eo" }, { 1, "se" } } },
                },
            },

            save_current_file = true,
            save_all_files = false,
            -- Compile directory must be the problem folder to find the source file
            compile_directory = ".",
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
            -- Even though the binary lives in /tmp/, it executes as if it is in the problem folder,
            -- hence it's able to find the input
            running_directory = ".",
            run_command = {
                c = { exec = "/tmp/$(FNOEXT)" },
                cpp = { exec = "/tmp/$(FNOEXT)" },
                python = { exec = "python3", args = { "$(FNAME)" } },
            },
            multiple_testing = -1,
            maximum_time = 5000,
            output_compare_method = "squish",
            view_output_diff = false,

            testcases_directory = ".",
            testcases_storage = "files",
            testcases_auto_detect = true,
            testcases_single_file_format = "$(FNOEXT).testcases",
            -- Ordered list: source-named pair first (canonical, what `write` uses),
            -- then a shared un-prefixed `input<N>.txt` so any solution in a folder
            -- (e.g. `:Tuna run all`) discovers testcases it didn't itself create.
            testcases_input_file_format = { "$(FNOEXT)_input$(TCNUM).txt", "input$(TCNUM).txt" },
            testcases_output_file_format = { "$(FNOEXT)_output$(TCNUM).txt", "output$(TCNUM).txt" },

            companion_port = 27121,
            receive_print_message = true,
            template_file = "~/cp/template.$(FEXT)",
            evaluate_template_modifiers = true,
            date_format = "%c",
            received_files_extension = "cpp",
            received_problems_path = "$(HOME)/cp/problems/$(JUDGE)/$(PROBLEM)/main.$(FEXT)",
            received_problems_prompt_path = true,
            received_contests_directory = "$(HOME)/cp/contests/$(JUDGE)/$(CONTEST)",
            received_contests_problems_path = "$(PROBLEM)/main.$(FEXT)",
            received_contests_prompt_directory = true,
            received_contests_prompt_extension = true,
            open_received_problems = true,
            open_received_contests = true,
            replace_received_testcases = false,
        })
    end,
}
