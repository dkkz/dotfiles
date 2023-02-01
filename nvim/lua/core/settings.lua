local settings = {}
-- local home = os.getenv 'HOME'
local home = require('core.global').home

settings['use_ssh'] = true
settings['format_on_save'] = true
settings['format_disabled_dirs'] = {
  home .. '/format_disabled_dir_under_home',
}

-- Set it to false if you don't use nvim to open big files.
settings['load_big_files_faster'] = false

settings['colorscheme'] = 'gruvbox'
settings['background'] = 'dark'

return settings
