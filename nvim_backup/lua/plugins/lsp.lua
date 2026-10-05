local servers = { 'ruby_lsp', 'pyright', 'html', 'cssls', 'jsonls' }

return {
  {
    'mason-org/mason.nvim',
    lazy = false,
    config = function()
      require('mason').setup()
    end,
  },
  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
      'mason-org/mason.nvim',
      'neovim/nvim-lspconfig',
    },
    opts = {
      ensure_installed = servers,
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'mason-org/mason.nvim', 'saghen/blink.cmp' },
    config = function()
      vim.lsp.enable(servers)
    end,
  },
}
