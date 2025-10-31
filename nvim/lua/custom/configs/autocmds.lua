vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    local cs = vim.g.colors_name or 'unknown'
    if not cs:find 'eldritch' then
      return
    end
    local new_bg = vim.api.nvim_get_hl(0, { name = 'Normal' }).bg
    vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'none' })
    -- vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'pink' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = new_bg })
    vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '#a6adc8' })
  end,
})
