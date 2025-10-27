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
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {

      cmdline = {
        enabled = true, -- enables the Noice cmdline UI
        view = 'cmdline', -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
        opts = {}, -- global options for the cmdline. See section on views
        ---@type table<string, CmdlineFormat>
        format = {
          -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
          -- view: (default is cmdline view)
          -- opts: any options passed to the view
          -- icon_hl_group: optional hl_group for the icon
          -- title: set to anything or empty string to hide
          cmdline = { pattern = '^:', icon = ':', lang = 'vim' },
          -- add any options here
          --
        },
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
  },
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      default_file_explorer = true,
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
      keymaps = {
        ['<CR>'] = function()
          local oil = require 'oil'
          local actions = require 'oil.actions'

          local entry = oil.get_cursor_entry()
          if not entry then
            return
          end

          local name = entry.name
          local path = oil.get_current_dir() .. name

          -- handle directories
          local fs = vim.loop.fs_stat(path)
          if fs and fs.type == 'directory' then
            return oil.select { vertical = false }
          end

          -- 🎞️ detect video or image by extension
          local is_media = name:match '%.png$'
            or name:match '%.jpg$'
            or name:match '%.jpeg$'
            or name:match '%.gif$'
            or name:match '%.webp$'
            or name:match '%.bmp$'
            or name:match '%.mp4$'
            or name:match '%.mkv$'
            or name:match '%.webm$'
            or name:match '%.avi$'
            or name:match '%.mov$'

          if is_media then
            actions.open_external.callback()
          else
            oil.select { vertical = false }
          end
        end,
      },
    },
    -- Optional dependencies
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
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
            { desc = '󰊳 Update', icon_hl = '@variable', group = '@property', action = 'Lazy update', key = 'u' },
            {
              icon = ' ',
              icon_hl = '@variable',
              desc = 'Files',
              group = 'Label',
              action = 'Telescope find_files',
              key = 'f',
            },
            {
              icon = ' ',
              desc = 'New File',
              group = 'Label',
              icon_hl = '@variable',
              -- action = 'Explore /home/brew/.config/',
              action = 'enew',
              key = 'd',
            },
            {
              icon = ' ',
              desc = 'Dotfiles',
              group = 'Label',
              icon_hl = '@variable',
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
  { 'ellisonleao/gruvbox.nvim', priority = 1000, config = true, opts = ... },
  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
  { 'rose-pine/neovim', name = 'rose-pine' },
  { 'rebelot/kanagawa.nvim', name = 'kanagawa' },

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

  {
    'kndndrj/nvim-dbee',
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    build = function()
      -- Install tries to automatically detect the install method.
      -- if it fails, try calling it with one of these parameters:
      --    "curl", "wget", "bitsadmin", "go"
      require('dbee').install()
    end,
    config = function()
      require('dbee').setup(--[[optional config]])
    end,
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },

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
}
