-- lua/plugins/colorscheme.lua
return {
  "joshdick/onedark.vim",
  lazy = false, -- Load this plugin immediately as it's a colorscheme
  priority = 1000, -- Give it high priority to load before other plugins
  config = function()
    vim.cmd.colorscheme("onedark")
    -- Optional: Highlight overrides (you had these in your init.vim)
    vim.cmd('hi LineNr ctermfg=250 ctermbg=234')
    vim.cmd('hi Normal guibg=NONE ctermbg=NONE')
    -- Optional: enable italic comments if the theme supports it
    -- vim.cmd('hi Comment cterm=italic gui=italic')
  end,
}
