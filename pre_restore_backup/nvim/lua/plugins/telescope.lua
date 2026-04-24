-- lua/plugins/telescope.lua
return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.5", -- Specify the exact tag as in your Vim-Plug config
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require('telescope').setup({
      -- Your Telescope configurations here
      defaults = {
        -- Example: disable preview in some pickers
        -- previewer = false,
      },
    })
  end,
  -- You'll move Telescope keymaps here later
  keys = {
    { "<leader>p", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
  --   { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
  --   -- ... etc.
  },
}
