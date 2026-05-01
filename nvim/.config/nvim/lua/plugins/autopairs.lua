return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = function()
		local npairs = require("nvim-autopairs")

		-- Modify the deletion behavior for these specific rules
		local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" } }

		for _, bracket in ipairs(brackets) do
			local open = bracket[1]
			local close = bracket[2]

			-- Get the default rules that nvim-autopairs already created for this bracket
			local rules = npairs.get_rules(open)

			for _, rule in ipairs(rules) do
				-- Modify the deletion condition
				rule:with_del(function(opts)
					local line = opts.line
					local open_count = 0
					local close_count = 0

					-- Count how many opening and closing brackets are on the current line
					for i = 1, #line do
						local c = line:sub(i, i)
						if c == open then
							open_count = open_count + 1
						end
						if c == close then
							close_count = close_count + 1
						end
					end

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
