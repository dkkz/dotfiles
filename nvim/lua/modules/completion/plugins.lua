local completion = {}
local conf = require 'modules.completion.config'

completion['neovim/nvim-lspconfig'] = {
  lazy = true,
  event = { 'BufReadPost', 'BufAdd', 'BufNewFile' },
  config = conf.nvim_lsp,
  dependencies = {
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'glepnir/lspsaga.nvim', config = conf.lspsaga },
    { 'ray-x/lsp_signature.nvim' },
  },
}

completion['hrsh7th/nvim-cmp'] = {
  lazy = true,
  config = conf.cmp,
  event = 'InsertEnter',
  dependencies = {
    { 'L3MON4D3/LuaSnip', config = conf.luasnip, dependencies = { 'rafamadriz/friendly-snippets' } },
    { 'onsails/lspkind.nvim', module = 'lspkind' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-vsnip' },
    { 'hrsh7th/vim-vsnip' },
    { 'hrsh7th/cmp-nvim-lsp-signature-help' },
  },
}

completion['windwp/nvim-autopairs'] = {
  lazy = true,
  event = 'InsertCharPre',
  config = conf.autopairs,
}

completion['jose-elias-alvarez/typescript.nvim'] = {
  lazy = true,
  ft = {
    'typescript',
    'javascript',
    'typescriptreact',
    'javascriptreact',
  },
  config = conf.typescript,
}

return completion
