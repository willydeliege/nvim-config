local whichkey = require("which-key")

whichkey.setup()

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}
local mappings = {
	s = {
		name = "Shell",
		g = { "<cmd>lua _lazygit_toggle()<CR>", "Lazygit" },
		t = { "<cmd>lua _taskwarrior_toggle()<CR>", "Taskwarrior TUI" },
		h = { "<cmd>ToggleTerm direction=horizontal<CR>", "Horizontal" },
		v = { "<cmd>ToggleTerm direction=vertical<CR>", "Vertical" },
		F = { "<cmd>ToggleTerm direction=float<CR>", "Float" },
	},
	j = { "<cmd>lua _journal_toggle()<CR>", "Journal" },
	-- c = { "<cmd>MkdnEnter<cr>", "Create/follow link" },
	e = { "<cmd>Neotree toggle<cr>", "Explorer" },
	f = {
		name = "Find",
		f = { "<cmd>lua require('telescope.builtin').find_files()<cr>", "Files" },
		b = { "<cmd>lua require('telescope.builtin').buffers()<cr>", "Buffers" },
		h = { "<cmd>lua require('telescope.builtin').help_tags()<cr>", "Help" },
		m = { "<cmd>lua require('telescope.builtin').marks()<cr>", "Marks" },
		o = { "<cmd>lua require('telescope.builtin').oldfiles()<cr>", "Old Files" },
		g = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "Live Grep" },
		c = { "<cmd>lua require('telescope.builtin').commands()<cr>", "Commands" },
		k = { "<cmd>lua require('telescope.builtin').keymaps()<cr>", "keymaps" },
		r = { "<cmd>lua require'telescope'.extensions.file_browser.file_browser()<cr>", "File Browser" },
		w = { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", "Current Buffer" },
		p = { "<cmd>Telescope projects<cr>", "Projects" },
	},
}
whichkey.register(mappings, opts)
