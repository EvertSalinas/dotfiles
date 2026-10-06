local function lsp_clients()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then
    return ''
  end
  local names = {}
  for _, client in ipairs(clients) do
    table.insert(names, client.name)
  end
  return ' ' .. table.concat(names, ', ')
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    { 'catppuccin/nvim', name = 'catppuccin' }, -- palette only; colorscheme stays onedark
  },
  config = function()
    require('catppuccin').setup({ flavour = 'mocha' })
    require('lualine').setup({
      options = {
        theme = require('catppuccin.utils.lualine')('mocha'),
        section_separators = { left = '', right = '' },
        component_separators = '',
        globalstatus = true,
      },
      sections = {
        lualine_a = { { 'mode', icon = '' } },
        lualine_b = {
          { 'branch', icon = '' },
          {
            'diff',
            symbols = { added = ' ', modified = ' ', removed = ' ' },
          },
        },
        lualine_c = {
          {
            'filename',
            path = 1, -- relative path
            symbols = { modified = ' ●', readonly = ' ', unnamed = '[No Name]' },
          },
          {
            'diagnostics',
            symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
          },
        },
        lualine_x = { lsp_clients, 'filetype' },
        lualine_y = { 'searchcount', 'progress' },
        lualine_z = { { 'location', icon = '' } },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { 'nvim-tree', 'fugitive', 'fzf', 'quickfix' },
    })
  end,
}
