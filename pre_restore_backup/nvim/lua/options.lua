-- ~/.config/nvim/lua/options.lua

-- General Neovim Options (vim.opt)
-- Access options using vim.opt, or vim.o (for local buffer/window options).
-- Boolean options are set to true/false. String options are strings. Number options are numbers.

-- Indentation
vim.opt.tabstop = 8
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true -- Converts tabs to spaces

-- Search
vim.opt.incsearch = true  -- Enable incremental search
vim.opt.hlsearch = true   -- Enable highlight search

-- Window Management
vim.opt.splitbelow = true -- Always split below
vim.opt.mouse = 'a'       -- Enable mouse in all modes

-- Line Numbers
vim.opt.number = true         -- Show absolute line numbers
vim.opt.relativenumber = true -- Show relative line numbers

-- Swap Files and Directories
vim.opt.swapfile = true   -- Create swap files
vim.opt.dir = '/tmp'      -- Write swap files to /tmp

-- Encoding
vim.opt.encoding = 'UTF-8'

-- Text Wrapping/Formatting
vim.opt.textwidth = 100   -- Set text width for wrapping

-- Cursor Line
vim.opt.cursorline = true -- Highlight the current line

-- Completion vim.opt.wildmode = 'list:longest,list:full' -- Command-line completion behavior

-- Colorscheme related (these are commands, often handled by plugin config)
vim.cmd('syntax on')       -- Enable syntax highlighting
vim.opt.termguicolors = true -- Enable true colors (24-bit) if your terminal supports it
-- vim.opt.t_Co = 256         -- Set terminal colors to 256 (redundant if termguicolors is true, but harmless)
vim.cmd('colorscheme onedark') -- Set the colorscheme

-- Highlight definitions (these are commands, often put in a dedicated theme file or after colorscheme)
vim.cmd('hi LineNr ctermfg=250 ctermbg=234')
vim.cmd('hi Normal guibg=NONE ctermbg=NONE')

-- GUI Font (only applies to Neovim-Qt, Neovide, etc., not terminal Neovim)
vim.opt.guifont = 'Monaco'

-- Plugin-specific global/buffer variables (vim.g and vim.b)
-- Note: It's often better to put plugin-specific configurations
-- directly within their Lazy.nvim `config` function.
-- However, if they are truly global variables that the plugin expects to be set *before* its config,
-- or if they are simple values, setting them here is fine.

-- ALE (As a general rule, ALE is configured via its setup function in Lua,
-- but these 'g:' variables can still be set.)
vim.g.ale_fix_on_save = 1
vim.g.ale_sign_error = '>>'
-- For b:ale_fixers, this should ideally be set in ALE's config function,
-- which might look like `require('ale').set_fixers('ruby', {'standardrb'})` etc.
-- If you want to replicate the 'b:' behavior, you'd need to set it per-buffer,
-- typically using an autocommand or during a filetype setup.
-- For now, we'll omit the `b:ale_fixers` here as it's better handled
-- in a plugin's `config` function or a filetype autocommand.

-- FZF (The FZF_DEFAULT_COMMAND is an environment variable)
-- The `executable('ag')` check and `command` definition will be handled separately.
if vim.fn.executable('ag') == 1 then -- `executable()` returns 1 for true, 0 for false
  vim.opt.grepprg = 'ag --nogroup --nocolor'
  -- Setting environment variables in Lua
  -- This will set it for the current Neovim process and any child processes it spawns.
  vim.env.FZF_DEFAULT_COMMAND = 'ag --literal --files-with-matches --nocolor --hidden -g ""'
end

-- NERDTree (these will be set in NERDTree's config function in lua/plugins/nerdtree.lua)
-- For demonstration, if you were to put them here:
vim.g.NERDTreeShowBookmarks = 1
vim.g.NERDTreeShowHidden = 1
vim.g.NERDTreeShowLineNumbers = 0
vim.g.NERDTreeMinimalMenu = 1
vim.g.NERDTreeWinPos = "left"
vim.g.NERDTreeWinSize = 31

-- Removed legacy vim-rspec command to avoid overriding vim-test behavior
vim.g.rspec_command = nil

-- Syncing clipboard with system clipboard
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)
