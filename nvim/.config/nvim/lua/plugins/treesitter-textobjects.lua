return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = true,
    config = function()
        require("nvim-treesitter.configs").setup({
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,

                    keymaps = {
                        ["o="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
                        ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
                        ["l="] = { query = "@assignment.lhs", desc = "Select lhs of an assignment" },
                        ["r="] = { query = "@assignment.rhs", desc = "Select rhs of an assignment" },

                        ["op"] = { query = "@parameter.outer", desc = "Select outer part of a parameter" },
                        ["ip"] = { query = "@parameter.inner", desc = "Select inner part of a parameter" },

                        ["oi"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
                        ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

                        ["ol"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
                        ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

                        ["of"] = { query = "@call.outer", desc = "Select outer part of a function call" },
                        ["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

                        ["od"] = { query = "@function.outer", desc = "Select outer part of a function definition" },
                        ["id"] = { query = "@function.inner", desc = "Select inner part of a function definition" },

                        ["oc"] = { query = "@class.outer", desc = "Select outer part of a class" },
                        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
                    }               
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>snp"] = { query = "@parameter.inner", desc = "Swap next parameters" },
                        ["<leader>snd"] = { query = "@function.outer", desc = "Swap next function definitions" }
                    },
                    swap_previous = {
                        ["<leader>spp"] = { query = "@parameter.inner", desc = "Swap prev parameters" },
                        ["<leader>spd"] = { query = "@function.outer", desc = "Swap prev function definitions" }, 
                    }
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        ["]f"] = { query = "@call.outer", desc = "Next function call start" },
                        ["]d"] = { query = "@function.outer", desc = "Next function definition" },
                        ["]c"] = { query = "@class.outer", desc = "Next class start" },
                        ["]p"] = { query = "@parameter.inner", desc = "Next parameter start" },
                        ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
                        ["]l"] = { query = "@loop.outer", desc = "Next loop start" },
                        --["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                        --["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
                    },
                    goto_next_end = {
                        ["]F"] = { query = "@call.outer", desc = "Next function call end" },
                        ["]D"] = { query = "@function.outer", desc = "Next method/function def end" },
                        ["]C"] = { query = "@class.outer", desc = "Next class end" },
                        ["]P"] = { query = "@parameter.outer", desc = "Next parameter end" },
                        ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
                        ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
                    },
                    goto_previous_start = {
                        ["[f"] = { query = "@call.outer", desc = "Prev function call start" },
                        ["[d"] = { query = "@function.outer", desc = "Prev method/function def start" },
                        ["[c"] = { query = "@class.outer", desc = "Prev class start" },
                        ["[p"] = { query = "@parameter.inner", desc = "Prev parameter start" },
                        ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
                        ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
                    },
                    goto_previous_end = {
                        ["[F"] = { query = "@call.outer", desc = "Prev function call end" },
                        ["[D"] = { query = "@function.outer", desc = "Prev method/function def end" },
                        ["[C"] = { query = "@class.outer", desc = "Prev class end" },
                        ["[P"] = { query = "@parameter.outer", desc = "Prev parameter end" },
                        ["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
                        ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
                    }
                }
            }
        })

        local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

        -- vim way: ; goes to the direction you were moving.
        vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
        vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
    end
}
