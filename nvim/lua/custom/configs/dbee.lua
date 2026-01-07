-- dofile(vim.fn.stdpath 'config' .. '/init.lua')
dofile '/home/brew/.config/nvim/init.lua'

-- Then override or extend settings here:
vim.o.number = true
vim.cmd.colorscheme 'kanagawa-wave'
vim.keymap.set('n', '<C-t>', function() vim.api.nvim_set_current_win(1003) end)
vim.keymap.set('n', '<C-e>', function() vim.api.nvim_set_current_win(1000) end)
vim.keymap.set('n', '<C-s>', function() vim.api.nvim_set_current_win(1002) end)
for i = 1, 10 do
  local key = (i == 10) and '0' or tostring(i)
  vim.keymap.set('n', '<A-' .. key .. '>', function()
    local harpoon = require 'harpoon'
    local dbee = require 'dbee'

    local list = harpoon:list()
    local item = list:get(i)
    if not item then
      vim.notify('No Harpoon item in slot ' .. i)
      return
    end

    local path = vim.fn.expand(item.value)
    local note = dbee.api.ui.editor_search_note_with_file(path)
    if note and note.id then
      dbee.api.ui.editor_set_current_note(note.id)
    else
      vim.notify('Note not found for ' .. path)
      -- vim.notify('Note not found for ~/' .. path .. note.id)
    end
  end, { desc = 'Open Harpoon file ' .. i .. ' in DBEE editor' })
end
