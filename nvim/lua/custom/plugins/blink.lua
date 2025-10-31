return {
  {
    'saghen/blink.compat',
    -- use v2.* for blink.cmp v1.*
    version = '2.*',
    -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
    lazy = true,
    -- make sure to set opts so that lazy.nvim calls blink.compat's setup
    opts = {},
  },
  {
    'MattiasMTS/cmp-dbee',
    dependencies = {
      { 'kndndrj/nvim-dbee' },
    },
    ft = 'sql', -- optional but good to have
    opts = {}, -- needed
  },
  {
    'saghen/blink.cmp',
    dependencies = {
      'MattiasMTS/cmp-dbee',
      ft = { 'sql' },
      dependencies = { 'kndndrj/nvim-dbee' },
    },
    opts = {
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        per_filetype = {
          -- Dbee
          sql = { 'dbee', 'buffer' }, -- Add any other source to include here
        },
        providers = {
          dbee = { name = 'cmp-dbee', module = 'blink.compat.source' },
        },
      },
    },
  },
}
