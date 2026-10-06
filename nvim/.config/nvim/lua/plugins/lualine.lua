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

-- Monokai Remastered, matching the colorscheme in plugins/monokai.lua
local monokai_remastered = (function()
  local c = {
    bg = '#0c0c0c', bg_alt = '#262626', fg = '#d9d9d9', grey = '#625e4c',
    green = '#98e024', cyan = '#58d1eb', purple = '#9d65ff', orange = '#fd971f', pink = '#f4005f',
  }
  local function mode(accent)
    return {
      a = { fg = c.bg, bg = accent, gui = 'bold' },
      b = { fg = c.fg, bg = c.bg_alt },
      c = { fg = c.fg, bg = c.bg },
    }
  end
  return {
    normal = mode(c.green),
    insert = mode(c.cyan),
    visual = mode(c.purple),
    replace = mode(c.pink),
    command = mode(c.orange),
    inactive = {
      a = { fg = c.grey, bg = c.bg },
      b = { fg = c.grey, bg = c.bg },
      c = { fg = c.grey, bg = c.bg },
    },
  }
end)()

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup({
      options = {
        theme = monokai_remastered,
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
