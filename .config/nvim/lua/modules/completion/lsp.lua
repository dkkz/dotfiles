-- local formatting = require 'modules.completion.formatting'
local mason = require 'mason'
local mason_lsp = require 'mason-lspconfig'

-- null-ls
local lsp_formatting = function(bufnr)
  vim.lsp.buf.format {
    filter = function(client)
      -- apply whatever logic you want (in this example, we'll only use null-ls)
      return client.name == 'null-ls'
    end,
    bufnr = bufnr,
  }
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
-- LSP settings
local on_attach = function(client, bufnr)
  -- null-ls
  if client.supports_method 'textDocument/formatting' then
    vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = augroup,
      buffer = bufnr,
      callback = function()
        lsp_formatting(bufnr)
      end,
    })
  end
end

mason.setup {
  providers = {
    'mason.providers.client',
    'mason.providers.registry-api',
  },
}

mason_lsp.setup {
  ensure_installed = {
    'sumneko_lua',
    'bashls',
    'dockerls',
    'rust_analyzer',
    'tsserver',
    'cssls',
    'gopls',
    'html',
    'yamlls',
    'stylelint_lsp',
  },
}

-- Example custom server
-- Make runtime files discoverable to the server
-- local runtime_path = vim.split(package.path, ';')
-- table.insert(runtime_path, 'lua/?.lua')
-- table.insert(runtime_path, 'lua/?/init.lua')

-- nvim-cmp supports additional completion capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

mason_lsp.setup_handlers {
  function(server_name)
    local opts = {}
    opts.on_attach = on_attach
    opts.capabilities = capabilities
    if server_name == 'sumneko_lua' then
      opts.settings = {
        Lua = {
          format = {
            enable = false,
          },
          -- runtime = {
          --   -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          --   version = 'LuaJIT',
          --   -- Setup your lua path
          --   path = runtime_path,
          -- },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { 'vim' },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file('', true),
            checkThirdParty = false,
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = { enable = false },
        },
      }
    end
    require('lspconfig')[server_name].setup(opts)
  end,
}

-- formatting.configure_format_on_save()
