-- lua/plugins/vim-test.lua
return {
  "vim-test/vim-test",
  dependencies = { "tpope/vim-dispatch" }, -- vim-test needs dispatch
  config = function()
    vim.g.test_strategy = 'terminal'
    vim.g['test#terminal_position'] = 'belowright'
  end,
  -- You'll move keymaps for this here later
  -- keys = {
  --   { 'n', "<leader>t", "<cmd>TestFile<CR>", desc = "Test File" }
  --   -- ... other test keymaps
  -- },
}

