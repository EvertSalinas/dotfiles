return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- optional, for icons
  config = function()
    require('lualine').setup({
      options = {
        theme = 'onedark' -- Or your favorite theme
      }
    })
  end
}
