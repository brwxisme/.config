return {

  { 'habamax/vim-godot', event = 'VimEnter' },
  {
    'Teatek/gdscript-extended-lsp.nvim',
    opts = {
      keymaps = {
        declaration = 'gM', -- Keymap to go to definition
        close = { 'q', '<Esc>' }, -- Keymap for closing the documentation
      },
      doc_file_extension = '.txt',
      view_type = 'floating',
      picker = 'telescope',
      -- etc.
    },
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    ensure_installed = { 'gdscript', 'godot_resource', 'gdshader' },
    highlight = {
      enable = true,
    },
  },
}
