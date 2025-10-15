-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
--

local logo_two = [[
  ▁▁▁▁▁                                                                          ▁▁▁▁▁ 
 ( ▁▁▁ )                                                                        ( ▁▁▁ )
 ▐   ▐--------------------------------------------------------------------------▐   ▐ 
 ▐   ▐                                 All Hail                                 ▐   ▐ 
 ▐   ▐                                                                          ▐   ▐ 
 ▐   ▐     ██████╗ ██████╗ ██╗    ██╗██╗  ██╗██╗███████╗███╗   ███╗███████╗     ▐   ▐ 
 ▐   ▐     ██╔══██╗██╔══██╗██║    ██║╚██╗██╔╝██║██╔════╝████╗ ████║██╔════╝     ▐   ▐ 
 ▐   ▐     ██████╔╝██████╔╝██║ █╗ ██║ ╚███╔╝ ██║███████╗██╔████╔██║█████╗       ▐   ▐ 
 ▐   ▐     ██╔══██╗██╔══██╗██║███╗██║ ██╔██╗ ██║╚════██║██║╚██╔╝██║██╔══╝       ▐   ▐ 
 ▐   ▐     ██████╔╝██║  ██║╚███╔███╔╝██╔╝ ██╗██║███████║██║ ╚═╝ ██║███████╗     ▐   ▐ 
 ▐   ▐     ╚═════╝ ╚═╝  ╚═╝ ╚══╝╚══╝ ╚═╝  ╚═╝╚═╝╚══════╝╚═╝     ╚═╝╚══════╝     ▐   ▐ 
 ▐   ▐                                                                          ▐   ▐ 
 ▐▁▁▁▐--------------------------------------------------------------------------▐▁▁▁▐ 
(▁▁▁▁▁)                                                                        (▁▁▁▁▁)
]]

local logo = [[

      ▐▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▌
      ▐                                                                                    ▌
      ▐          ▄▄▄▄    ██▀███   █     █░▒██   ██▒ ██▓  ██████  ███▄ ▄███▓▓█████          ▌
      ▐         ▓█████▄ ▓██ ▒ ██▒▓█░ █ ░█░▒▒ █ █ ▒░▓██▒▒██    ▒ ▓██▒▀█▀ ██▒▓█   ▀          ▌
      ▐         ▒██▒ ▄██▓██ ░▄█ ▒▒█░ █ ░█ ░░  █   ░▒██▒░ ▓██▄   ▓██    ▓██░▒███            ▌
      ▐         ▒██░█▀  ▒██▀▀█▄  ░█░ █ ░█  ░ █ █ ▒ ░██░  ▒   ██▒▒██    ▒██ ▒▓█  ▄          ▌
      ▐         ░▓█  ▀█▓░██▓ ▒██▒░░██▒██▓ ▒██▒ ▒██▒░██░▒██████▒▒▒██▒   ░██▒░▒████▒         ▌
      ▐         ░▒▓███▀▒░ ▒▓ ░▒▓░░ ▓░▒ ▒  ▒▒ ░ ░▓ ░░▓  ▒ ▒▓▒ ▒ ░░ ▒░   ░  ░░░ ▒░ ░         ▌
      ▐         ▒░▒   ░   ░▒ ░ ▒░  ▒ ░ ░  ░░   ░▒ ░ ▒ ░░ ░▒  ░ ░░  ░      ░ ░ ░  ░         ▌
      ▐          ░    ░   ░░   ░   ░   ░   ░    ░   ▒ ░░  ░  ░  ░      ░      ░            ▌
      ▐          ░         ░         ░     ░    ░   ░        ░         ░      ░  ░         ▌
      ▐               ░                                                                    ▌
      ▐                                                                                    ▌
      ▐                           not a cracker group btw                                  ▌
      ▐▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▌

            ]]
