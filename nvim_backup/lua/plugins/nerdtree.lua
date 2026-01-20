-- ~/.config/nvim/lua/plugins/nerdtree.lua
return {
  "preservim/nerdtree",
  config = function()
    vim.g.NERDTreeShowBookmarks = 1
    vim.g.NERDTreeShowHidden = 1
    vim.g.NERDTreeShowLineNumbers = 0
    vim.g.NERDTreeMinimalMenu = 1
    vim.g.NERDTreeWinPos = "left"
    vim.g.NERDTreeWinSize = 31
  end,
  keys = {
    { "<leader>n", "<cmd>NERDTreeToggle<CR>", desc = "Toggle NERDTree" },
  },
  -- You can add lazy-loading here if you only want it to load when you use the command
  cmd = "NERDTreeToggle",
}
