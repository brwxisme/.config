vim.lsp.config('gdscript', {
  -- cmd = { 'ncat', '127.0.0.1', '6005' }, -- Godot’s LSP endpoint
  filetypes = { 'gd', 'gdscript' },
  root_markers = { 'project.godot', '.git' },

  -- Blink automatically manages capabilities
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  -- capabilities = capabilities,

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
vim.lsp.enable { 'gdscript', 'gdshader_lsp', 'marksman', 'qmlls' }
-- vim.lsp.qmlls = {
--   enable = true,
--   cmd = { 'qmlls', '-E' },
-- }
