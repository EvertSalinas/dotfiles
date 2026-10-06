return {
    {
        'neovim/nvim-lspconfig',
        config = function()
            vim.lsp.enable({ 'ruby_lsp', 'pyright', 'html', 'cssls', 'jsonls' })
            vim.lsp.enable('solargraph', false)
        end,
    }
}
