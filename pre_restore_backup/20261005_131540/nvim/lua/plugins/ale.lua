-- lua/plugins/ale.lua
return {
  "dense-analysis/ale",
  config = function()
    vim.g.ale_fix_on_save = 1
    vim.g.ale_sign_error = '>>'
    -- For b:ale_fixers, this should be done with ALE's API, e.g.:
    -- require('ale').set_fixers('ruby', {'standardrb'})
    -- require('ale').set_fixers('rust', {'rustfmt'})
    -- require('ale').set_fixers('*', {'remove_trailing_lines', 'trim_whitespace'})
    -- Or, if ALE expects a global variable for defaults:
    -- vim.g.ale_fixers = {
    --   ruby = {'standardrb'},
    --   rust = {'rustfmt'},
    --   ['*'] = {'remove_trailing_lines', 'trim_whitespace'}
    -- }
  end,
}
