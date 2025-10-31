return {

  {
    'eldritch-theme/eldritch.nvim',
    lazy = false,
    priority = 1000,
    opts = {

      -- on_colors = function(colors)
      --   colors.fg_gutter = '#FFFFFF'
      -- end,
      on_highlights = function(highlights)
        -- highlights.LineNr.fg = '#FFFFFF'
        highlights.LineNr.fg = '#7079a3'
        highlights.Comment.fg = '#4f5d9e'
        highlights.Type.fg = '#03f9de'
      end,
      dim_inactive = true,
      transparent = true,
    },
  },
  { 'ellisonleao/gruvbox.nvim', priority = 1000, config = true, opts = ... },
  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
  { 'rose-pine/neovim', name = 'rose-pine' },
  { 'rebelot/kanagawa.nvim', name = 'kanagawa' },
}
