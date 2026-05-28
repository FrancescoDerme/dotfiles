return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        local npairs = require("nvim-autopairs")

        -- Initialize the plugin and load default rules
        npairs.setup({})

        -- Modify the behavior for these specific rules
        local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" } }

        for _, bracket in ipairs(brackets) do
            local open = bracket[1]
            local close = bracket[2]

            -- Lua patterns treat brackets as magic characters, so we must escape them with '%'
            local open_pat = "%" .. open
            local close_pat = "%" .. close

            -- Get the default rules that nvim-autopairs already created for this bracket
            local rules = npairs.get_rules(open)

            for _, rule in ipairs(rules) do
                -- Modify insertion behavior
                rule:with_pair(function()
                    local bufnr = vim.api.nvim_get_current_buf()
                    -- Get all lines in the current buffer
                    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
                    local open_count = 0
                    local close_count = 0

                    -- Fast counting across the entire buffer
                    for _, line in ipairs(lines) do
                        local _, o_cnt = line:gsub(open_pat, "")
                        local _, c_cnt = line:gsub(close_pat, "")
                        open_count = open_count + o_cnt
                        close_count = close_count + c_cnt
                    end

                    -- If we already have more closing brackets than opening ones globally,
                    -- return false to prevent inserting another closing bracket
                    if close_count > open_count then
                        return false
                    end

                    return true
                end)

                -- Modify deletion behavior
                rule:with_del(function(opts)
                    local line = opts.line

                    -- Fast counting on the current line
                    local _, open_count = line:gsub(open_pat, "")
                    local _, close_count = line:gsub(close_pat, "")

                    -- If we have more opening brackets than closing brackets,
                    -- deleting the closing bracket will mess up the balance,
                    -- so return false to prevent the deletion of the closing bracket
                    if open_count > close_count then
                        return false
                    end

                    -- Otherwise, it's balanced, so return true to delete both
                    return true
                end)
            end
        end
    end,
}
