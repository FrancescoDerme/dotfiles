return {
	"mawkler/demicolon.nvim",
	branch = "repeated",

	-- These keymaps are used for lazily loading the plugin
	-- They are defined at the bottom of this file
	keys = {
		-- Flash
		{ "f", desc = "Flash f" },
		{ "F", desc = "Flash F" },
		{ "t", desc = "Flash t" },
		{ "T", desc = "Flash T" },
		{ "s", desc = "Flash s" },

		-- Treesitter textobjects
		{ "]d", desc = "Function definition" },
		{ "[d", desc = "Function definition" },
		{ "]f", desc = "Function call" },
		{ "[f", desc = "Function call" },
		{ "]i", desc = "Conditional" },
		{ "[i", desc = "Condtional" },
		{ "]l", desc = "Loop" },
		{ "[l", desc = "Loop" },
	},

	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-treesitter/nvim-treesitter-textobjects",
	},

	config = function()
		require("demicolon").setup({
			keymaps = {
				horizontal_motions = false,
			},
		})

		local flash_char = require("flash.plugins.char")
		---@param options { key: string, forward: boolean }
		local function flash_jump(options)
			return function()
				require("demicolon.jump").repeatably_do(function(o)
					local key = o.forward and o.key:lower() or o.key:upper()
					flash_char.jumping = true
					local autohide = require("flash.config").get("char").autohide

					-- Originally was
					-- if require("flash.repeat").is_repeat then
					if o.repeated then
						flash_char.jump_labels = false

						-- Originally was
						-- flash_char.state:jump({ count = vim.v.count1 })
						if o.forward then
							flash_char.right()
						else
							flash_char.left()
						end

						flash_char.state:show()
					else
						flash_char.jump(key)
					end

					vim.schedule(function()
						flash_char.jumping = false
						if flash_char.state and autohide then
							flash_char.state:hide()
						end
					end)
				end, options)
			end
		end

		vim.api.nvim_create_autocmd({ "BufLeave", "CursorMoved", "InsertEnter" }, {
			group = vim.api.nvim_create_augroup("flash_char", { clear = true }),
			callback = function(event)
				local hide = event.event == "InsertEnter" or not flash_char.jumping
				if hide and flash_char.state then
					flash_char.state:hide()
				end
			end,
		})

		vim.on_key(function(key)
			if
				flash_char.state
				and key == require("flash.util").ESC
				and (vim.fn.mode() == "n" or vim.fn.mode() == "v")
			then
				flash_char.state:hide()
			end
		end)

		-- Flash mappings
		vim.keymap.set({ "n", "x", "o" }, "f", flash_jump({ key = "f", forward = true }))
		vim.keymap.set({ "n", "x", "o" }, "F", flash_jump({ key = "F", forward = false }))
		vim.keymap.set({ "n", "x", "o" }, "t", flash_jump({ key = "t", forward = true }))
		vim.keymap.set({ "n", "x", "o" }, "T", flash_jump({ key = "T", forward = false }))

		vim.keymap.set({ "n", "x", "o" }, "s", function()
			require("flash").jump()
		end)

		-- Treesitter textobjects mapppings
		local ts_move = require("nvim-treesitter.textobjects.move")
		vim.keymap.set({ "n", "x", "o" }, "]d", function()
			ts_move.goto_next_start("@function.outer")
		end)

		vim.keymap.set({ "n", "x", "o" }, "[d", function()
			ts_move.goto_previous_start("@function.outer")
		end)

		vim.keymap.set({ "n", "x", "o" }, "]f", function()
			ts_move.goto_next_start("@call.outer")
		end)

		vim.keymap.set({ "n", "x", "o" }, "[f", function()
			ts_move.goto_previous_start("@call.outer")
		end)

		vim.keymap.set({ "n", "x", "o" }, "]i", function()
			ts_move.goto_next_start("@conditional.outer")
		end)

		vim.keymap.set({ "n", "x", "o" }, "[i", function()
			ts_move.goto_previous_start("@conditional.outer")
		end)

		vim.keymap.set({ "n", "x", "o" }, "]l", function()
			ts_move.goto_next_start("@loop.outer")
		end)

		vim.keymap.set({ "n", "x", "o" }, "[l", function()
			ts_move.goto_previous_start("@loop.outer")
		end)
	end,
}
