-- ~/.config/nvim/lua/plugins/treesitter.lua
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  config = function()
    require('nvim-treesitter').setup({
      ensure_installed = { "c", "lua", "vim", "vimdoc", "javascript", "html", "css", "json", "ruby" },
    })
    vim.treesitter.language.register("ruby", "ruby")
  end,
}
