" Fundamentals "{{{
" ---------------------------------------------------------------------

" init autocmd
autocmd!
" set script encoding
scriptencoding utf-8
" stop loading config if it's on tiny or small
if !1 | finish | endif

set nocompatible
set number
syntax enable
set fileencodings=utf-8,sjis,euc-jp,latin
set encoding=utf-8
set title
set breakindent
set nobackup
set hlsearch
set showcmd
set cmdheight=1
set laststatus=2
set scrolloff=10
set expandtab
set noswapfile
set noundofile
set mouse=a
"let loaded_matchparen = 1
set shell=zsh
set backupskip=/tmp/*,/private/tmp/*

set textwidth=79
set colorcolumn=+1
set conceallevel=0
set t_Co=256
" Faster completion
set updatetime=300                      
" By default timeoutlen is 1000 ms
set timeoutlen=500                      

" incremental substitution (neovim)
if has('nvim')
  set inccommand=split
endif

" Suppress appending <PasteStart> and <PasteEnd> when pasting
set t_BE=

set nosc noru nosm
" Don't redraw while executing macros (good performance config)
set lazyredraw
"set showmatch
" How many tenths of a second to blink when matching brackets
"set mat=2
" Ignore case when searching
set ignorecase
" Be smart when using tabs ;)
set smarttab
" indents
filetype plugin indent on
set shiftwidth=2
set tabstop=2
set ai "Auto indent
set si "Smart indent
set nowrap "No Wrap lines
set backspace=start,eol,indent
" Finding files - Search down into subfolders
set path+=**
set wildignore+=*/node_modules/*

" Turn off paste mode when leaving insert
autocmd InsertLeave * set nopaste

" Add asterisks in block comments
set formatoptions+=r

" auto source when writing to init.vm alternatively you can run :source $MYVIMRC
au! BufWritePost $MYVIMRC source %      

"}}}

" Highlights "{{{
" ---------------------------------------------------------------------
set cursorline
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

"}}}

" File types "{{{
" ---------------------------------------------------------------------
" JavaScript
au BufNewFile,BufRead *.jsx setf javascriptreact
" TypeScript
au BufNewFile,BufRead *.tsx setf typescriptreact
" Markdown
au BufNewFile,BufRead *.md set filetype=markdown
" Flow
au BufNewFile,BufRead *.flow set filetype=javascript

set suffixesadd=.js,.es,.jsx,.json,.css,.less,.sass,.styl,.php,.py,.md

autocmd FileType ts setlocal shiftwidth=2 tabstop=2
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2

"}}}

" Imports "{{{
" ---------------------------------------------------------------------
runtime ./plug.vim
if has("unix")
  let s:uname = system("uname -s")
  " Do Mac stuff
  if s:uname == "Darwin\n"
    runtime ./macos.vim
  endif
endif

runtime ./maps.vim
"}}}

" Syntax theme "{{{
" ---------------------------------------------------------------------
let g:gruvbox_transparent_bg=1
" true color
if exists("&termguicolors") && exists("&winblend")
  syntax enable
  set termguicolors
  set winblend=30
  set wildoptions=pum
  set pumblend=30
  " Use NeoSolarized
  " let g:neosolarized_termtrans=1
  " runtime ./colors/NeoSolarized.vim
  " colorscheme dracula
  colorscheme gruvbox
  " colorscheme neon
  set background=dark
  " background transparent
  highlight Normal guibg=none
  highlight NonText guibg=none
endif
"}}}

" Set terminal "{{{
" ---------------------------------------------------------------------
" open new split panes to right and below
set splitright
set splitbelow
" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
  split term://zsh
  resize 15
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>
"}}}

" indent_blankline "{{{
" ---------------------------------------------------------------------
let g:indent_blankline_char="│"
highlight IndentBlanklineChar guifg=#5e5e5e gui=nocombine
"}}}

" emmet "{{{
" ---------------------------------------------------------------------
let g:user_emmet_expandabbr_key='<c-t>'
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

" Extras "{{{
" ---------------------------------------------------------------------
set exrc
"}}}

"vim: set foldmethod=marker foldlevel=0:

" Setup plugin "{{{
" ---------------------------------------------------------------------
lua << EOF
require('gitsigns').setup()
require('nvim-web-devicons').setup{}
require('surround').setup{}
require('todo-comments').setup{}
require('colorizer').setup()
EOF
"}}}
