return {
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
}
