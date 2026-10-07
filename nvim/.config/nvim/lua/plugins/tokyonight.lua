-- lua/plugins/tokyonight.lua
-- TokyoNight (night), matching the ghostty, tmux and starship themes.
return {
  "folke/tokyonight.nvim",
  lazy = false, -- Load this plugin immediately as it's a colorscheme
  priority = 1000, -- Give it high priority to load before other plugins
  config = function()
    require("tokyonight").setup({ style = "night" })
    vim.cmd.colorscheme("tokyonight")
    vim.cmd('hi LineNr ctermfg=250 ctermbg=234')
    vim.cmd('hi Normal guibg=NONE ctermbg=NONE')
  end,
}
