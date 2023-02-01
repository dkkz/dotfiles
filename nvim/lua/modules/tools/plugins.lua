local tools = {}
local conf = require 'modules.tools.config'

tools['nvim-lua/plenary.nvim'] = { lazy = true }
tools['nvim-telescope/telescope.nvim'] = {
  lazy = true,
  module = 'telescope',
  cmd = 'Telescope',
  config = conf.telescope,
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-lua/popup.nvim' },
    { 'nvim-telescope/telescope-file-browser.nvim' },
    { 'debugloop/telescope-undo.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'nvim-telescope/telescope-live-grep-args.nvim' },
    { 'ahmedkhalf/project.nvim', event = 'BufReadPost', config = conf.project },
  },
}

tools['jose-elias-alvarez/null-ls.nvim'] = {
  lazy = true,
  config = conf.null_ls,
  event = { 'BufReadPost', 'BufAdd', 'BufNewFile' },
  -- event = { 'FocusLost', 'CursorHold' },
  dependencies = { 'nvim-lua/plenary.nvim' },
}

tools['dstein64/vim-startuptime'] = { lazy = true, cmd = 'StartupTime' }

return tools
