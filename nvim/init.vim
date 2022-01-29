" ---------------------------------------------------------------------
" init autocmd
autocmd!
" set script encoding
scriptencoding utf-8

syntax enable
set nocompatible
set fileencodings=utf-8,sjis,euc-jp
set encoding=utf-8
set title
set nu
set breakindent
set nobackup
set showcmd
set cmdheight=1
set scrolloff=10
set expandtab
set noswapfile
set noundofile
set mouse=a
set shell=zsh
set backupskip=/tmp/*,/private/tmp/*
set lazyredraw
set relativenumber
set inccommand=nosplit
set modifiable
set write
set smarttab

" set textwidth=79
" set colorcolumn=+1
" set conceallevel=0
set t_Co=256
" Faster completion
set updatetime=300
" By default timeoutlen is 1000 ms
set timeoutlen=500
set exrc
" open new split panes to right and below
set splitright
set splitbelow
" Description: macOS-specific configs
" Use OSX clipboard to copy and to paste
set clipboard+=unnamedplus

" Suppress appending <PasteStart> and <PasteEnd> when pasting
set t_BE=

set nosc noru nosm
" Don't redraw while executing macros (good performance config)
set lazyredraw
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2
" Ignore case when searching
set ignorecase
" Be smart when using tabs ;)
set smartcase
" indents
filetype plugin indent on
set shiftwidth=2
set tabstop=2
set si "Smart indent
set nowrap "No Wrap lines
" set backspace=start,eol,indent
" Finding files - Search down into subfolders
set path+=**
set wildignore+=*/node_modules/*

" Turn off paste mode when leaving insert
autocmd InsertLeave * set nopaste

" Add asterisks in block comments
set formatoptions+=r

set completeopt=menuone,noinsert,noselect
set shortmess+=c
highlight link CompeDocumentation NormalFloat

" auto source when writing to init.vm alternatively you can run :source $MYVIMRC
au! BufWritePost $MYVIMRC source %

"}}}

" Highlights "{{{
" ---------------------------------------------------------------------
" set cursorline
"set cursorcolumn

" Set cursor line color on visual mode
highlight Visual cterm=NONE ctermbg=236 ctermfg=NONE guibg=Grey40
highlight LineNr cterm=none ctermfg=240 guifg=#2b506e guibg=#000000

augroup BgHighlight
  autocmd!
  autocmd WinEnter * set cul
  autocmd WinLeave * set nocul
augroup END

if &term =~ "screen"
  autocmd BufEnter * if bufname("") !~ "^?[A-Za-z0-9?]*://" | silent! exe '!echo -n "\ek[`hostname`:`basename $PWD`/`basename %`]\e\\"' | endif
  autocmd VimLeave * silent!  exe '!echo -n "\ek[`hostname`:`basename $PWD`]\e\\"'
endif

"au BufNewFile,BufRead *.jenkinsfile,*.Jenkinsfile,Jenkinsfile,jenkinsfile setf groovy
"}}}


" File types "{{{
" JavaScript
au BufNewFile,BufRead *.jsx setf javascriptreact
" TypeScript
au BufNewFile,BufRead *.tsx setf typescriptreact
" Markdown
au BufNewFile,BufRead *.md set filetype=markdown
" Flow
au BufNewFile,BufRead *.flow set filetype=javascript

set suffixesadd=.js,.es,.jsx,.json,.css,.scss.sass,.styl,.php,.py,.md
"}}}

if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin()

  Plug 'rafamadriz/friendly-snippets'

if has ("nvim")
endif

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'
Plug 'folke/todo-comments.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'numToStr/Comment.nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-emoji'
Plug 'ray-x/cmp-treesitter'
Plug 'github/copilot.vim'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'onsails/lspkind-nvim'
Plug 'tpope/vim-surround'
Plug 'simrat39/symbols-outline.nvim'
Plug 'mattn/emmet-vim'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'editorconfig/editorconfig-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'nvim-telescope/telescope-ghq.nvim'

" LSP
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'williamboman/nvim-lsp-installer'
Plug 'folke/trouble.nvim'
Plug 'ray-x/lsp_signature.nvim'
Plug 'neovim/nvim-lspconfig'
" Plug 'glepnir/lspsaga.nvim'
Plug 'tami5/lspsaga.nvim'
Plug 'folke/lsp-colors.nvim'
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'Pocco81/DAPInstall.nvim'
Plug 'theHamsta/nvim-dap-virtual-text'
" git
Plug 'lewis6991/gitsigns.nvim'
Plug 'f-person/git-blame.nvim'
Plug 'tpope/vim-fugitive'
" Color
Plug 'norcalli/nvim-colorizer.lua'
Plug 'p00f/nvim-ts-rainbow'
Plug 'morhetz/gruvbox'
Plug 'hoob3rt/lualine.nvim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'maxmellon/vim-jsx-pretty'
Plug 'martinda/Jenkinsfile-vim-syntax'

call plug#end()

" Syntax theme "{{{
" ---------------------------------------------------------------------
let g:gruvbox_transparent_bg=1
" true color
if exists("&termguicolors") && exists("&winblend")
  set termguicolors
  set winblend=30
  set pumblend=30
  " colorscheme dracula
  colorscheme gruvbox
  " background transparent
  autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
  " highlight Normal guibg=none
  " highlight NonText guibg=none
endif
"}}}

" indent_blankline "{{{
" ---------------------------------------------------------------------
let g:indent_blankline_char = '|'
lua << EOF
vim.opt.termguicolors = true
vim.opt.list = true

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
  }
EOF
"}}}

" emmet "{{{
" ---------------------------------------------------------------------
let g:user_emmet_expandabbr_key='<c-t>'
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
"}}}


" FixCursorHold.nvim {{{
" ---------------------------------------------------------------------
let g:cursorhold_updatetime = 100
"}}}

" Comment {{{
" ---------------------------------------------------------------------
lua require('Comment').setup()
"}}}

" dad bod SQL {{{
nnoremap <silent> <leader>bu :DBUIToggle<CR>
nnoremap <silent> <leader>bf :DBUIFindBuffer<CR>
nnoremap <silent> <leader>br :DBUIRenameBuffer<CR>
nnoremap <silent> <leader>bl :DBUILastQueryInfo<CR>
let g:db_ui_save_location = '~/.config/db_ui'
"}}}

" symbols-outline "{{{
" ---------------------------------------------------------------------
lua << EOF
  vim.g.symbols_outline = {
      highlight_hovered_item = true,
      show_guides = true,
      auto_preview = false, -- experimental
      position = 'right',
      keymaps = {
          close = "<Esc>",
          goto_location = "<Cr>",
          focus_location = "o",
          hover_symbol = "<C-space>",
          rename_symbol = "r",
          code_actions = "a"
      },
      lsp_blacklist = {}
  }
EOF
"}}}

" barbar "{{{
" ---------------------------------------------------------------------
" Move to previous/next
nnoremap <silent> <A-,> :BufferPrevious<CR>
nnoremap <silent> <A-.> :BufferNext<CR>
" Re-order to previous/next
nnoremap <silent> <A-<> :BufferMovePrevious<CR>
nnoremap <silent> <A->> :BufferMoveNext<CR>
" Pin/unpin buffer
nnoremap <silent> <A-p> :BufferPin<CR>
" Close buffer
nnoremap <silent> <A-c> :BufferClose<CR>
"}}}

"vim: set foldmethod=marker foldlevel=0:

" Setup plugin "{{{
" ---------------------------------------------------------------------
lua << EOF
require('gitsigns').setup{}
require('nvim-web-devicons').setup{}
require('todo-comments').setup{}
require('colorizer').setup()
EOF
"}}}
"

"Clear highlight of search
nnoremap <ESC><ESC> :nohlsearch<CR>

" leader key
let mapleader = "\<Space>"

" Description: Keymaps

nnoremap <S-C-p> "0p
" Delete without yank
nnoremap <leader>d "_d
nnoremap x "_x

" Delete a word backwards
nnoremap dw vb"_d

" Save with root permission
command! W w !sudo tee > /dev/null %

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

"------------------------------
" Windows

" Split window
nmap sp :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w
" Move window
nmap <Space> <C-w>w
map sh <C-w>h
map sk <C-w>k
map sj <C-w>j
map sl <C-w>l
" Resize window
nmap <C-w><left> <C-w><
nmap <C-w><right> <C-w>>
nmap <C-w><up> <C-w>+
nmap <C-w><down> <C-w>-


lua << EOF
require('nvim-autopairs').setup()
EOF

lua << EOF
-- vim.lsp.set_log_level("debug")
local nvim_lsp = require('lspconfig')
local protocol = require('vim.lsp.protocol')

-- Use an on_attach function to only map the following keys 
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)

  -- require('lsp_signature').on_attach(client)
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
  -- buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
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

end

-- config that activates keymaps and enables snippet support
local function make_config()
  --Enable completion
  -- local capabilities = protocol.make_client_capabilities()
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown', 'plaintext' }
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.preselectSupport = true
  capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
  capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
  capabilities.textDocument.completion.completionItem.deprecatedSupport = true
  capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
  capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    },
  }

  return {
    capabilities = capabilities,
    on_attach = on_attach,
  }
end


local function diag(server,config)

    -- if server == "yamlls" then
    --   config.settings = {
    --     yaml = {
    --       schemas = { kubernetes = "globPattern" },
    --       }
    --     }
    -- end

    if server == "intelephense" then
      config.settings = {
        intelephense = {
          format = {
            enable = false
            }
        }
      }
    end


    if server == "diagnosticls" then

      config.filetypes = { 'sh','javascript', 'javascriptreact', 'javascript.jsx', 'json', 'typescript', 'typescriptreact', 'typescript.tsx', 'css', 'scss', 'markdown' };
      config.init_options = {
          linters = {
            shellcheck = {
              command = "shellcheck",
              debounce = 100,
              args = {"--format", "json", "-"},
              sourceName = "shellcheck",
              parseJson = {
                line = "line",
                column = "column",
              endLine = "endLine",
            endColumn = "endColumn",
            message = "${message} [${code}]",
            security = "level"
            },
          securities = {
            error = "error",
            warning = "warning",
            info = "info",
            style = "hint"
            }
          },
          eslint = {
            command = 'eslint_d',
            rootPatterns = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
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
          sh = 'shellcheck',
        },
        formatters = {
          eslint_d = {
            command = 'eslint_d',
            args = { '--stdin', '--stdin-filename', '%filename', '--fix-to-stdout' },
            rootPatterns = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
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
          typescriptreact = 'eslint_d',
          typescriptreact = 'prettier',
          json = 'prettier',
          markdown = 'prettier',
        }
      };
    end
end

do
  local method = "textDocument/publishDiagnostics"
  local default_handler = vim.lsp.handlers[method]
  vim.lsp.handlers[method] = function(err, method, result, client_id, bufnr,config)
      default_handler(err, method, result, client_id, bufnr, config)
      local diagnostics = vim.diagnostic.get()
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
      -- vim.lsp.util.set_qflist(qflist)
      --vim.diagnostic.setqflist(qflist)
      --vim.diagnostic.setloclist(qflist)
  end
end

-- lsp_installer
local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
    local opts = {}
    local config = make_config()
    diag(server, config)
    server:setup(config)
    -- server:setup(opts)
end)

EOF

lua << EOF
require "lsp_signature".setup({
  bind = true,
  handler_opts = {
    border = "single"
  }
})
EOF

lua << EOF
-- nvim dap
local dap_install = require("dap-install")

dap_install.config("php", {
  configurations = {
    {
      type = 'php',
      request = 'launch',
      name = 'Listen for Xdebug',
      port = 10001,
      log = true,
      -- serverSourceRoot = '/var/www/html/',
      -- localSourceRoot = '/Users/ts-dongkyu.kim/Projects/corp-172/htdocs/',
    }
  }
})

require("dapui").setup()
require("nvim-dap-virtual-text").setup()

EOF

nnoremap <leader>dn :lua require"dap".continue()<CR>
nnoremap <leader>dc :lua require"dap".close()<CR>
nnoremap <leader>dv :lua require"dap".step_over()<CR>
nnoremap <leader>di :lua require"dap".step_into()<CR>
nnoremap <leader>do :lua require"dap".step_out()<CR>
nnoremap <leader>dt :lua require"dap".toggle_breakpoint()<CR>
nnoremap <leader>dp :lua require"dap.ui.variables".scopes()<CR>
nnoremap <leader>dh :lua require"dap.ui.variables".hover()<CR>
nnoremap <leader>du :lua require"dap.ui.variables".visual_hover()<CR>
nnoremap <leader>dw :lua require"dap.ui.widgets".hover()<CR>
nnoremap <leader>df :lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>
nnoremap <leader>ds :lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>
nnoremap <leader>dm :lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>
nnoremap <leader>dr :lua require"dap".repl.open()<CR>
nnoremap <leader>dl :lua require"dap".repl.run_last()<CR>

nnoremap <leader>dp :lua require('dapui').toggle()<CR>

lua << EOF
local saga = require 'lspsaga'

saga.init_lsp_saga {
  -- error_sign = '‚úò',
  error_sign = 'ÔÜà',
  warn_sign = 'ÔÅ±',
  hint_sign = 'Ô†µ',
  infor_sign = 'Ôëâ',
  border_style = "round",
}
EOF

nnoremap <silent> <C-j> :Lspsaga diagnostic_jump_next<CR>
nnoremap <silent> <C-k> :Lspsaga diagnostic_jump_prev<CR>
nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
vnoremap <silent><leader>ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>
nnoremap <silent> gs <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>
nnoremap <silent>gh :Lspsaga lsp_finder<CR>
nnoremap <silent> pd <cmd>lua require'lspsaga.provider'.preview_definition()<CR>
nnoremap <silent>gr <cmd>lua require('lspsaga.rename').rename()<CR>
nnoremap <silent><leader>cd :Lspsaga show_line_diagnostics<CR>
nnoremap <silent><leader>ca :Lspsaga code_action<CR>
vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>

lua << EOF
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
  },
sections = {
  lualine_c = {
    {
        'filename',
        path = 2,            -- 0 = just filename, 1 = relative path, 2 = absolute path
    }
    }
  }
}
EOF

lua << EOF
local actions = require('telescope.actions')
-- Global remapping
------------------------------
require('telescope').setup{
  defaults = {
    prompt_prefix = "$ ",
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
  }
}
require('telescope').load_extension('fzf')
require'telescope'.load_extension('ghq')
EOF
" telescope keymap
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fi <cmd>lua require('telescope.builtin').command_history()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

lua <<EOF
require'nvim-treesitter.configs'.setup {

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
    -- disable = {"dockerfile"},
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

lua <<EOF
local luasnip = require 'luasnip'
local cmp = require "cmp"

require "cmp_nvim_lsp"
require "cmp_buffer"
require "cmp_nvim_lsp"
require "cmp_emoji"

cmp.setup {
  snippet = {
    expand = function(args)
    require('luasnip').lsp_expand(args.body)
  end
  },

  formatting = {
      format = function(entry, vim_item)
        -- fancy icons and a name of kind
        vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind

        -- set a name for each source
        vim_item.menu = ({
          buffer = "[Buffer]",
          path = "[Path]",
          nvim_lsp = "[LSP]",
          emoji = "[Emoji]",
        })[entry.source.name]

        return vim_item
      end,
    },

  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
      else
        fallback()
      end
    end,
  },

  documentation = {
    border = { "‚ï≠", "‚îÄ", "‚ïÆ", "‚îÇ", "‚ïØ", "‚îÄ", "‚ï∞", "‚îÇ" },
  },

  sources = {
    { name = 'luasnip' },
    { name = "nvim_lsp" },
    { name = "buffer", keysword_length = 5 },
    { name = "path" },
    { name = "emoji" },
    { name = 'treesitter' },
  },
}
EOF


imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'

lua <<EOF
local ls = require("luasnip")
require("luasnip/loaders/from_vscode").lazy_load({ paths = { "~/.local/share/nvim/plugged/friendly-snippets" } })
EOF

lua << EOF
  require("trouble").setup {
    auto_open = true,
    auto_close = true,
    }
  local signs = {
    Error = "ÔÜà",
    Warning = "ÔÅ±",
    Hint = "Ô†µ",
    Information = "Ôëâ"
  }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
  end
EOF
