local config = {}

function config.nvim_lsp()
  require 'modules.completion.lsp'
end

function config.lspsaga()
  local icons = {
    diagnostics = require('modules.ui.icons').get('diagnostics', true),
    kind = require('modules.ui.icons').get('kind', true),
    type = require('modules.ui.icons').get('type', true),
    ui = require('modules.ui.icons').get('ui', true),
  }
  local function set_sidebar_icons()
    -- Set icons for sidebar.
    local diagnostic_icons = {
      Error = icons.diagnostics.Error_alt,
      Warn = icons.diagnostics.Warning_alt,
      Info = icons.diagnostics.Information_alt,
      Hint = icons.diagnostics.Hint_alt,
    }
    for type, icon in pairs(diagnostic_icons) do
      local hl = 'DiagnosticSign' .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl })
    end
  end

  set_sidebar_icons()
  require('lspsaga').setup {
    server_filetype_map = {
      typescript = 'typescript',
    },
    symbol_in_winbar = {
      -- in_custom = true,
      enable = true,
      -- separator = ' ➤ ',
      separator = ' ➤ ',
    },
  }
end

function config.cmp()
  local lspkind = require 'lspkind'
  local cmp = require 'cmp'

  cmp.setup {
    formatting = {
      format = lspkind.cmp_format {
        mode = 'symbol', -- show only symbol annotations
        maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        before = function(entry, vim_item)
          return vim_item
        end,
      },
    },
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif require('luasnip').expand_or_jumpable() then
          require('luasnip').expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif require('luasnip').jumpable(-1) then
          require('luasnip').jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'path' },
      { name = 'buffer' },
      { name = 'vsnip' },
      { name = 'nvim_lsp_signature_help' },
      -- { name = 'copilot' },
    },
  }
end

function config.luasnip()
  require('luasnip').config.set_config {
    history = true,
    updateevents = 'TextChanged,TextChangedI',
    delete_check_events = 'TextChanged,InsertLeave',
  }
  require('luasnip.loaders.from_lua').lazy_load()
  require('luasnip.loaders.from_vscode').lazy_load()
  require('luasnip.loaders.from_snipmate').lazy_load()
  require('luasnip').filetype_extend('javascript', { 'javascriptreact' })
end

function config.autopairs()
  require('nvim-autopairs').setup {}

  -- If you want insert `(` after select function or method item
  local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
  local cmp = require 'cmp'
  local handlers = require 'nvim-autopairs.completion.handlers'
  cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done {
      filetypes = {
        -- "*" is an alias to all filetypes
        ['*'] = {
          ['('] = {
            kind = {
              cmp.lsp.CompletionItemKind.Function,
              cmp.lsp.CompletionItemKind.Method,
            },
            handler = handlers['*'],
          },
        },
        -- Disable for tex
        tex = false,
      },
    }
  )
end

function config.typescript()
  require('typescript').setup {}
end

return config
