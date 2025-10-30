if os.getenv 'USER' == 'root' then
  vim.cmd.colorscheme 'kanagawa-dragon'
else
  vim.cmd.colorscheme 'eldritch'
end

vim.o.smartindent = true
vim.o.relativenumber = true
vim.o.expandtab = false
vim.o.tabstop = 8
vim.o.shiftwidth = 0
vim.o.pumheight = 10
vim.o.pumblend = 25
vim.o.scrolloff = 35

vim.o.swapfile = false

vim.diagnostic.config {
  virtual_text = true,
}

require('telescope').setup {
  defaults = {
    file_ignore_patterns = {
      'node_modules',
      '%.env',
      '%.log',
      '__pycache__',
      '%.xlsx',
      '%.jpg',
      '%.png',
      '%.webp',
      '%.pxo',
      '%.uid',
      '%.pdf',
      '%.odt',
      '%.ico',
    },
  },
}
vim.cmd.highlight 'IndentLine guifg=#123456'
-- Current indent line highlight
vim.cmd.highlight 'IndentLineCurrent guifg=#123456'
