return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup {
        settings = {
          save_on_toggle = true,
          sync_on_ui_close = true,
        },
      }

      -- vim.keymap.set(
      --   'n',
      --   '<C-h>',
      --   function() harpoon.ui:toggle_quick_menu(harpoon:list(), { ui_width_ratio = 0.6, ui_height_ratio = 0.5, border = 'rounded', title_pos = 'center' }) end
      -- )

      for i = 1, 10 do
        local key = (i == 10) and '0' or tostring(i)
        vim.keymap.set('n', '<leader>a' .. key, function() harpoon:list():replace_at(i) end, { desc = 'Harpoon: assign slot ' .. i })
      end

      for i = 1, 10 do
        local key = (i == 10) and '0' or tostring(i)
        vim.keymap.set('n', '<A-' .. key .. '>', function() harpoon:list():select(i) end, { desc = 'Harpoon: jump to slot ' .. i })
      end
    end,
  },
}
