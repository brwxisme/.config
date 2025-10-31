return {
  {
    'stevearc/conform.nvim',
    enabled = function()
      local cwd = vim.fn.getcwd()
      return not cwd:find 'AoK'
    end,
  },
}
