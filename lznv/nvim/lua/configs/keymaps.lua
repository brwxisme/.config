vim.keymap.set('i', 'jj', '<Esc>', { noremap = false })

vim.keymap.set('n', '<C-e>', function() require('oil').toggle_float() end)
vim.keymap.set('n', '<Esc>', function()
  if vim.bo.filetype == 'oil' then
    require('oil').close()
  else
    vim.cmd.nohlsearch()
  end
end, { noremap = true, desc = 'Close Oil buffer if active' })

vim.keymap.set({ 'n' }, '<C-,>', 'gcc', { remap = true, desc = 'Toggle comment' })

local h = require 'harpoon'
local function toggle_menu_fixed_height(height)
  local list = h:list()
  h.ui:toggle_quick_menu(list, {
    ui_width_ratio = 0.6,
    border = 'rounded',
    title_pos = 'center',
  })
  -- force resize shortly after it appears
  vim.defer_fn(function()
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_height(win, height)
  end, 10)
end
vim.keymap.set('n', '<A-e>', function() toggle_menu_fixed_height(10) end)

vim.keymap.set('n', '<leader>e', function() vim.diagnostic.open_float(nil, { scope = 'cursor' }) end, { desc = 'Open diagnostic float at cursor' })
vim.keymap.set('n', '<leader>u', function() require('noice').cmd 'dismiss' end)
