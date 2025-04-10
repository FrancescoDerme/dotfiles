--[[ Remap '^' to '&' to match the way keys are placed on an
--   american keyboard (it makes sense for '&' to be close to
--   '$' since they have complementary functions). '&' did something
--   too, probably something quite important and useful, but we're
--   gonna ignore it for now.
--]]
vim.keymap.set('n', '&', '^', {desc = "^"})

-- Deactivating arrow keys in both normal and insert modes
vim.keymap.set('n', '<Down>', '<Nop>', {desc = "Ignored"})
vim.keymap.set('i', '<Down>', '<Nop>', {desc = "Ignored"})
vim.keymap.set('n', '<Up>', '<Nop>', {desc = "Ignored"})
vim.keymap.set('i', '<Up>', '<Nop>', {desc = "Ignored"})
vim.keymap.set('n', '<Left>', '<Nop>', {desc = "Ignored"})
vim.keymap.set('i', '<Left>', '<Nop>', {desc = "Ignored"})
vim.keymap.set('n', '<Right>', '<Nop>', {desc = "Ignored"})
vim.keymap.set('i', '<Right>', '<Nop>', {desc = "Ignored"})

-- Keymaps to switch focus faster
vim.keymap.set('n', '<M-h>', '<C-w>h', {desc = "Switch focus left"})
vim.keymap.set('n', '<M-j>', '<C-w>j', {desc = "Switch focus down"})
vim.keymap.set('n', '<M-k>', '<C-w>k', {desc = "Switch focus up"})
vim.keymap.set('n', '<M-l>', '<C-w>l', {desc = "Switch focus right"})

-- Keymaps for tabs and splits
vim.keymap.set('n', '<leader>t', ':tabnew <CR>', {desc = "Open new tab"})
vim.keymap.set('n', '<leader>wv', ':vsplit <CR>', {desc = "Open vertical window"})
vim.keymap.set('n', '<leader>wh', ':split <CR>', {desc = "Open horizontal window"})

-- Neotree
vim.keymap.set('n', '<leader>e', ':Neotree filesystem toggle left <CR>', {desc = "Toggle file tree"})

-- Telescope
vim.keymap.set('n', '<leader>fd', ':Telescope live_grep <CR>', {desc = "Text in directory"})
vim.keymap.set('n', '<leader>fb', ':Telescope current_buffer_fuzzy_find <CR>', {desc = "Text in buffer"})
vim.keymap.set('n', '<leader>ff', ':Telescope find_files <CR>', {desc = "File in directory"})

-- Competitest
vim.keymap.set('n', '<leader>ca', ':CompetiTest add_testcase <CR>', {desc = "Add testcase"})
vim.keymap.set('n', '<leader>ce', ':CompetiTest edit_testcase <CR>', {desc = "Edit testcase"})
vim.keymap.set('n', '<leader>cr', ':CompetiTest run <CR>', {desc = "Run testcases"})
vim.keymap.set('n', '<leader>cs', ':CompetiTest show_ui <CR>', {desc = "Show ui"})
vim.keymap.set('n', '<leader>cdt', ':CompetiTest receive testcases <CR>', {desc = "Testcases"})
vim.keymap.set('n', '<leader>cdp', ':CompetiTest receive problem <CR>', {desc = "Problem"})
vim.keymap.set('n', '<leader>cdc', ':CompetiTest receive contest <CR>', {desc = "Contest"})

-- Oil
vim.keymap.set('n', '<leader>oe', ':Oil <CR>', {desc = "File explorer"})
vim.keymap.set('n', '<leader>of', ':Oil --float <CR>', {desc = "Floating file explorer"})
