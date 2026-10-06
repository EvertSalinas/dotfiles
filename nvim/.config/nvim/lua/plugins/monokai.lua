-- lua/plugins/monokai.lua
-- Monokai Remastered palette, matching the ghostty, tmux and starship themes.
return {
  "tanvirtin/monokai.nvim",
  lazy = false, -- Load this plugin immediately as it's a colorscheme
  priority = 1000, -- Give it high priority to load before other plugins
  config = function()
    require("monokai").setup({
      palette = {
        name = "monokai_remastered",
        base0 = "#0c0c0c",
        base1 = "#121212",
        base2 = "#1a1a1a",
        base3 = "#262626",
        base4 = "#343434",
        base5 = "#4d4d4d",
        base6 = "#75715e",
        base7 = "#c4c5b5",
        base8 = "#d9d9d9",
        border = "#625e4c",
        brown = "#504945",
        white = "#f6f6ef",
        grey = "#75715e",
        black = "#000000",
        pink = "#f4005f",
        green = "#98e024",
        aqua = "#58d1eb",
        yellow = "#e0d561",
        orange = "#fd971f",
        purple = "#9d65ff",
        red = "#f4005f",
        diff_add = "#3d5213",
        diff_remove = "#4a0f23",
        diff_change = "#27406b",
        diff_text = "#23324d",
      },
    })
    vim.cmd('hi LineNr ctermfg=250 ctermbg=234')
    vim.cmd('hi Normal guibg=NONE ctermbg=NONE')
  end,
}
