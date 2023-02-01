local config = {}

function config.illuminate()
  require('illuminate').configure {
    providers = {
      'lsp',
      'treesitter',
      'regex',
    },
    delay = 100,
    filetypes_denylist = {
      'alpha',
      'dashboard',
      'DoomInfo',
      'fugitive',
      'help',
      'norg',
      'Outline',
      'toggleterm',
    },
    under_cursor = false,
  }
  vim.api.nvim_set_hl(0, 'IlluminatedWordText', { link = 'Visual' })
  vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { link = 'Visual' })
  vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { link = 'Visual' })
  vim.api.nvim_command 'au VimEnter delcommand EnableIllumination'
end

function config.nvim_treesitter()
  require('nvim-treesitter.configs').setup {
    ensure_installed = { 'lua', 'typescript', 'rust', 'go' },
    context_commentstring = {
      enable = true,
      config = {
        javascript = {
          __default = '// %s',
          jsx_element = '{/* %s */}',
          jsx_fragment = '{/* %s */}',
          jsx_attribute = '// %s',
          comment = '// %s',
        },
      },
    },

    highlight = { enable = true },
    indent = { enable = true },

    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        -- TODO: I'm not sure for this one.
        scope_incremental = '<c-s>',
        node_decremental = '<c-backspace>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    },
    rainbow = {
      enable = true,
      disable = { 'php' },
      extended_mode = true,
      max_file_lines = 2000,
    },
  }
end

function config.autotag()
  require('nvim-ts-autotag').setup {
    filetypes = {
      'html',
      'javascript',
      'typescriptreact',
      'javascriptreact',
    },
  }
end

function config.comment()
  require('Comment').setup {
    pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
  }
end

function config.nvim_colorizer()
  require('colorizer').setup {
    'css',
    'javascript',
    html = {
      mode = 'foreground',
    },
  }
end

function config.bigfile()
  local ftdetect = {
    name = 'ftdetect',
    opts = { defer = true },
    disable = function()
      vim.api.nvim_set_option_value('filetype', 'disabled_big_file', { scope = 'local' })
    end,
  }

  local cmp = {
    name = 'nvim-cmp',
    opts = { defer = true },
    disable = function()
      require('cmp').setup.buffer { enabled = false }
    end,
  }

  require('bigfile').config {
    filesize = 1, -- size of the file in MiB
    pattern = { '*' }, -- autocmd pattern
    features = { -- features to disable
      'indent_blankline',
      'lsp',
      'illuminate',
      'treesitter',
      'syntax',
      'vimopts',
      ftdetect,
      cmp,
    },
  }
end

return config
