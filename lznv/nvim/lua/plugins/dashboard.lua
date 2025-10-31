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
              icon_hl = '@string',
              -- action = 'Explore /home/brew/.config/',
              action = 'enew',
              key = 'n',
            },
            {
              icon = ' ',
              desc = 'Dotfiles',
              group = 'Label',
              icon_hl = '@constant',
              -- action = 'Explore /home/brew/.config/',
              action = 'Oil --float /home/brew/.config/',
              key = 'd',
            },
          },
          mru = { enable = true, limit = 10, icon = '  Most Recent Files: ', label = '', cwd_only = true },
          footer = { '', '', '', '🔥 Random Motivational Quote Bullshit That I Dont Give A Fuck About 🔥', '- brwxisme -', 'Yesterday - Today' },
        },
      }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  },
}
