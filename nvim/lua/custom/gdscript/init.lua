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
      -- if trimmed:match '^if%s+.-:$' or trimmed:match '^(func%s+.-:)$' then
      if trimmed:match '^if%s+.-:$' then
        return '<CR>\t'
      else
        return '<CR>'
      end
    end, { buffer = true, expr = true })
  end,
})

-- return {
--   'Teatek/gdscript-extended-lsp.nvim',
--   ft = { 'gd', 'gdscript', 'gdscript3' },
--   dependencies = {
--     'neovim/nvim-lspconfig',
--   },
--   config = function()
--     -- If using blink.cmp for completion capabilities:
--     local capabilities = require('blink.cmp').get_lsp_capabilities()
--
--     -- Setup the GDScript Extended LSP
--     require('gdscript_extended_lsp').setup {
--       capabilities = capabilities,
--       settings = {
--         show_native_symbols = true,
--         show_help_in_completion = true,
--       },
--     }
--   end,
-- }
--
-- return {
--   'Teatek/gdscript-extended-lsp.nvim',
--   ft = { 'gd', 'gdscript', 'gdscript3' },
--   dependencies = {
--     'neovim/nvim-lspconfig',
--   },
--   config = function()
--     local capabilities = require('blink.cmp').get_lsp_capabilities()
--
--     require('gdscript_extended_lsp').setup {
--       capabilities = capabilities,
--       settings = {
--         show_native_symbols = true,
--         show_help_in_completion = true,
--       },
--       keymaps = {
--         declaration = 'gd', -- Keymap to go to definition
--         close = { 'q', '<Esc>' }, -- Keymap for closing the documentation
--       },
--     }
--     vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, { silent = true, noremap = true, desc = 'Go to definition (GDScript)' })
--   end,
-- }
