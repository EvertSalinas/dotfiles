-- ~/.config/nvim/lua/plugins/treesitter.lua
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate", -- Run this command after install/update
  config = function()
    require('nvim-treesitter.configs').setup({
      -- Add your specific Treesitter configurations here:
      -- ensure_installed = { "c", "lua", "vim", "vimdoc", "javascript", "html", "css", "json", "ruby", "rust" }, -- etc.
      highlight = {
        enable = true, -- Enable syntax highlighting
        -- disable = { "c", "ruby" },  -- Disable for specific filetypes
      },
      indent = { enable = true }, -- Enable indentation
      -- Add other modules like incremental_selection, textobjects, etc. if you use them
    })
  end,
}
