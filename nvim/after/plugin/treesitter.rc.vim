if !exists('g:loaded_nvim_treesitter')
  echom "Not loaded treesitter"
  finish
endif

lua <<EOF
require'nvim-treesitter.configs'.setup {

  highlight = {
    enable = true,
    disable = {"dockerfile"},
  },

  autopairs = { enable = true },

  indent = {
    enable = false,
    disable = {},
  },

  ensure_installed = {
    "tsx",
    "toml",
    "bash",
    "javascript",
    "typescript",
    "json",
    "yaml",
    "html",
    "scss",
    "css",
    "dockerfile",
  },

  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = 1000,
  }
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.used_by = { "javascript", "typescript.tsx" }
EOF
