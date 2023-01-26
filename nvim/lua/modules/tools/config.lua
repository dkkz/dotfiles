local config = {}

function config.telescope()
  local icons = { ui = require('modules.ui.icons').get('ui', true) }
  local telescope_actions = require 'telescope.actions.set'
  local fixfolds = {
    hidden = true,
    attach_mappings = function(_)
      telescope_actions.select:enhance {
        post = function()
          vim.api.nvim_command [[:normal! zx"]]
        end,
      }
      return true
    end,
  }

  local lga_actions = require 'telescope-live-grep-args.actions'

  local function telescope_buffer_dir()
    return vim.fn.expand '%:p:h'
  end

  require('telescope').setup {
    defaults = {
      initial_mode = 'insert',
      prompt_prefix = ' ' .. icons.ui.Telescope .. ' ',
      selection_caret = icons.ui.ChevronRight,
      entry_prefix = ' ',
      scroll_strategy = 'limit',
      results_title = false,
      layout_strategy = 'horizontal',
      path_display = { 'absolute' },
      file_ignore_patterns = { '.git/', '.cache', '%.class', '%.pdf', '%.mkv', '%.mp4', '%.zip' },
      layout_config = {
        horizontal = {
          preview_width = 0.5,
        },
      },
      file_previewer = require('telescope.previewers').vim_buffer_cat.new,
      grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
      qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
      file_sorter = require('telescope.sorters').get_fuzzy_file,
      generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
    },
    extensions = {
      fzf = {
        fuzzy = false,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = 'smart_case',
      },
      live_grep_args = {
        auto_quoting = true, -- enable/disable auto-quoting
        -- define mappings, e.g.
        mappings = { -- extend mappings
          i = {
            ['<C-k>'] = lga_actions.quote_prompt(),
            ['<C-i>'] = lga_actions.quote_prompt { postfix = ' --iglob ' },
          },
        },
      },
      file_browser = {
        theme = 'ivy',
        -- disables netrw and use telescope-file-browser in its place
        hijack_netrw = true,

        cwd = telescope_buffer_dir(),
        mappings = {
          ['i'] = {
            -- your custom insert mode mappings
          },
          ['n'] = {
            -- your custom normal mode mappings
          },
        },
      },
      undo = {
        side_by_side = true,
        layout_config = {
          preview_height = 0.8,
        },
        mappings = { -- this whole table is the default
          i = {
            -- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
            -- you want to use the following actions. This means installing as a dependency of
            -- telescope in it's `requirements` and loading this extension from there instead of
            -- having the separate plugin definition as outlined above. See issue #6.
            ['<cr>'] = require('telescope-undo.actions').yank_additions,
            ['<S-cr>'] = require('telescope-undo.actions').yank_deletions,
            ['<C-cr>'] = require('telescope-undo.actions').restore,
          },
        },
      },
    },

    pickers = {
      buffers = fixfolds,
      find_files = fixfolds,
      git_files = fixfolds,
      grep_string = fixfolds,
      live_grep = fixfolds,
      oldfiles = fixfolds,
    },
  }

  require('telescope').load_extension 'fzf'
  require('telescope').load_extension 'file_browser'
  require('telescope').load_extension 'live_grep_args'
  require('telescope').load_extension 'projects'
end

function config.project()
  require('project_nvim').setup {
    manual_mode = false,
    detection_methods = { 'lsp', 'pattern' },
    patterns = { '.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'package.json' },
    ignore_lsp = { 'efm', 'copilot' },
    exclude_dirs = {},
    show_hidden = false,
    silent_chdir = true,
    scope_chdir = 'global',
    datapath = vim.fn.stdpath 'data',
  }
end

function config.null_ls()
  local augroupNull = vim.api.nvim_create_augroup('LspFormatting', {})
  require('null-ls').setup {
    on_attach = function(client, bufnr)
      if client.supports_method 'textDocument/formatting' then
        vim.api.nvim_clear_autocmds { group = augroupNull, buffer = bufnr }
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = augroupNull,
          buffer = bufnr,
          callback = function()
            -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
            -- vim.lsp.buf.formatting_sync()
            vim.lsp.buf.format { bufnr = bufnr }
          end,
        })
      end
    end,
    sources = {
      require('null-ls').builtins.formatting.stylua,
      require('null-ls').builtins.formatting.yamlfmt,
      require('null-ls').builtins.formatting.goimports,
      require('null-ls').builtins.diagnostics.tidy,
      require('null-ls').builtins.formatting.prettier.with {
        -- disabled_filetypes = { 'html' },
        extra_filetypes = { 'prisma' },
        condition = function(utils)
          return utils.has_file { '.prettierrc.json', '.prettierrc.js', '.prettierrc' }
        end,
      },
    },
  }
end

return config
