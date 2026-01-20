-- ~/.config/nvim/init.lua

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require('plugins')
require("config.lazy")
require('options')
require('keymaps')
require('autocommands')
require('mini.surround').setup()

-- 1. Setting runtimepath (if necessary, often managed by plugin managers now)
-- The equivalent of set runtimepath^=~/.vim runtimepath+=~/.vim/after
-- This is often less necessary with modern plugin managers like Lazy.nvim,
-- as they handle adding plugin paths to runtimepath.
-- If you still have custom Vim files in ~/.vim that are *not* plugins
-- managed by a plugin manager, you might need this.
-- Otherwise, you can often omit these lines.
local home = os.getenv("HOME")
vim.opt.rtp:prepend(home .. "/.vim")
vim.opt.rtp:append(home .. "/.vim/after")

-- 2. Setting packpath (often managed by plugin managers)
-- The equivalent of let &packpath = &runtimepath
-- Similar to runtimepath, modern plugin managers generally handle packpath
-- setup for you. You likely don't need this line if using a plugin manager.
-- vim.opt.packpath = vim.opt.rtp

-- 3. Sourcing ~/.vimrc (if you still need it)
-- The equivalent of source ~/.vimrc
-- This is crucial if you have settings or plugins defined *only* in your
-- ~/.vimrc that haven't been migrated to Lua yet.
-- To execute a Vimscript file from Lua:
-- vim.cmd("source ~/.vimrc")
