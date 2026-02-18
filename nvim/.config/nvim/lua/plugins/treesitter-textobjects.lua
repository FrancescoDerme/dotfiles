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
						["o="] = { query = "@assignment.outer", desc = "Select outer assignment" },
						["i="] = { query = "@assignment.inner", desc = "Select inner assignment" },
						["l="] = { query = "@assignment.lhs", desc = "Select left assignment" },
						["r="] = { query = "@assignment.rhs", desc = "Select right assignment" },

						["op"] = { query = "@parameter.outer", desc = "Select outer parameter" },
						["ip"] = { query = "@parameter.inner", desc = "Select inner parameter" },

						["oi"] = { query = "@conditional.outer", desc = "Select outer conditional" },
						["ii"] = { query = "@conditional.inner", desc = "Select inner conditional" },

						["ol"] = { query = "@loop.outer", desc = "Select outer loop" },
						["il"] = { query = "@loop.inner", desc = "Select inner loop" },

						["of"] = { query = "@call.outer", desc = "Select outer function call" },
						["if"] = { query = "@call.inner", desc = "Select inner function call" },

						["od"] = { query = "@function.outer", desc = "Select outer function definition" },
						["id"] = { query = "@function.inner", desc = "Select inner function definition" },

						["oc"] = { query = "@class.outer", desc = "Select outer class" },
						["ic"] = { query = "@class.inner", desc = "Select inner class" },
					},
				},
				-- Swaps are rerely useful and clutter the config
				--[[
				swap = {
					enable = true,
					swap_next = {
						["<leader>snp"] = { query = "@parameter.inner", desc = "Swap next parameters" },
						["<leader>snd"] = { query = "@function.outer", desc = "Swap next function definitions" },
					},
					swap_previous = {
						["<leader>spp"] = { query = "@parameter.inner", desc = "Swap prev parameters" },
						["<leader>spd"] = { query = "@function.outer", desc = "Swap prev function definitions" },
					},
				},
                ]]
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]fs"] = { query = "@call.outer", desc = "Start" },
						["]ds"] = { query = "@function.outer", desc = "Start" },
						["]is"] = { query = "@conditional.outer", desc = "Start" },
						["]ls"] = { query = "@loop.outer", desc = "Start" },
						--["]cs"] = { query = "@class.outer", desc = "Start" },
						--["]ps"] = { query = "@parameter.inner", desc = "Start" },
					},
					goto_next_end = {
						["]fe"] = { query = "@call.outer", desc = "End" },
						["]de"] = { query = "@function.outer", desc = "End" },
						["]ie"] = { query = "@conditional.outer", desc = "End" },
						["]le"] = { query = "@loop.outer", desc = "End" },
						--["]ce"] = { query = "@class.outer", desc = "End" },
						--["]pe"] = { query = "@parameter.outer", desc = "End" },
					},
					goto_previous_start = {
						["[fs"] = { query = "@call.outer", desc = "Start" },
						["[ds"] = { query = "@function.outer", desc = "Start" },
						["[is"] = { query = "@conditional.outer", desc = "Start" },
						["[ls"] = { query = "@loop.outer", desc = "Start" },
						--["[cs"] = { query = "@class.outer", desc = "Start" },
						--["[ps"] = { query = "@parameter.inner", desc = "Start" },
					},
					goto_previous_end = {
						["[fe"] = { query = "@call.outer", desc = "End" },
						["[de"] = { query = "@function.outer", desc = "End" },
						["[ie"] = { query = "@conditional.outer", desc = "End" },
						["[le"] = { query = "@loop.outer", desc = "End" },
						--["[ce"] = { query = "@class.outer", desc = "End" },
						--["[pe"] = { query = "@parameter.outer", desc = "End" },
					},
				},
			},
		})

		-- The next blocks are commented because moves are made repeatable through the demicolon plugin

		--[[
		local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

		-- Repeat movement with ; and ,
		-- Option 1: ; goes forward and , goes backward regardless of the last direction
		vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
		vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

		-- Option 2: ; goes forawrd in the last direction
		-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
		-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
        ]]

		--[[
		-- Make builtin f, F, t, T also repeatable with ; and ,
		vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
		vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
		vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
		vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
		]]

		--[[
		local fl = require("flash")
		local Config = require("flash.config")
		opts = Config.get({ mode = "char" }, opts)
		local next_jump_repeat, prev_jump_repeat = ts_repeat_move.make_repeatable_move_pair(fl.jump, fl.jump)
		vim.keymap.set({ "n", "x", "o" }, "f", next_jump_repeat)
		vim.keymap.set({ "n", "x", "o" }, "s", prev_jump_repeat)
		]]
	end,
}
