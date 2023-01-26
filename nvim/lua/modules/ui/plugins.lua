local ui = {}
local conf = require 'modules.ui.config'

ui['hoob3rt/lualine.nvim'] = {
  lazy = true,
  event = { 'BufReadPost', 'BufAdd', 'BufNewFile' },
  config = conf.lualine,
}

ui['goolord/alpha-nvim'] = {
  lazy = true,
  event = 'BufWinEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true },
  config = conf.alpha,
}

ui['lewis6991/gitsigns.nvim'] = {
  lazy = true,
  event = { 'BufReadPost', 'BufNewFile' },
  config = conf.gitsigns,
}
ui['lukas-reineke/indent-blankline.nvim'] = {
  lazy = true,
  event = 'BufReadPost',
  config = conf.indent_blankline,
}

ui['j-hui/fidget.nvim'] = {
  lazy = true,
  event = 'BufReadPost',
  config = conf.fidget,
}

ui['ellisonleao/gruvbox.nvim'] = {
  lazy = false,
  name = 'gruvbox',
  config = conf.gruvbox,
}

ui['folke/todo-comments.nvim'] = {
  lazy = true,
  config = conf.todo,
  event = { 'BufReadPost', 'BufNewFile' },
}

ui['folke/noice.nvim'] = {
  lazy = true,
  event = { 'BufRead', 'BufNewFile', 'InsertEnter', 'CmdlineEnter' },
  module = { 'noice' },

  config = conf.noice,
  dependencies = {
    { 'MunifTanjim/nui.nvim', lazy = true },
    { 'rcarriga/nvim-notify', lazy = true, event = 'VeryLazy', config = conf.notify },
  },
}

return ui
