if os.getenv 'USER' == 'root' then
  vim.cmd.colorscheme 'gruvbox'
else
  vim.cmd.colorscheme 'eldritch'
end

vim.o.tabstop = 4
vim.o.expandtab = false
vim.o.tabstop = 8
vim.o.shiftwidth = 0
vim.o.pumheight = 10
vim.o.pumblend = 25
vim.o.scrolloff = 35
vim.diagnostic.config {
  virtual_text = true,
}
-- vim.keymap.set('n', '<C-e>', '<cmd>:Explore<CR>', { desc = 'Explore' })
-- vim.keymap.set('n', '<C-e>', '<cmd>:Oil --float<CR>', { desc = 'Explore' })
-- vim.keymap.set('n', '<C-e>', '<cmd>:Oil --toggle_float<CR>', { desc = 'Explore' })
vim.keymap.set('n', '<C-e>', function()
  require('oil').toggle_float()
end)
-- map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
-- vim.keymap.set('n', 'h', '<Up>', { noremap = true, silent = true }) -- Normal mode up arrow
-- vim.keymap.set('n', 'k', '<Down>', { noremap = true, silent = true }) -- Normal mode down arrow
-- vim.keymap.set('n', 'j', '<Left>', { noremap = true, silent = true }) -- Normal mode left arrow
-- vim.keymap.set('n', 'l', '<Right>', { noremap = true, silent = true }) -- Normal mode right arrow
vim.keymap.set('n', '<Esc>', function()
  if vim.bo.filetype == 'oil' then
    require('oil').close()
  else
    vim.cmd.nohlsearch()
  end
end, { noremap = true, desc = 'Close Oil buffer if active' })
-- vim.keymap.set({ 'n', 'v' }, '<C-,>', function()
--   require('mini').comment_line()
-- end, { noremap = true, silent = true })
-- Remap 'gc' to toggle comments in normal and visual mode
-- vim.keymap.set({ 'n', 'v' }, ',,', '<Plug>(Comment.toggle.linewise)', { desc = 'Toggle comment' })
-- vim.keymap.set('n', '<C>,', '<cmd>nohlsearch<CR>')
-- vim.keymap.set('n', '<C-,>', '<Plug>(Comment.toggle.linewise)', { desc = 'Toggle comment' })
--
vim.keymap.set({ 'n' }, '<C-,>', 'gcc', { remap = true, desc = 'Toggle comment' })
--
-- vim.keymap.set('n', '<C-,>', function()
--   vim.cmd.norm 'gcc'
-- end)
require('telescope').setup {
  defaults = {
    file_ignore_patterns = {
      'node_modules',
      '%.env',
      '%.log',
      '__pycache__',
      '%.xlsx',
      '%.jpg',
      '%.png',
      '%.webp',
      '%.pdf',
      '%.odt',
      '%.ico',
    },
  },
}

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

vim.keymap.set('n', '<A-e>', function()
  toggle_menu_fixed_height(10)
end)
