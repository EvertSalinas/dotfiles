local servers = { 'ruby_lsp', 'pyright', 'html', 'cssls', 'jsonls' }
-- ruby_lsp is installed as a gem per asdf Ruby version (like solargraph) and run
-- straight from the asdf shim, so it always matches each project's .tool-versions.
-- Mason only manages the rest; its bin dir is prepended to $PATH, which would
-- otherwise shadow the asdf shim for a bare `ruby-lsp` command.
local mason_servers = { 'pyright', 'html', 'cssls', 'jsonls' }

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
      ensure_installed = mason_servers,
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'mason-org/mason.nvim', 'saghen/blink.cmp' },
    config = function()
      vim.lsp.config('ruby_lsp', {
        cmd = function(dispatchers, config)
          return vim.lsp.rpc.start(
            { vim.fn.expand('~/.asdf/shims/ruby-lsp') },
            dispatchers,
            config and config.root_dir and { cwd = config.cmd_cwd or config.root_dir }
          )
        end,
      })
      vim.lsp.enable(servers)
    end,
  },
}
