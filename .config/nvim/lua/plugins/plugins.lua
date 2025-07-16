return {
{
  'TobinPalmer/pastify.nvim',
  cmd = { 'Pastify', 'PastifyAfter' },
  config = function()
    require('pastify').setup {
      opts = {
      },
    }
  end
},

{
  'morhetz/gruvbox',
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd([[colorscheme gruvbox]])
  end,
}
}
