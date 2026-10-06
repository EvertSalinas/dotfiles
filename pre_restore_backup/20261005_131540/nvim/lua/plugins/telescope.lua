-- lua/plugins/telescope.lua
return {
  "nvim-telescope/telescope.nvim",
  branch = "master",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require('telescope').setup({
      -- Your Telescope configurations here
      defaults = {
        preview = {
          treesitter = false,
        },
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
