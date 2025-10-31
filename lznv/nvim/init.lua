vim.opt.rtp:prepend("~/.local/share/nvim/lazy/lazy.nvim")

require("lazy").setup("plugins")


require("configs")
require("configs.keymaps")
require("configs.lsp")
require("configs.godot")
