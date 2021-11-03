"plug vim
set nocompatible
call plug#begin('~/.vim/plugged')
  " Tools
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'
  Plug 'Yggdroot/indentLine'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'jremmen/vim-ripgrep'
  Plug 'jiangmiao/auto-pairs'
  Plug 'preservim/nerdtree'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'ryanoasis/vim-devicons'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'honza/vim-snippets'
  Plug 'SirVer/ultisnips'
  " git
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  " JavaScript
  Plug 'pangloss/vim-javascript'
  Plug 'leafgarland/typescript-vim'
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
  " Plug 'mlaursen/vim-react-snippets'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  " HTML
  Plug 'othree/html5.vim'
  Plug 'mattn/emmet-vim'
  " Colors
  Plug 'bling/vim-airline'
  Plug 'junegunn/rainbow_parentheses.vim'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'norcalli/nvim-colorizer.lua'
  " Theme
  Plug 'dracula/vim', { 'as': 'dracula' }
  Plug 'whatyouhide/vim-gotham'
  Plug 'ghifarit53/tokyonight-vim'
  Plug 'morhetz/gruvbox'
  Plug 'joshdick/onedark.vim'
  Plug 'ayu-theme/ayu-vim'
call plug#end()

filetype plugin indent on

let mapleader = "\<Space>"

"rainbow_parentheses
augroup rainbow_lisp
  autocmd!
  autocmd FileType lisp,typescript,go,javascript,scheme RainbowParentheses
augroup END

let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

"vim-tmux-navigator
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> {Left-Mapping} :TmuxNavigateLeft<cr>
nnoremap <silent> {Down-Mapping} :TmuxNavigateDown<cr>
nnoremap <silent> {Up-Mapping} :TmuxNavigateUp<cr>
nnoremap <silent> {Right-Mapping} :TmuxNavigateRight<cr>
nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>

"Airline
set laststatus=2
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

set guifont=Hack\ Bold\ Nerd\ Font\ Complete:h12
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 1
" let g:airline_theme = "gruvbox"
let g:airline_theme = "gotham"
" let g:airline_theme = "ayu"

"editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

"Coc 
set hidden
set nobackup
set nowritebackup
set updatetime=300
set redrawtime=10000

let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-css',
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-stylelint',
  \ 'coc-json',
  \ ]

"" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

"" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

"" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

"" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

"" Applying codeAction to the selected region.
"" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

"" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
"" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

"" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

"" Map function and class text objects
"" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

"" Use CTRL-S for selections ranges.
"" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

"" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

"" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

"" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

"" Add (Neo)Vim's native statusline support.
"" NOTE: Please see `:h coc-status` for integrations with external plugins that
"" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

"" Mappings for CoCList
"" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
"" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
"" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
"" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
"" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
"" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
"" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
"" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

"" coc-go
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'


" JavaScript
let g:javascript_plugin_jsdoc = 1

"JSX
" autocmd BufNewFile,BufRead *.tsx let b:tsx_ext_found = 1
" autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx

autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear


" Vim-fugitive
autocmd QuickFixCmdPost *grep* cwindow

" Emmet trigger
let g:user_emmet_expandabbr_key='<c-t>'

" NERD tree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

let g:NERDTreeHighlightFolders = 1 
let g:NERDTreeHighlightFoldersFullName = 1  

let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeLimitedSyntax = 1
let g:NERDTreeIgnore = ['^node_modules$']

" vim-devicons
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:webdevicons_enable_airline_statusline = 1

let g:WebDevIconsNerdTreeBeforeGlyphPadding = ""
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
if exists('g:loaded_webdevicons')
  call webdevicons#refresh()
endif

" fzf settings
let $FZF_DEFAULT_OPTS="--layout=reverse"
let $FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git/**'"
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'border': 'sharp' } }

" fzf
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>g :GFiles<CR>
nnoremap <silent> <leader>G :GFiles?<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>h :History<CR>
nnoremap <silent> <leader>r :Rg<CR>

"Yggdroot/indentLine
let g:indentLine_color_term = 218
" autocmd Filetype json let g:indentLine_setConceal = 0

" Jenkinsfile
au BufNewFile,BufRead Jenkinsfile setf groovy

syntax on

"dracula theme
let g:dracula_colorterm = 0
let g:dracula_italic = 0

if (has('termguicolors'))
  set termguicolors
endif

let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_disable_italic_comment = 1


" colorscheme tokyonight
colorscheme gruvbox
" colorscheme gotham
" colorscheme OceanicNext
" let ayucolor="mirage"
" colorscheme ayu
" colorscheme dracula
set background=dark

" background transparent
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE

"Setting Vim
" set textwidth=79
" set colorcolumn=+1
" let g:vim_json_conceal=0
" set conceallevel=0
" highlight ColorColumn guibg=#dc143c ctermbg=red
" highlight ColorColumn guibg=#202020 ctermbg=lightgray
" set ambiwidth=double
set ambiwidth=single
set fileencodings=utf-8,cp932,euc-jp,sjis
set encoding=utf8
set completeopt=menu,preview
"Use mouse
set mouse=a
"set spell spelllang=en_us
"Spell check
set expandtab
set title
set shiftwidth=2
set wrapmargin=10
set tabstop=2
set softtabstop=2
set backspace=indent,eol,start
set laststatus=2
"Repeat Searching
set wrapscan
"Highlight search result
set hlsearch
"Search increment
set incsearch
set ignorecase
"If sentence have wide more than windows, show the next line
set wrap
"Show number status line(right bottom)
set ruler
"Set line number
set number
"Highlight match parentheses
set showmatch
set matchtime=1
set smarttab
set smartcase
"set paste
set autoindent
"beautiful new line
set breakindent
set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m,%f
set grepprg=grep\ -nh
"for xterm, screen
set ttymouse=xterm2

"for slow scroll change regex engine
set regexpengine=1

"if() indent
set cindent
"command-line completion like zsh
set wildmenu
set wildmode=list:full
"Disable beep and flash
set noeb vb t_vb=
set history=1000

"Do not add end of sentence \n
set nofixeol

"no swp file
set noswapfile

"Auto change directory
" set autochdir

"set path
set path+=**

"increment alphabet
set nrformats+=alpha

"Move to new cursor
noremap <C-i> <C-i>

"shortcut for buffer moving
nnoremap <silent> <C-j> :bprev<CR>
nnoremap <silent> <C-k> :bnext<CR>

"Clear highlight of search
nnoremap <ESC><ESC> :nohlsearch<CR>

" Split window
nmap ss :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w

" newtrw
let g:netrw_preview=1
