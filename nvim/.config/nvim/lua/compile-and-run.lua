-- Map Ctrl+B to the open/close input and output panels fucntion
vim.keymap.set('n', '<C-B>', ':lua Input_output()<CR>', {})

-- Map Ctrl+N to the compile and run function
vim.keymap.set('n', '<C-N>', ':lua Compile_and_run_cpp()<CR>', {})

-- Function to open/close input and output panels
function Input_output()
  local output_file = "output.txt" -- Change this to the desired output file name
  local input_file = "input.txt" -- Change this to the desired input file name

  -- Check if input file exists, create if it doesn't
  local input_fd = io.open(input_file, "a+") -- Open in append mode to create if it doesn't exist
  if input_fd == nil then
    vim.api.nvim_err_writeln("Failed to open or create input file: " .. input_file)
    return
  end
  input_fd:close()

  -- Check if output file exists, create if it doesn't
  local output_fd = io.open(output_file, "a+") -- Open in append mode to create if it doesn't exist
  if output_fd == nil then
    vim.api.nvim_err_writeln("Failed to open or create output file: " .. output_file)
    return
  end
  output_fd:close()

  -- Check if input file buffer is already open, close it if it is, open it if it isn't
  local input_bufnr = vim.fn.bufnr(input_file)
  if input_bufnr == -1 then
    -- Open input file in a new split at top right side
    vim.cmd("vsp " .. input_file)
  else
    
    -- Switch to existing buffer for input file
    vim.cmd(input_bufnr .. "wincmd w")
  end

  -- Check if output file buffer is already open, close it if it is, open it if it isn't
  local output_butnr = vim.fn.bufnr(output_file)
  if output_butnr == -1 then
    -- Open output file in a new split at top right side
    vim.cmd("split " .. output_file)
  else
    -- Switch to existing buffer for output file
    vim.cmd(output_bufnr .. "wincmd w")
  end

  vim.cmd("vertical resize 70%")
end


-- Function to compile and run the current C++ file
function Compile_and_run_cpp()
  local output_file = "output.txt" -- Change this to the desired output file name
  local input_file = "input.txt" -- Change this to the desired input file name
  local filename = vim.fn.expand("%:p")
  local basename = vim.fn.expand("%:r")

  -- Check if current file is a valid C++ or C file
  local valid_extensions = { "cpp", "c" }
  local valid_file = false
  for _, ext in ipairs(valid_extensions) do
    if filename:match("%." .. ext .. "$") then
      valid_file = true
      break
    end
  end

  -- Exit function if file is not valid
  if not valid_file then
    vim.api.nvim_err_writeln("Not a valid C++ or C file.")
    return
  end

  -- Check if input file exists
  local input_fd = io.open(input_file, "r") 
  if input_fd == nil then
    vim.api.nvim_err_writeln("Failed to open input file: " .. input_file)
    return
  end
  input_fd:close()

  -- Check if output file exists
  local output_fd = io.open(output_file, "r")
  if output_fd == nil then
    vim.api.nvim_err_writeln("Failed to open output file: " .. output_file)
    return
  end
  output_fd:close()

  local file = vim.fn.bufnr(filename)
  vim.cmd(file .. "wincmd w")

  local compile_cmd =
    string.format("g++ %s -o %s && ./%s < %s > %s", filename, basename, basename, input_file, output_file)
  vim.cmd("silent w") -- Save the current file
  vim.cmd("silent !clear") -- Clear the terminal
  vim.cmd("silent !" .. compile_cmd) -- Execute the compile and run command

  -- Open the output file in a new buffer
  -- vim.cmd("edit " .. output_file)
end