logo = string.rep('\n', 8) .. logo .. '\n\n'
return {
  {
    'ggandor/leap.nvim',
    enabled = true,
    keys = {
      { 's', mode = { 'n', 'x', 'o' }, desc = 'Leap Forward to' },
      { 'S', mode = { 'n', 'x', 'o' }, desc = 'Leap Backward to' },
      { 'gs', mode = { 'n', 'x', 'o' }, desc = 'Leap from Windows' },
    },
    config = function(_, opts)
      local leap = require 'leap'
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
      vim.keymap.del({ 'x', 'o' }, 'x')
      vim.keymap.del({ 'x', 'o' }, 'X')
    end,
  },
  -- {
  --   'folke/noice.nvim',
  --   event = 'VeryLazy',
  --   opts = {
  --
  --     cmdline = {
  --       enabled = true, -- enables the Noice cmdline UI
  --       view = 'cmdline_popup', -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
  --       opts = {}, -- global options for the cmdline. See section on views
  --       ---@type table<string, CmdlineFormat>
  --       format = {
  --         -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
  --         -- view: (default is cmdline view)
  --         -- opts: any options passed to the view
  --         -- icon_hl_group: optional hl_group for the icon
  --         -- title: set to anything or empty string to hide
  --         cmdline = { pattern = '^:', icon = ':', lang = 'vim' },
  --         -- add any options here
  --         --
  --       },
  --     },
  --   },
  --   dependencies = {
  --     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
  --     'MunifTanjim/nui.nvim',
  --     -- OPTIONAL:
  --     --   `nvim-notify` is only needed, if you want to use the notification view.
  --     --   If not available, we use `mini` as the fallback
  --     'rcarriga/nvim-notify',
  --   },
  -- },
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      default_file_explorer = false,
      win_options = {
        wrap = false,
        signcolumn = 'no',
        cursorcolumn = false,
        foldcolumn = '0',
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = 'nvic',
      },
      float = {
        -- Padding around the floating window
        padding = 12,
        -- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        max_width = 64 + 32,
        max_height = 64,
        border = 'rounded',
        win_options = {
          winblend = 0,
        }, -- optionally override the oil buffers window title with custom function: fun(winid: integer): string
        get_win_title = nil,
        -- preview_split: Split direction: "auto", "left", "right", "above", "below".
        preview_split = 'auto',
        -- This is the config that will be passed to nvim_open_win.
        -- Change values here to customize the layout
        footer = 'eteee',
        override = function(defaults)
          -- align to the left
          defaults['title'] = ''
          defaults['title_pos'] = 'center'

          return defaults
        end,
      },
    },
    -- Optional dependencies
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
  },
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        -- config
        theme = 'hyper',
        config = {
          header = vim.split(logo_two, '\n'),
          shortcut = {
            { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
            {
              icon = ' ',
              icon_hl = '@variable',
              desc = 'Files',
              group = 'Label',
              action = 'Telescope find_files',
              key = 'f',
            },
            {
              desc = ' Apps',
              group = 'DiagnosticHint',
              action = 'Telescope app',
              key = 'a',
            },
            {
              desc = ' dotfiles',
              group = 'Number',
              -- action = 'Explore /home/brew/.config/',
              action = 'Oil --float /home/brew/.config/',
              key = 'd',
            },
          },
          footer = { '', '', '', '🔥 Random Motivational Quote Bullshit That I Dont Give A Fuck About 🔥', '- brwxisme -', 'Yesterday - Today' },
        },
      }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  },
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
  {
    'Aasim-A/scrollEOF.nvim',
    event = { 'CursorMoved', 'WinScrolled' },
    opts = {},
  },
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

      vim.keymap.set('n', '<C-h>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list(), { ui_width_ratio = 0.6, ui_height_ratio = 0.5, border = 'rounded', title_pos = 'center' })
      end)

      for i = 1, 10 do
        local key = (i == 10) and '0' or tostring(i)
        vim.keymap.set('n', '<leader>a' .. key, function()
          harpoon:list():replace_at(i)
        end, { desc = 'Harpoon: assign slot ' .. i })
      end

      for i = 1, 10 do
        local key = (i == 10) and '0' or tostring(i)
        vim.keymap.set('n', '<A-' .. key .. '>', function()
          harpoon:list():select(i)
        end, { desc = 'Harpoon: jump to slot ' .. i })
      end
    end,
  },
}
