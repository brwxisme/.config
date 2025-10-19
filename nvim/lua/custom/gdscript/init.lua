vim.api.nvim_create_autocmd('FileType', {
  pattern = 'gdscript',
  callback = function()
    -- use spaces, etc.
    -- vim.opt_local.expandtab = true
    -- vim.opt_local.shiftwidth = 4
    -- vim.opt_local.tabstop = 4
    vim.keymap.set('i', '<CR>', function()
      local line = vim.api.nvim_get_current_line()

      -- Trim leading spaces for detection
      local trimmed = line:match '^%s*(.-)%s*$'

      -- Match "if" at start, followed by anything, ending with ':'
      if trimmed:match '^if%s+.-:$' or trimmed:match '^(func%s+.-:)$' then
        return '<CR>\t'
      else
        return '<CR>'
      end
    end, { buffer = true, expr = true })
  end,
})
