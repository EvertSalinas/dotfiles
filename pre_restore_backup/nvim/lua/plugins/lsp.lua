return {
    {
        'neovim/nvim-lspconfig',
        config = function()
            require('lspconfig').solargraph.setup{}
            require('lspconfig').pyright.setup{}
            require('lspconfig').html.setup{}
            require('lspconfig').cssls.setup{}
            require('lspconfig').jsonls.setup{}
        end,
    }
}
