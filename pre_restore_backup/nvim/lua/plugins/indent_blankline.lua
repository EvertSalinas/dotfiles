return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    indent = {
      char = "│",
      tab_char = "│",
    },
    scope = {
      enabled = true,
      show_start = false,
      show_end = false,
    },
    exclude = {
      filetypes = {
        "help",
        "lazy",
        "mason",
        "NvimTree",
        "nerdtree",
        "TelescopePrompt",
        "gitcommit",
        "alpha",
        "dashboard",
      },
    },
  },
  keys = {
    { "<leader>ti", "<cmd>IBLToggle<cr>", desc = "Toggle indent guides" },
  },
}
