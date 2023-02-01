local config = {}

function config.alpha()
  require('alpha').setup(require('alpha.themes.startify').config)
end

function config.gruvbox()
  require('gruvbox').setup {
    transparent_mode = true,
  }
  -- vim.o.background = 'dark'
  -- vim.api.nvim_command [[colorscheme gruvbox]]
end

-- function config.nord()
-- 	vim.g.nord_contrast = true
-- 	vim.g.nord_borders = false
-- 	vim.g.nord_cursorline_transparent = true
-- 	vim.g.nord_disable_background = false
-- 	vim.g.nord_enable_sidebar_background = true
-- 	vim.g.nord_italic = true
-- end

function config.lualine()
  require('lualine').setup {
    options = {
      -- theme = 'nord',
      -- theme = 'onedark',
      theme = 'gruvbox',
      -- theme = 'rose-pine',
      -- theme = 'dracula-nvim',

      -- globalstatus = true,
    },
    -- sections = {
    --   lualine_c = {
    --     {
    --       'filename',
    --       path = 2, -- 0 = just filename, 1 = relative path, 2 = absolute path
    --     },
    --   },
    -- },
    extensions = { 'fugitive' },
  }
end

function config.gitsigns()
  require('gitsigns').setup {
    signs = {
      add = {
        hl = 'GitSignsAdd',
        text = '│',
        numhl = 'GitSignsAddNr',
        linehl = 'GitSignsAddLn',
      },
      change = {
        hl = 'GitSignsChange',
        text = '│',
        numhl = 'GitSignsChangeNr',
        linehl = 'GitSignsChangeLn',
      },
      delete = {
        hl = 'GitSignsDelete',
        text = '_',
        numhl = 'GitSignsDeleteNr',
        linehl = 'GitSignsDeleteLn',
      },
      topdelete = {
        hl = 'GitSignsDelete',
        text = '‾',
        numhl = 'GitSignsDeleteNr',
        linehl = 'GitSignsDeleteLn',
      },
      changedelete = {
        hl = 'GitSignsChange',
        text = '~',
        numhl = 'GitSignsChangeNr',
        linehl = 'GitSignsChangeLn',
      },
    },
    keymaps = {
      -- Default keymap options
      noremap = true,
      buffer = true,
      ['n ]g'] = {
        expr = true,
        "&diff ? ']g' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'",
      },
      ['n [g'] = {
        expr = true,
        "&diff ? '[g' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'",
      },
      ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
      ['v <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
      ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
      ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
      ['v <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
      ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
      ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
      ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line({full=true})<CR>',
      -- Text objects
      ['o ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>',
      ['x ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>',
    },
    watch_gitdir = { interval = 1000, follow_files = true },
    current_line_blame = true,
    current_line_blame_opts = { delay = 1000, virtual_text_pos = 'eol' },
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    word_diff = false,
    diff_opts = { internal = true },
  }
end

function config.indent_blankline()
  require('indent_blankline').setup {
    char = '│',
    show_first_indent_level = true,
    filetype_exclude = {
      'startify',
      'dashboard',
      'dotooagenda',
      'log',
      'fugitive',
      'gitcommit',
      'vimwiki',
      'markdown',
      'json',
      'txt',
      'vista',
      'help',
      'todoist',
      'NvimTree',
      'peekaboo',
      'git',
      'TelescopePrompt',
      'flutterToolsOutline',
      '', -- for all buffers without a file type
    },
    buftype_exclude = { 'terminal', 'nofile' },
    show_trailing_blankline_indent = false,
    show_current_context = true,
    context_patterns = {
      'class',
      'function',
      'method',
      'block',
      'list_literal',
      'selector',
      '^if',
      '^table',
      'if_statement',
      'while',
      'for',
      'type',
      'var',
      'import',
    },
    space_char_blankline = ' ',
  }
end

function config.fidget()
  require('fidget').setup {
    window = { blend = 0 },
  }
end

function config.todo()
  require('todo-comments').setup {}
end

function config.noice()
  require('noice').setup {
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },
    },
    -- you can enable a preset for easier configuration
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false, -- add a border to hover docs and signature help
    },
  }
end

-- function config.notify()
--   require('notify').setup {
--     -- background_colour = '#1e222a',
--     background_colour = '#ffd700',
--     stages = 'static',
--   }
-- end

function config.notify()
  local notify = require 'notify'
  local icons = {
    diagnostics = require('modules.ui.icons').get 'diagnostics',
    ui = require('modules.ui.icons').get 'ui',
  }

  notify.setup {
    ---@usage Animation style one of { "fade", "slide", "fade_in_slide_out", "static" }
    stages = 'slide',
    ---@usage Function called when a new window is opened, use for changing win settings/config
    on_open = nil,
    ---@usage Function called when a window is closed
    on_close = nil,
    ---@usage timeout for notifications in ms, default 5000
    timeout = 2000,
    -- @usage User render fps value
    fps = 30,
    -- Render function for notifications. See notify-render()
    render = 'default',
    ---@usage highlight behind the window for stages that change opacity
    background_colour = 'Normal',
    ---@usage minimum width for notification windows
    minimum_width = 50,
    ---@usage notifications with level lower than this would be ignored. [ERROR > WARN > INFO > DEBUG > TRACE]
    level = 'TRACE',
    ---@usage Icons for the different levels
    icons = {
      ERROR = icons.diagnostics.Error,
      WARN = icons.diagnostics.Warning,
      INFO = icons.diagnostics.Information,
      DEBUG = icons.ui.Bug,
      TRACE = icons.ui.Pencil,
    },
  }

  vim.notify = notify
end

return config
