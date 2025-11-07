vim.lsp.config('gdscript', {
  -- cmd = { 'ncat', '127.0.0.1', '6005' }, -- Godot’s LSP endpoint
  filetypes = { 'gd', 'gdscript' },
  root_markers = { 'project.godot', '.git' },

  -- Blink automatically manages capabilities
  -- capabilities = vim.lsp.protocol.make_client_capabilities(),

  capabilities = require('blink.cmp').get_lsp_capabilities(),

  on_attach = function(client, bufnr)
    -- Optional keymaps
    local opts = { buffer = bufnr }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  end,
})

vim.lsp.config('qmlls', {
  cmd = { 'qmlls', '-E' },
})
vim.lsp.config('postgres_lsp', {
  cmd = { 'postgres-language-server', 'lsp-proxy' },
  filetypes = { 'sql' }, -- Add this line
  root_dir = '', -- works anywhere
  single_file_support = true,
  -- capabilities = (function()
  --   local base = vim.lsp.protocol.make_client_capabilities()
  --   local blink_caps = require('blink.cmp').get_lsp_capabilities()
  --   return vim.tbl_deep_extend('force', base, blink_caps)
  -- end)(),
  settings = {
    postgres_lsp = {
      connections = {
        {
          connection_string = 'postgresql://postgres:postgres@127.0.0.1:54322/postgres?sslmode=disable',
        },
      },
    },
  },
})
vim.lsp.enable { 'gdscript', 'gdshader_lsp', 'marksman', 'qmlls', 'postgres_lsp' }
-- vim.lsp.qmlls = {
--   enable = true,
--   cmd = { 'qmlls', '-E' },
-- }
