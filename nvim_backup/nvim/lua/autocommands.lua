-- ~/.config/nvim/lua/autocommands.lua

-- Define autocmd groups for better organization and management
-- It's common to define a main group for your general autocommands
-- and then specific groups for logical categories.

-- Clear previous autocommand groups on reload to prevent duplicates
-- This is a common pattern for configuration files that might be sourced multiple times.
-- Note: You typically clear the group by its ID.
-- We'll create the groups and capture their IDs.

local autocmd_groups = {}

-- Function to create or get an augroup ID
local function create_augroup(name, clear)
  -- Clear the group if it already exists and `clear` is true
  if clear == nil then clear = true end -- Default to clear

  local id = vim.api.nvim_create_augroup(name, { clear = clear })
  autocmd_groups[name] = id
  return id
end

-- Create a general group for your custom autocommands
local custom_augroup = create_augroup("CustomAutocmds")

-- Create specific groups for the original Vimscript ones
local vim_resize_group = create_augroup("VimResize")
local nerdtree_group = create_augroup("NERDTreeAutocmds") -- Renamed to avoid potential conflict with plugin
local trim_white_group = create_augroup("TrimWhite")

--- 1. Ruby Filetype Detection
-- Original: au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Procfile,Guardfile,config.ru,*.rake} set ft=ruby
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  group = custom_augroup, -- Assign to your custom group
  pattern = {"Gemfile", "Rakefile", "Vagrantfile", "Thorfile", "Procfile", "Guardfile", "config.ru", "*.rake"},
  callback = function()
    vim.opt.filetype = "ruby" -- Set filetype using Lua option API
  end,
  desc = "Set filetype for various Ruby files",
})

--- 2. VimResize Autogroup
-- Original: autocmd VimResized * :wincmd =
vim.api.nvim_create_autocmd("VimResized", {
  group = vim_resize_group,
  pattern = "*", -- Applies to all windows
  callback = function()
    vim.cmd("wincmd =") -- Execute Vim command
  end,
  desc = "Equalize window sizes on VimResize",
})

--- 3. NERDTree Autogroup
-- Original:
-- autocmd StdinReadPre * let s:std_in=1
-- autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

-- This logic needs to be combined carefully.
-- We can set a global flag in Lua.
local has_stdin_input = false

vim.api.nvim_create_autocmd("StdinReadPre", {
  group = nerdtree_group,
  pattern = "*",
  callback = function()
    has_stdin_input = true -- Set Lua variable directly
  end,
  desc = "Detect if Neovim is reading from stdin",
})

vim.api.nvim_create_autocmd("VimEnter", {
  group = nerdtree_group,
  pattern = "*",
  callback = function()
    -- Check if no arguments were provided and no stdin input detected
    if vim.fn.argc() == 0 and not has_stdin_input then
      -- It's better to use `vim.cmd.NERDTree()` if it's available, or just `vim.cmd('NERDTree')`
      -- This ensures NERDTree is loaded before the command is called.
      -- If NERDTree is lazy-loaded, you might need to ensure its command is available.
      -- Lazy.nvim usually handles `cmd` for you.
      vim.cmd("NERDTree")
    end
  end,
  desc = "Open NERDTree on empty startup",
})

--- 4. TrimWhite
