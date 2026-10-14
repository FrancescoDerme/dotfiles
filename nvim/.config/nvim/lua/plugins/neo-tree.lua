return {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-mini/mini.icons",
        -- Set up in config below, it only hooks into neo-tree if neo-tree is already loaded
        "antosha417/nvim-lsp-file-operations",
    },
    config = function()
        require("neo-tree").setup({
            filesystem = {
                -- With this enabled, Neotree would fight against Oil when opening a directory
                hijack_netrw_behavior = "disabled",

                filtered_items = {
                    -- Avoid hiding gitignored files.
                    hide_gitignored = false,
                },

                -- Add custom components
                components = {
                    name = function(config, node, state)
                        -- Call the original name component
                        local fc = require("neo-tree.sources.filesystem.components")
                        local result = fc.name(config, node, state)

                        -- Avoid greying-out gitignored files.
                        local git = state.components.git_status({}, node, state)
                        if git and git.highlight == "NeoTreeGitIgnored" then
                            result.highlight = node.type == "directory" and "NeoTreeDirectoryName" or "NeoTreeFileName"
                        end

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
                        -- Like :setlocal, so the global value is left alone
                        vim.wo[0][0].relativenumber = true
                    end,
                },
            },
        })

        -- Tell the LSP about files renamed/moved/created/deleted from neo-tree
        require("lsp-file-operations").setup()
    end,
}
