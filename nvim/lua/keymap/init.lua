local bind = require 'keymap.bind'
local map_cr = bind.map_cr
local map_cu = bind.map_cu
-- local map_cmd = bind.map_cmd
require 'keymap.config'

local plug_map = {
  -- nvim-bufdel
  ['n|<A-q>'] = map_cr('BufDel'):with_noremap():with_silent(),
  -- Bufferline
  ['n|gb'] = map_cr('BufferLinePick'):with_noremap():with_silent(),
  ['n|<A-j>'] = map_cr('BufferLineCycleNext'):with_noremap():with_silent(),
  ['n|<A-k>'] = map_cr('BufferLineCyclePrev'):with_noremap():with_silent(),
  ['n|<A-S-j>'] = map_cr('BufferLineMoveNext'):with_noremap():with_silent(),
  ['n|<A-S-k>'] = map_cr('BufferLineMovePrev'):with_noremap():with_silent(),
  ['n|<leader>be'] = map_cr('BufferLineSortByExtension'):with_noremap(),
  ['n|<leader>bd'] = map_cr('BufferLineSortByDirectory'):with_noremap(),
  ['n|<A-1>'] = map_cr('BufferLineGoToBuffer 1'):with_noremap():with_silent(),
  ['n|<A-2>'] = map_cr('BufferLineGoToBuffer 2'):with_noremap():with_silent(),
  ['n|<A-3>'] = map_cr('BufferLineGoToBuffer 3'):with_noremap():with_silent(),
  ['n|<A-4>'] = map_cr('BufferLineGoToBuffer 4'):with_noremap():with_silent(),
  ['n|<A-5>'] = map_cr('BufferLineGoToBuffer 5'):with_noremap():with_silent(),
  ['n|<A-6>'] = map_cr('BufferLineGoToBuffer 6'):with_noremap():with_silent(),
  ['n|<A-7>'] = map_cr('BufferLineGoToBuffer 7'):with_noremap():with_silent(),
  ['n|<A-8>'] = map_cr('BufferLineGoToBuffer 8'):with_noremap():with_silent(),
  ['n|<A-9>'] = map_cr('BufferLineGoToBuffer 9'):with_noremap():with_silent(),
  -- Lazy.nvim
  ['n|<leader>ph'] = map_cr('Lazy'):with_silent():with_noremap():with_nowait(),
  ['n|<leader>ps'] = map_cr('Lazy sync'):with_silent():with_noremap():with_nowait(),
  ['n|<leader>pu'] = map_cr('Lazy update'):with_silent():with_noremap():with_nowait(),
  ['n|<leader>pi'] = map_cr('Lazy install'):with_silent():with_noremap():with_nowait(),
  ['n|<leader>pl'] = map_cr('Lazy log'):with_silent():with_noremap():with_nowait(),
  ['n|<leader>pc'] = map_cr('Lazy check'):with_silent():with_noremap():with_nowait(),
  ['n|<leader>pd'] = map_cr('Lazy debug'):with_silent():with_noremap():with_nowait(),
  ['n|<leader>pp'] = map_cr('Lazy profile'):with_silent():with_noremap():with_nowait(),
  ['n|<leader>pr'] = map_cr('Lazy restore'):with_silent():with_noremap():with_nowait(),
  ['n|<leader>px'] = map_cr('Lazy clean'):with_silent():with_noremap():with_nowait(),
  -- Lsp mapp work when insertenter and lsp start
  ['n|<leader>li'] = map_cr('LspInfo'):with_noremap():with_silent():with_nowait(),
  ['n|<leader>lr'] = map_cr('LspRestart'):with_noremap():with_silent():with_nowait(),
  ['n|go'] = map_cr('Lspsaga outline'):with_noremap():with_silent(),
  ['n|g['] = map_cr('Lspsaga diagnostic_jump_prev'):with_noremap():with_silent(),
  ['n|g]'] = map_cr('Lspsaga diagnostic_jump_next'):with_noremap():with_silent(),
  ['n|gs'] = map_cr('lua vim.lsp.buf.signature_help()'):with_noremap():with_silent(),
  ['n|gr'] = map_cr('Lspsaga rename'):with_noremap():with_silent(),
  ['n|K'] = map_cr('Lspsaga hover_doc'):with_noremap():with_silent(),
  ['n|ga'] = map_cr('Lspsaga code_action'):with_noremap():with_silent(),
  ['v|ga'] = map_cu('Lspsaga code_action'):with_noremap():with_silent(),
  ['n|gd'] = map_cr('Lspsaga peek_definition'):with_noremap():with_silent(),
  ['n|gD'] = map_cr('lua vim.lsp.buf.definition()'):with_noremap():with_silent(),
  ['n|gh'] = map_cr('Lspsaga lsp_finder'):with_noremap():with_silent(),
  ['n|gps'] = map_cr('G push'):with_noremap():with_silent(),
  ['n|gpl'] = map_cr('G pull'):with_noremap():with_silent(),
  -- Plugin Telescope
  ['n|<leader>u'] = map_cr("lua require('telescope').extensions.undo.undo()"):with_noremap():with_silent(),
  ['n|<leader>fp'] = map_cu("lua require('telescope').extensions.projects.projects{}"):with_noremap():with_silent(),
  ['n|<leader>fr'] = map_cu("lua require('telescope').extensions.frecency.frecency{}"):with_noremap():with_silent(),
  ['n|<leader>fw'] = map_cu("lua require('telescope').extensions.live_grep_args.live_grep_args{}"):with_noremap():with_silent(),
  ['n|<leader>fe'] = map_cu('Telescope oldfiles'):with_noremap():with_silent(),
  ['n|<leader>ff'] = map_cu('Telescope find_files'):with_noremap():with_silent(),
  ['n|<leader>fc'] = map_cu('Telescope colorscheme'):with_noremap():with_silent(),
  ['n|<leader>fb'] = map_cu('Telescope file_browser'):with_noremap():with_silent(),
  ['n|<leader>fn'] = map_cu(':enew'):with_noremap():with_silent(),
  ['n|<leader>fg'] = map_cu('Telescope git_files'):with_noremap():with_silent(),
  ['n|<leader><leader>'] = map_cu('Telescope buffers'):with_noremap():with_silent(),
  -- Plugin Diffview
  ['n|<leader>D'] = map_cr('DiffviewOpen'):with_silent():with_noremap(),
  ['n|<leader><leader>D'] = map_cr('DiffviewClose'):with_silent():with_noremap(),
}

bind.nvim_load_mapping(plug_map)
