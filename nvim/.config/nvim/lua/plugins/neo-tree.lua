return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "echasnovski/mini.icons",
    },
    config = function()
        -- Force mini.icons to pretend to be nvim-web-devicons
        require("mini.icons").mock_nvim_web_devicons()

        require("neo-tree").setup({
            filesystem = {
                -- With this enabled, Neotree would fight against Oil when opening a directory
                hijack_netrw_behavior = "disabled",

                -- Add custom components
                components = {
                    name = function(config, node, state)
                        -- Call the original name component
                        local fc = require("neo-tree.sources.filesystem.components")
                        local result = fc.name(config, node, state)

                        -- Modify the message "x hidden items"
                        -- Check if this is a message node and if it contains the word "hidden"
                        if node.type == "message" and result.text and result.text:match("hidden") then
                            -- Extract the number from the default string
                            local count = result.text:match("(%d+)")

                            if count then
                                -- Handle singular/plural
                                local item_word = tonumber(count) == 1 and "item" or "items"

                                -- Modify the text
                                result.text = string.format("%s hidden %s,\nH to show", count, item_word)
                            end
                        end

                        return result
                    end,
                },
            },
            event_handlers = {
                {
                    event = "neo_tree_buffer_enter",
                    handler = function()
                        vim.opt.relativenumber = true
                    end,
                },
            },
        })
    end,
}
