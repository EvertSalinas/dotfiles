-- lua/plugins/fzf.lua
return {
  "junegunn/fzf",
  build = function()
    vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/junegunn/fzf.git", vim.fn.stdpath("data") .. "/fzf" })
    vim.cmd [[! (cd "$DOT_LOCAL_DATA/fzf" && ./install --all) ]] -- Assuming standard fzf install path
  end,
  -- This build command is the equivalent of the `do` hook.
  -- Lazy.nvim will handle installing fzf via this `build` function.
  -- Make sure `~/.local/share/nvim/site/pack/lazy/start/fzf` is a good place.
  -- Alternatively, if fzf is already installed globally, you might not need this.
  -- For `fzf.vim`:
  { "junegunn/fzf.vim",
    -- Your fzf related options (e.g., FZF_DEFAULT_COMMAND) can be set here:
    config = function()
      if vim.fn.executable('ag') == 1 then
        vim.opt.grepprg = 'ag --nogroup --nocolor'
        vim.env.FZF_DEFAULT_COMMAND = 'ag --literal --files-with-matches --nocolor --hidden -g ""'
      end
      -- The `command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!`
      -- and `nnoremap \ :Ag<SPACE>` will be handled in keymaps/autocommands or by the fzf.vim plugin itself
      -- as the plugin defines `:Files`, `:Grep`, etc.
    end,
    dependencies = { "junegunn/fzf" }
  },
}
