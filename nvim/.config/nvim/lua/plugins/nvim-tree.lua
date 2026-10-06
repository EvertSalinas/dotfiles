-- ~/.config/nvim/lua/plugins/nvim-tree.lua
return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false, -- load at startup so it can hijack netrw before netrw opens
  config = function()
    require("nvim-tree").setup({
      view = {
        side = "left",
        width = 31,
      },
      renderer = {
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
        },
      },
      filters = {
        dotfiles = false,
      },
    })
  end,
  -- <Leader>n is bound in lua/keymaps.lua (find current file in tree, or toggle)
}
