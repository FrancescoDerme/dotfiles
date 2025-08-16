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
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]f"] = { query = "@call.outer", desc = "Next function call start" },
						["]d"] = { query = "@function.outer", desc = "Next function definition" },
						--["]c"] = { query = "@class.outer", desc = "Next class start" },
						["]p"] = { query = "@parameter.inner", desc = "Next parameter start" },
						["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
						["]l"] = { query = "@loop.outer", desc = "Next loop start" },
					},
					goto_next_end = {
						["]F"] = { query = "@call.outer", desc = "Next function call end" },
						["]D"] = { query = "@function.outer", desc = "Next function def end" },
						--["]C"] = { query = "@class.outer", desc = "Next class end" },
						["]P"] = { query = "@parameter.outer", desc = "Next parameter end" },
						["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
						["]L"] = { query = "@loop.outer", desc = "Next loop end" },
					},
					goto_previous_start = {
						["[f"] = { query = "@call.outer", desc = "Prev function call start" },
						["[d"] = { query = "@function.outer", desc = "Prev method/function def start" },
						--["[c"] = { query = "@class.outer", desc = "Prev class start" },
						["[p"] = { query = "@parameter.inner", desc = "Prev parameter start" },
						["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
						["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
					},
					goto_previous_end = {
						["[F"] = { query = "@call.outer", desc = "Prev function call end" },
						["[D"] = { query = "@function.outer", desc = "Prev method/function def end" },
						--["[C"] = { query = "@class.outer", desc = "Prev class end" },
						["[P"] = { query = "@parameter.outer", desc = "Prev parameter end" },
						["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
						["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
					},
				},
			},
		})

		-- local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

		-- Repeat movement with ; and ,
		-- ensure ; goes forward and , goes backward regardless of the last direction
		--vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
		--vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

		-- vim way: ; goes to the direction you were moving.
		-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
		-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

		--[[
		-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
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
