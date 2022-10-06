local whichkey = require("which-key")
vim.cmd[[highlight htmlH4 guifg=#8be9fd gui=bold]]
whichkey.setup()

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}
local v_opts = {
	mode = "v", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}
local mappings = {
	t = {
		name = "TaskWiki",
		b = { name = "Burndow" },
		h = { name = "History" },
		G = { name = "GHistory" },
		c = { name = "Choose" }

	},
	z = {
		name = "Zettelkasten",
		l = { "<cmd>ZkLinks<cr>", "Links"},
		b = { "<cmd>ZkBacklinks<cr>", "BackLink" },
		N = { "<cmd>ZkNotes<cr>", "List notes" },
		d = {
			name = "Diary",
			d = { "<cmd>ZkNew { dir = 'diary' }<cr>","Today"},
			y = { "<cmd>ZkNew { dir = 'diary', date='yesterday' }<cr>","Yesterday"},
			t = { "<cmd>ZkNew { dir = 'diary', date='tomorrow' }<cr>","Tomorrow"},
		}
	},
}
local v_mappings = {
	z = {
		name = "Zettelkasten",
		t = { ":'<,'>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') }<CR>", "New note from title" },
		c = { ":'<,'>ZkNewFromContentSelection { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", "New note from selection" }
	}
}
whichkey.register(mappings, opts)
whichkey.register(v_mappings,v_opts)
