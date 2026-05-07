local M = {}

-- Competitest
-- Target line to open the competitive programming template at
M.target_line = 23

-- Number of lines of header in the template
M.header_lines = 3

-- Path of the competitive programming tamplate
M.template_file = vim.fn.expand("~/cp/template.cpp")

-- Path of a temporary file to start contests at
M.temp_file = vim.fn.stdpath("cache") .. "/cp_temp.cpp"

return M
