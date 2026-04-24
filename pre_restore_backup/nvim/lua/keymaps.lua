-- ~/.config/nvim/lua/keymaps.lua

-- Define a local variable for convenience, commonly 'map'
local map = vim.keymap.set

-- Helper function to create a description for common mappings
local function create_desc(desc)
  return { desc = desc, noremap = true, silent = true }
end

-- If a real file is opened, find it in NERDTree; otherwise toggle the tree
map('n', '<Leader>n', function()
  local current_path = vim.api.nvim_buf_get_name(0)
  if current_path ~= '' and vim.fn.filereadable(current_path) == 1 then
    vim.cmd('NERDTreeFind')
  else
    vim.cmd('NERDTreeToggle')
  end
end, create_desc("NERDTree: Find file or Toggle"))


-- Telescope Mappings
-- Original: nnoremap <leader>p <cmd>Telescope find_files<cr>
-- Note: These are already in your `lua/plugins/telescope.lua` file.
-- You should remove them from here and keep them there for better organization.
-- If you choose to keep them here, ensure Telescope is loaded before these keymaps are active.
-- Example of how they would look if *not* in the plugin file:
-- map('n', '<leader>p', '<cmd>Telescope find_files<cr>', create_desc("Find files"))
-- map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', create_desc("Live Grep"))
-- map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', create_desc("List buffers"))
-- map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', create_desc("Search help tags"))


-- Vim-Test Mappings
-- Original: nmap <silent> <Leader>s :TestNearest<CR>
-- These are also ideally placed in `lua/plugins/vim-test.lua`.
map('n', '<Leader>s', '<cmd>TestNearest<CR>', { silent = true, desc = "Run nearest test" })
map('n', '<Leader>t', '<cmd>TestFile<CR>', { silent = true, desc = "Run tests in file" })
map('n', '<Leader>a', '<cmd>TestSuite<CR>', { silent = true, desc = "Run test suite" })
map('n', '<Leader>l', '<cmd>TestLast<CR>', { silent = true, desc = "Run last test" })
map('n', '<Leader>g', '<cmd>TestVisit<CR>', { silent = true, desc = "Visit last test" })

-- Tab Completion (Insert mode)
-- Original: inoremap <Tab> <C-r>=InsertTabWrapper()<CR>
-- This requires the `InsertTabWrapper` function to be translated to Lua.
-- Since it's a small function, we can define it directly here or in a helper module.
-- Let's translate the InsertTabWrapper function first:
function InsertTabWrapper()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.')[col - 1]:match('%A') then
    return '<Tab>'
  else
    return '<C-p>'
  end
end
-- Or a more direct check for keyword character
-- if col == 0 or not vim.fn.match(vim.fn.getline('.')[col - 1], '\\k') then


-- Set the insert mode mapping for Tab
-- map('i', '<Tab>', '<C-r>=v:lua.InsertTabWrapper()<CR>', create_desc("Smart Tab (indent/completion)"))

-- The `v:lua.InsertTabWrapper()` syntax tells Vim/Neovim to execute the Lua function `InsertTabWrapper`.

-- Original: inoremap <S-Tab> <C-n>
map('i', '<S-Tab>', '<C-n>', create_desc("Completion (next match)"))

-- Silver Searcher (Ag command and keymap)
-- Original: nnoremap \ :Ag<SPACE> (Conditional)
-- This command (`Ag`) needs to be defined first if you're keeping it custom.
-- This part is best handled in the fzf.lua plugin config or a dedicated commands.lua file,
-- especially since it's conditional on `ag` existing.
-- If you moved the `command Ag` definition to Lua, then its keymap would look like:
if vim.fn.executable('ag') == 1 then
  vim.keymap.set('n', '\\', ':Ag ', { noremap = true, silent = false, desc = 'Ag search' })
end
