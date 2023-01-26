local editor = {}
local conf = require 'modules.editor.config'

editor['nvim-treesitter/nvim-treesitter'] = {
  lazy = true,
  build = ':TSUpdate',
  event = 'BufReadPost',
  config = conf.nvim_treesitter,
  dependencies = {
    { 'nvim-treesitter/nvim-treesitter-textobjects' },
    { 'p00f/nvim-ts-rainbow' },
    { 'JoosepAlviste/nvim-ts-context-commentstring' },
    { 'mfussenegger/nvim-ts-hint-textobject' },
    { 'windwp/nvim-ts-autotag', config = conf.autotag },
    { 'NvChad/nvim-colorizer.lua', config = conf.nvim_colorizer, ft = { 'lua', 'css', 'html', 'sass', 'less', 'typescriptreact' } },
  },
}

editor['RRethy/vim-illuminate'] = {
  lazy = true,
  event = 'BufReadPost',
  config = conf.illuminate,
}

editor['numToStr/Comment.nvim'] = {
  lazy = true,
  event = { 'BufNewFile', 'BufReadPre' },
  config = conf.comment,
}

editor['sindrets/diffview.nvim'] = {
  lazy = true,
  cmd = { 'DiffviewOpen', 'DiffviewClose' },
}

editor['tpope/vim-fugitive'] = { lazy = true, cmd = { 'Git', 'G' } }

editor['tpope/vim-surround'] = { lazy = true, event = { 'CursorMoved' } }

return editor
