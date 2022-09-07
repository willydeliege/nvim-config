
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
-- ───────────────────────────────────────────────── --
--   Plugin:    vim-floaterm
--   Github:    github.com/voldikss/vim-floaterm
-- ───────────────────────────────────────────────── --
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --





-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
-- ━━━━━━━━━━━━━━━━━━━❰ Configs ❱━━━━━━━━━━━━━━━━━━━ --
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --

-- Set floating window border line color to cyan, and background to orange
vim.cmd("hi FloatermBorder guibg=none guifg=grey")
-- Set floaterm window's background to black
vim.cmd("hi Floaterm guibg=black")
-- Set floaterm window background to gray once the cursor moves out from it
vim.cmd("hi FloatermNC guibg=gray")

-- Show floaterm info(e.g., 'floaterm: 1/3' implies there are 3 floaterms in total
--   and the current is the first one) at the top left corner of floaterm window.
vim.g.floaterm_title = 'Terminal: $1/$2'

-- Set it to 'split' or 'vsplit' if you don't want to use floating or popup window.
vim.g.floaterm_wintype = 'float'
-- don't auto close terminal (useful when you try to compile/run code)
vim.g.floaterm_autoclose = 0

-- Type Number (number of columns) or Float (between 0 and 1). If Float, the width is relative to &columns.
vim.g.floaterm_width = 0.6
-- Type Number (number of lines) or Float (between 0 and 1). If Float, the height is relative to &lines.
vim.g.floaterm_height = 0.7

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
-- ━━━━━━━━━━━━━━━━━❰ end Configs ❱━━━━━━━━━━━━━━━━━ --
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --




-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
-- ━━━━━━━━━━━━━━━━━━❰ Mappings ❱━━━━━━━━━━━━━━━━━━━ --
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --


-- use this (global, g) if you want your keymap works on any view(normal, insert, ...)
vim.g.floaterm_keymap_toggle = '<C-t>' -- toggle open/close floaterm
-- vim.g.floaterm_keymap_prev = 'tk' -- go to previous floaterm window
-- vim.g.floaterm_keymap_next = 'tj' -- go to next floaterm window
-- vim.g.floaterm_keymap_new    = 'tn'         -- create new terminal
-- vim.g.floaterm_keymap_kill   = 'tq'         -- quit current terminal

-- -- go to previous floaterm window
-- keymap('n', 'tk', ':FloatermPrev<CR>', options)
-- -- go to next floaterm window
-- keymap('n', 'tj', ':FloatermNext<CR>', options)
-- -- create new floaterm window
-- keymap('n', 'tn', ':FloatermNew<CR>',  options)
-- -- exit floaterm window
-- keymap('n', 'tq', ':FloatermKill<CR>', options)


-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
-- ━━━━━━━━━━━━━━━❰ Build and Run ❱━━━━━━━━━━━━━━━━━ --

-- compile, run or compile and run program.
-- it depends on python script, https://github.com/shaeinst/lazy-builder. visit to know more.


-- local buffer_num      = vim.api.nvim_get_current_buf() -- current buffer
-- local filename_with_dir = vim.fn.expand('%:p')
-- local filename_dir= vim.fn.expand('%:p:h')


-- ━━━━━━━━━━━━━━━━❰ end Build/Run ❱━━━━━━━━━━━━━━━━ --
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --


-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
-- ━━━━━━━━━━━━━━━━❰ end Mappings ❱━━━━━━━━━━━━━━━━━ --
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --

