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
	t = {
		name = "TaskWiki",
		b = { name = "Burndow" },
		h = { name = "History" },
		g = { name = "GHistory" }

	},
	z = {
		name = "Zettelkasten",
		l = { "<cmd>ZkLinks<cr>", "Links"},
		b = { "<cmd>ZkBacklinks<cr>", "BackLink" },
		n = { "<cmd>ZkNotes<cr>", "Search notes" }

	},
}
whichkey.register(mappings, opts)
