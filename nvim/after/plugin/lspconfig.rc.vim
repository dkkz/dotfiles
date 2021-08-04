if !exists('g:lspconfig')
  finish
endif

lua << EOF
-- vim.lsp.set_log_level("debug")
EOF

lua << EOF
local nvim_lsp = require('lspconfig')
local protocol = require('vim.lsp.protocol')

-- Use an on_attach function to only map the following keys 
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)

  require('lsp_signature').on_attach(client)
  vim.lsp.buf.signature_help()

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  --buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  --buf_set_keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  -- buf_set_keymap('n', '<C-j>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  -- buf_set_keymap('n', '<S-C-j>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- buf_set_keymap("n", "<space>fo", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  -- formatting
  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_exec([[
      augroup Format
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()
      augroup END
    ]], false)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[

    hi LspReferenceRead cterm=bold ctermbg=235 guibg=#666666
    hi LspReferenceText cterm=bold ctermbg=235 guibg=#666666
    hi LspReferenceWrite cterm=bold ctermbg=235 guibg=#666666

    augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END

    ]], false)
  end

  --protocol.SymbolKind = { }
  protocol.CompletionItemKind = {
    '', -- Text
    '', -- Method
    '', -- Function
    '', -- Constructor
    '', -- Field
    '', -- Variable
    '', -- Class
    'ﰮ', -- Interface
    '', -- Module
    '', -- Property
    '', -- Unit
    '', -- Value
    '', -- Enum
    '', -- Keyword
    '﬌', -- Snippet
    '', -- Color
    '', -- File
    '', -- Reference
    '', -- Folder
    '', -- EnumMember
    '', -- Constant
    '', -- Struct
    '', -- Event
    'ﬦ', -- Operator
    '', -- TypeParameter
  }
end

-- config that activates keymaps and enables snippet support
local function make_config()
  --Enable completion
  local capabilities = protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
      }
    }

  capabilities.textDocument.codeAction = {
    dynamicRegistration = true,
    codeActionLiteralSupport = {
      codeActionKind = {
        valueSet = (function()
        local res = vim.tbl_values(protocol.CodeActionKind)
        table.sort(res)
        return res
      end)()
      }
    }
  }
  return {
    capabilities = capabilities,
    on_attach = on_attach,
  }
end

do
  local method = "textDocument/publishDiagnostics"
  local default_handler = vim.lsp.handlers[method]
  vim.lsp.handlers[method] = function(err, method, result, client_id, bufnr,config)
      default_handler(err, method, result, client_id, bufnr, config)
      local diagnostics = vim.lsp.diagnostic.get_all()
      local qflist = {}
      for bufnr, diagnostic in pairs(diagnostics) do
          for _, d in ipairs(diagnostic) do
              d.bufnr = bufnr
              d.lnum = d.range.start.line + 1
              d.col = d.range.start.character + 1
              d.text = d.message
              table.insert(qflist, d)
          end
      end
      vim.lsp.util.set_qflist(qflist)
  end
end

-- icon
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    -- This sets the spacing and the prefix, obviously.
    virtual_text = {
      spacing = 4,
      prefix = ''
    }
  }
)

local function setup_servers()

  require'lspinstall'.setup()
  local servers = require'lspinstall'.installed_servers()

  table.insert(servers, "gopls")

  for _, server in pairs(servers) do

    local config = make_config()

    -- if server == "gopls" then
    --   config.filetypes = { "go", "gomod" };
    --   config.cmd = {"gopls", "serve"};
    --   config.settings = {
    --     gopls = {
    --       analyses = { unusedparams = true, },
    --       experimentalPostfixCompletions = true,
    --       staticcheck = true,
    --       },
    --     };
    --  -- config.root_dir = root_pattern("go.mod", ".git");
    -- end

    if server == "diagnosticls" then
      config.filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'json', 'typescript', 'typescriptreact', 'typescript.tsx', 'css', 'scss', 'markdown' };
      config.init_options = {
        linters = {
          eslint = {
            command = 'eslint_d',
            -- rootPatterns = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
            rootPatterns = { ".git" },
            debounce = 100,
            args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json' },
            sourceName = 'eslint_d',
            parseJson = {
              errorsRoot = '[0].messages',
              line = 'line',
              column = 'column',
              endLine = 'endLine',
              endColumn = 'endColumn',
              message = '[eslint] ${message} [${ruleId}]',
              security = 'severity'
            },
            securities = {
              [2] = 'error',
              [1] = 'warning'
            }
          },
        },
        filetypes = {
          javascript = 'eslint',
          javascriptreact = 'eslint',
          typescript = 'eslint',
          typescriptreact = 'eslint',
        },
        formatters = {
          eslint_d = {
            command = 'eslint_d',
            args = { '--stdin', '--stdin-filename', '%filename', '--fix-to-stdout' },
            -- rootPatterns = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
            rootPatterns = { ".git" },
          },
          prettier = {
            command = 'prettier',
            args = { '--stdin-filepath', '%filename' }
          }
        },
        formatFiletypes = {
          css = 'prettier',
          javascript = 'prettier',
          javascriptreact = 'prettier',
          json = 'prettier',
          scss = 'prettier',
          typescript = 'prettier',
          -- typescriptreact = 'eslint_d',
          typescriptreact = 'prettier',
          json = 'prettier',
          markdown = 'prettier',
        }
      };
    end

    nvim_lsp[server].setup(config)
  end
end

setup_servers()

EOF
