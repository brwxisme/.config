return {

  -- {
  --   'MeanderingProgrammer/render-markdown.nvim',
  --   dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim', 'saghen/blink.cmp' }, -- if you use the mini.nvim suite
  --   -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
  --   -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  --   ---@module 'render-markdown'
  --   ---@type render.md.UserConfig
  --   opts = {},
  --   completions = { lsp = { enabled = true } },
  -- },
  {
    'OXY2DEV/markview.nvim',
    lazy = false,

    -- For blink.cmp's completion
    -- source
    opts = {
      preview = {
        icon_provider = 'internal', -- "mini" or "devicons"
      },
      block_quotes = {
        enable = true,
        wrap = true,
        ['HINT'] = {
          hl = 'MarkviewBlockQuoteOk',
          preview = ' Hint',

          title = true,
          icon = '',
        },
        ['TODO'] = {
          hl = 'MarkviewBlockQuoteNote',
          preview = ' Todo',

          title = true,
          icon = ' ',
        },
      },
    },
    dependencies = {
      'saghen/blink.cmp',
    },
  },
  { 'opdavies/toggle-checkbox.nvim', keys = {
    { '<leader>tt', function() require('toggle-checkbox').toggle() end, desc = 'Debug: Start/Continue' },
  } },
}
