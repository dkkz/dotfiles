if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin()

  Plug 'hrsh7th/vim-vsnip'
  Plug 'hrsh7th/vim-vsnip-integ'
  Plug 'rafamadriz/friendly-snippets'

if has ("nvim")
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'romgrk/barbar.nvim'
  Plug 'folke/todo-comments.nvim'
  Plug 'windwp/nvim-autopairs'
  Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'b3nj5m1n/kommentary'
  Plug 'hrsh7th/nvim-compe'
  Plug 'blackCauldron7/surround.nvim'
  Plug 'simrat39/symbols-outline.nvim'
  Plug 'mattn/emmet-vim'
  Plug 'mhinz/vim-startify'
  " LSP
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'kabouzeid/nvim-lspinstall'
  Plug 'folke/trouble.nvim'
  Plug 'ray-x/lsp_signature.nvim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'glepnir/lspsaga.nvim'
  Plug 'folke/lsp-colors.nvim'
  " git
  Plug 'TimUntersberger/neogit'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'f-person/git-blame.nvim'
  Plug 'sindrets/diffview.nvim'
  " Color
  Plug 'norcalli/nvim-colorizer.lua'
  Plug 'p00f/nvim-ts-rainbow'
  Plug 'rafamadriz/neon'
  Plug 'morhetz/gruvbox'
  Plug 'hoob3rt/lualine.nvim'
  " Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
  Plug 'dracula/vim', { 'as': 'dracula' }
endif

call plug#end()
