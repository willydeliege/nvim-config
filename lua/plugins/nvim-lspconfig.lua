-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
-- ───────────────────────────────────────────────── --
--   Plugin:    nvim-lspconfig
--   Github:    github.com/neovim/nvim-lspconfig
-- ───────────────────────────────────────────────── --
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --





-- ───────────────────────────────────────────────── --
local lspconfig_imported, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_imported then return end

local imported_mason, mason = pcall(require, 'mason')
if not imported_mason then return end

local lsp = vim.lsp
local api = vim.api
local handlers = lsp.handlers
-- ───────────────────────────────────────────────── --


local M = {}

M.capabilities = lsp.protocol.make_client_capabilities()
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
-- ━━━━━━━━━━━━━━━━━━━❰ Mappings ❱━━━━━━━━━━━━━━━━━━ --
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
local function set_lspkeymap()

	local status_ok, which_key = pcall(require, "which-key")
	if not status_ok then
		return
	end

	local opts = {
		mode = "n", -- NORMAL mode
		prefix = "<leader>",
		buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
		silent = true, -- use `silent` when creating keymaps
		noremap = true, -- use `noremap` when creating keymaps
		nowait = true, -- use `nowait` when creating keymaps
	}

	local vopts = {
		mode = "v", -- VISUAL mode
		prefix = "<leader>",
		buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
		silent = true, -- use `silent` when creating keymaps
		noremap = true, -- use `noremap` when creating keymaps
		nowait = true, -- use `nowait` when creating keymaps
	}

	local mappings = {
		l = {
			name = "LSP",
			e = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Open diagnostics" },
			d = { "<Cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
			D = { "<Cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
			f = { "<cmd>lua vim.lsp.buf.format {async = true}<CR>", "Format" },
			r = { "<cmd>Telescope lsp_references<CR>", "Reference" },
			F = { "<cmd>Lspsaga lsp_finder<cr>", "Finder (saga)" },
			h = { "<Cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
			a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
			t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Type definition" },
			i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation" },
			s = { "<cmd>AerialToggle<cr>", "Symbols" },
			n = { "<cmd>Lspsaga diagnostic_jump_next<cr>", "Next diagnostic" },
			p = { "<cmd>Lspsaga diagnostic_jump_prev<cr>", "Previous diagnostic" },
		}
	}
	local vmappings = {
		l = {
			name = "LSP",
			a = { "<cmd>Lspsaga code_action<cr>", "Code Action" },
			f = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format selection" },


		},
	}

	which_key.register(mappings, opts)
	which_key.register(vmappings, vopts)
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
-- ───────────────────────────────────────────────── --
M.on_attach = function(client, bufnr)

	local caps = client.server_capabilities
	caps.documentFormattingProvider = true
	caps.documentRangeFormattingProvider = true

	-- Enable completion triggered by <c-x><c-o>

	if client.name == "jdtls" then
		vim.notify("jdt.ls")
		require("jdtls").setup_dap { hotcodereplace = "auto" }
		require("jdtls.dap").setup_dap_main_class_configs()
		vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
			pattern = { "*.java", },
			command = "lua vim.lsp.codelens.refresh()",
		})
	end
	if caps.semanticTokensProvider and caps.semanticTokensProvider.full then
		local augroup = vim.api.nvim_create_augroup("SemanticTokens", {})
		vim.api.nvim_create_autocmd("TextChanged", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.semantic_tokens_full()
			end,
		})
		-- fire it first time on load as well
		vim.lsp.buf.semantic_tokens_full()
	end
	set_lspkeymap()
end
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
-- ━━━━━━━━━━━━━━━━━❰ end Mappings ❱━━━━━━━━━━━━━━━━ --
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --




-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
-- ━━━━━━━━━━━━━━━━━━━❰ configs ❱━━━━━━━━━━━━━━━━━━━ --
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --

