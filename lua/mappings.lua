-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
-- ━━━━━━━━━━━━━❰ Plugin-Independent Mapping ❱━━━━━━━━━━━━━ --
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
--[===[
        this config file contains the mapping that don't depends
        on any plugin. mappings for plugins-dependent are in
        lua/plugin" directory. each plugin has it's own config file

        To see the current mapping for |<Leader>| type :echo mapleader.
        If it reports an undefined variable it means the leader key is
        set to the "default of '\'.
        i defined leader on very start of init.lua file so that every
        keymap would work
--]===]


local keymap    = vim.api.nvim_set_keymap
local cmd       = vim.cmd
local options   = { noremap = true, silent = true }
local silent    = { silent = true }
local remove_km = vim.api.nvim_del_keymap

-- TODO: fiqure out to implement <leader>q to quit only one buffer or one window at a time
-- Close buffer
-- cmd([[ autocmd BufEnter * nmap <silent> <buffer> <leader>q :bd<CR> ]])

vim.api.nvim_create_autocmd(
	"FileType",
	{
		pattern = {
			"man", "help", "lspinfo", "null-ls-info", "lsp-installer"
		},
		command = "nnoremap <silent> <buffer> <leader>q :close<CR>",
	}
)
-- map ctl+z to nothing so that it don't suspend terminal
vim.api.nvim_create_autocmd(
	"BufEnter",
	{
		pattern = "*",
		command = "nnoremap <c-z> <nop>"
	}
)
-- assign jk so that it's easier in --noplugin mode
keymap("n","jk","<ESC>",options)
-- close window
keymap('n', '<C-q>', '<C-w>q', options)
-- to save file
keymap('i', '<C-s>', '<ESC>ma<ESC>:w <CR>`a', options)
keymap('n', '<C-s>', '<ESC>ma<ESC>:w <CR>`a', options)

-- scroll window up/down
keymap('i', '<C-e>', '<ESC><C-e>', silent)
keymap('i', '<C-y>', '<ESC><C-y>', silent)

-- switch to window
keymap('n', '<C-h>', '<C-w>h', silent) -- left
keymap('n', '<C-l>', '<C-w>l', silent) -- right
keymap('n', '<C-j>', '<C-w>j', silent) -- botton
keymap('n', '<C-k>', '<C-w>k', silent) -- top


-- clear Search Results
keymap('n', '??', ':noh <CR>', silent)

--			Resize splits more quickly
-- ────────────────────────────────────────────────────
-- resize up and down
keymap('n', '<A-up>', ':resize +3 <CR>', options)
keymap('n', '<A-down>', ':resize -3 <CR>', options)
-- resize right and left
keymap('n', '<A-left>', ':vertical resize +3 <CR>', options)
keymap('n', '<A-right>', ':vertical resize -3 <CR>', options)
-- ────────────────────────────────────────────────────

--[[
      easier moving of code blocks
      Try to go into visual mode (v), thenselect several lines of code
      here and then press ``>`` several times.
--]]
keymap('v', '<', '<gv', options)
keymap('v', '>', '>gv', options)

-- going back to normal mode which works even in vim's terminal
-- you will need this if you use floaterm to escape terminal
keymap('t', '<Esc>', '<c-\\><c-n>', options)

-- move selected line(s) up or down
keymap('v', 'J', ":m '>+1<CR>gv=gv", options)
keymap('v', 'K', ":m '<-2<CR>gv=gv", options)

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
-- ━━━━━━━━━━━━━━━❰ end of Plugin Mapping ❱━━━━━━━━━━━━━━━━ --
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
