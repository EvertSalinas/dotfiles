return {
  'lewis6991/gitsigns.nvim',
  opts = {
    on_attach = function(bufnr)
      local gs = require('gitsigns')
      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
      end

      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal({ ']c', bang = true })
        else
          gs.nav_hunk('next')
        end
      end, 'Next hunk')
      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal({ '[c', bang = true })
        else
          gs.nav_hunk('prev')
        end
      end, 'Previous hunk')
      map('n', '<leader>hs', gs.stage_hunk, 'Stage hunk')
      map('n', '<leader>hr', gs.reset_hunk, 'Reset hunk')
      map('n', '<leader>hS', gs.stage_buffer, 'Stage buffer')
      map('n', '<leader>hR', gs.reset_buffer, 'Reset buffer')
      map('n', '<leader>hp', gs.preview_hunk, 'Preview hunk')
      map('n', '<leader>hb', function()
        gs.blame_line({ full = true })
      end, 'Blame line')
      map('n', '<leader>hd', gs.diffthis, 'Diff this')
    end,
  },
}
