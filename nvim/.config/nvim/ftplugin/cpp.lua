-- Code runner
vim.keymap.set("n", "<leader>r", function()
    vim.cmd("write")

    local function execute_and_focus()
        -- Run the code
        vim.cmd("RunCode")

        -- Jump to the terminal window and enter insert mode
        vim.cmd("wincmd l")
        vim.schedule(function()
            vim.cmd("startinsert")
        end)
    end

    -- Find the terminal channel
    local chan = 0
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[buf].buftype == "terminal" then
            chan = vim.bo[buf].channel
            if chan > 0 then
                -- \x03 is Ctrl-C (cancels running process)
                vim.api.nvim_chan_send(chan, "\x03")
                break
            end
        end
    end

    -- Delay the execution slightly if the terminal was cleared
    if chan > 0 then
        vim.defer_fn(function()
            -- \x15 is Ctrl-U (clears the line)
            -- \x0c is Ctrl-L (scroll the terminal window so that the new line is uptop)
            vim.api.nvim_chan_send(chan, "\x15\x0c")

            vim.defer_fn(function()
                execute_and_focus()
            end, 100)
        end, 100)
    else
        -- If no terminal was found, we want to prewarm a new one so the shell has time to boot and suppress the PTY echo
        -- However, we need to get back to the original window before calling the code_runner plugin
        local original_win = vim.api.nvim_get_current_win()

        vim.cmd("ToggleTerm")
        vim.api.nvim_set_current_win(original_win)

        -- Wait for the shell to finish booting, then execute
        vim.defer_fn(function()
            execute_and_focus()
        end, 100)
    end
end, { buffer = true, desc = "Run code" })