M.setup_lsp_config = function()

	-- options for lsp diagnostic
	-- ───────────────────────────────────────────────── --
	vim.diagnostic.config({
		float = {
			border = "rounded",
			focusable = true,
			style = "minimal",
			source = "always",
			header = "",
			prefix = "",
		},
	})

	handlers["textDocument/publishDiagnostics"] = lsp.with(
		lsp.diagnostic.on_publish_diagnostics,
		{
			underline = true,
			signs = true,
			update_in_insert = true,
			virtual_text = {
				true,
				spacing = 6,
			},
		}
	)

	handlers["textDocument/hover"] = lsp.with(handlers.hover, { border = "rounded" })
	handlers["textDocument/signatureHelp"] = lsp.with(handlers.signature_help, { border = "rounded" })

	-- show diagnostic on float window(like auto complete)
	-- vim.api.nvim_command [[ autocmd CursorHold  *.lua,*.sh,*.bash,*.dart,*.py,*.cpp,*.c,js lua vim.lsp.diagnostic.show_line_diagnostics() ]]

	-- set LSP diagnostic symbols/signs
	-- ─────────────────────────────────────────────────--
	api.nvim_command [[ sign define DiagnosticSignError text=E texthl=DiagnosticSignError linehl= numhl= ]]
	api.nvim_command [[ sign define DiagnosticSignWarn  text=W texthl=DiagnosticSignWarn  linehl= numhl= ]]
	api.nvim_command [[ sign define DiagnosticSignInfo  text=I texthl=DiagnosticSignInfo  linehl= numhl= ]]
	api.nvim_command [[ sign define DiagnosticSignHint  text=H texthl=DiagnosticSignHint  linehl= numhl= ]]

	api.nvim_command [[ hi DiagnosticUnderlineError cterm=underline gui=underline guisp=#840000 ]]
	api.nvim_command [[ hi DiagnosticUnderlineHint cterm=underline  gui=underline guisp=#07454b ]]
	api.nvim_command [[ hi DiagnosticUnderlineWarn cterm=underline  gui=underline guisp=#2f2905 ]]
	api.nvim_command [[ hi DiagnosticUnderlineInfo cterm=underline  gui=underline guisp=#265478 ]]

end


-- ───────────────────────────────────────────────── --
-- setup LSPs
-- ───────────────────────────────────────────────── --
local function setup_lsp(mason_lspconfig)

	local tbl_deep_extend = vim.tbl_deep_extend
	local capabilities = M.capabilities
	local lsp_options = {
		on_attach = M.on_attach,
		flags = {
			debounce_text_changes = 150,
		},
		capabilities = capabilities
	}
	local import_cmp_lsp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
	if import_cmp_lsp then
		lsp_options.capabilities = (cmp_lsp).update_capabilities(capabilities)
	end
	local luadev = require("lua-dev").setup({
		--   cmd = {"lua-language-server"}
		lspconfig = lsp_options
	})

	mason_lspconfig.setup_handlers({

		function(server_name)
			require("lspconfig")[server_name].setup(lsp_options)
		end,

		["clangd"] = function()
			lspconfig.clangd.setup(
				tbl_deep_extend(
					"force", lsp_options,
					{ capabilities = { offsetEncoding = { "utf-16" } } }
				)
			)
		end,
		["html"] = function()
			lspconfig.html.setup(
				tbl_deep_extend(
					"force", lsp_options,
					{ filetypes = { "html", "htmldjango" } }
				)
			)
		end,
		["cssls"] = function()
			lspconfig.cssls.setup(
				tbl_deep_extend(
					"force", lsp_options,
					{
						capabilities = {
							textDocument = { completion = { completionItem = { snippetSupport = true } } }
						},
					}
				)
			)
		end,
		["sumneko_lua"] = function()
			lspconfig.sumneko_lua.setup(luadev)
		end,
		["zk"] = function()
			lspconfig.zk.setup {}
		end
	})
end

-- make sure `lspconfig` is not loaded after `mason-lspconfig`.
-- Also, make sure not to set up any servers via `lspconfig` _before_ calling `mason-lspconfig`'s setup function.


-- require("mason-lspconfig").setup_handlers({
local import_mlspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
if not import_mlspconfig then return end

-- import nvim-lsp-installer configs
local import_mconfig, mconfig = pcall(require, "plugins.mason_nvim")
if not import_mconfig then return end

mason.setup(mconfig.setup) -- setup mason
M.setup_lsp_config() -- setup lsp configs (mainly UI)
setup_lsp(mason_lspconfig) -- setup lsp (like pyright, ccls ...)

-- ───────────────────────────────────────────────── --
-- end LSP setup
-- ───────────────────────────────────────────────── --


-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
-- ━━━━━━━━━━━━━━━━━❰ end configs ❱━━━━━━━━━━━━━━━━━ --
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
return M
