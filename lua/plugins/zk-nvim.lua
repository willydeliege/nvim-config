local on_attach = require("plugins.nvim-lspconfig").on_attach
require("zk").setup({
	picker = "telescope",
	lsp = {
		auto_attach = {
			filetypes = { "markdown", "vimwiki" },
		},
		on_attach = on_attach,
	},
})
