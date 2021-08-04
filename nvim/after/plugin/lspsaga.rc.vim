if !exists('g:loaded_lspsaga') | finish | endif

lua << EOF
local saga = require 'lspsaga'

saga.init_lsp_saga {
  -- error_sign = '✘',
  error_sign = '',
  warn_sign = '',
  hint_sign = '',
  infor_sign = '',
  border_style = "round",
}

EOF

nnoremap <silent> <C-j> :Lspsaga diagnostic_jump_next<CR>
nnoremap <silent> <C-k> :Lspsaga diagnostic_jump_prev<CR>
nnoremap <silent>K <Cmd>Lspsaga hover_doc<CR>
nnoremap <silent>gs <Cmd> :Lspsaga signature_help<CR>
nnoremap <silent>gh <Cmd> :Lspsaga lsp_finder<CR>
nnoremap <silent>rn :Lspsaga rename<CR>
nnoremap <silent>ca :Lspsaga code_action<CR>
vnoremap <silent>ca :<C-U>Lspsaga range_code_action<CR>
