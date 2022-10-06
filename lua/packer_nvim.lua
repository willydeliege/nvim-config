-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
-- ───────────────────────────────────────────────── --
--    Plugin:    packer.nvim
--    Github:    github.com/wbthomason/packer.nvim

-- A use-package inspired plugin manager for Neovim.
-- Uses native packages, supports Luarocks dependencies,
-- written in Lua, allows for expressive config
-- ───────────────────────────────────────────────── --
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --





-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
-- ━━━━━━━━━━━━━━━━━━━❰ configs ❱━━━━━━━━━━━━━━━━━━━ --
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --

--              NOTE:1
-- If you want to automatically ensure that packer.nvim is installed on any machine you clone your configuration to,
-- add the following snippet (which is due to @Iron-E) somewhere in your config before your first usage of packer:
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
---@diagnostic disable-next-line: missing-parameter
if fn.empty(fn.glob(install_path)) > 0 then
	Packer_bootstrap = fn.system({
		'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
		install_path
	})
end

-- safely import packer
local import_packer, packer = pcall(require, "packer")
if not import_packer then return end

local commits = require("plugins.commits")


return packer.startup {

	config = {
		-- Move to lua dir so impatient.nvim can cache it
		compile_path = vim.fn.stdpath('config') .. '/plugin/packer_compiled.lua',

		display = {
			open_fn = function()
				return require('packer.util').float({ border = 'single' })
			end
		},
		git = {
			cmd = 'git', -- The base command for git operations
			depth = 1, -- Git clone depth
			clone_timeout = 600, -- Timeout, in seconds, for git clones
		},
		profile = {
			enable = true,
			threshold = 1 -- the amount in ms that a plugin's load time must be over for it to be included in the profile
		},
	},


	function()

		-- ━━━━━━━━━━━━━━━━━❰ Required plugins ❱━━━━━━━━━━━━━━━━━ --
		use { -- All the lua functions I don't want to write twice.
			'nvim-lua/plenary.nvim',
			commit = commits.plenary_nvim,
		}

		use { -- lua `fork` of vim-web-devicons for neovim
			'kyazdani42/nvim-web-devicons',
			commit = commits.nvim_web_devicons,
			config = function() require('plugins/nvim-web-devicons') end
		}
		-- ━━━━━━━━━━━━━━━━❰ end Required Plugin ❱━━━━━━━━━━━━━━━━ --

		use { -- Packer can manage itself
			'wbthomason/packer.nvim',
			commit = commits.packer_nvim,
		}

		-- Improve Start-UP time
		use { -- Speed up loading Lua modules in Neovim to improve startup time.
			'lewis6991/impatient.nvim',
			commit = commits.impatient_nvim,
			config = function()
				require("impatient")
			end,
			disable = false
		}
		use {
			"rcarriga/nvim-notify",
			config = function()
				local notify = require("notify")
				notify.setup()
				vim.notify = notify
			end,
			disable = false,
		}
		use {
			"ellisonleao/glow.nvim",
			config = function()
				require("glow").setup({})
			end
		}
		use {
			"mickael-menu/zk-nvim",
			config = function()
				require("plugins.zk-nvim")
			end
		}
		use { "mattn/calendar-vim" }
		use { "tools-life/taskwiki", disable = false }
		use { "majutsushi/tagbar" }
		use { "powerman/vim-plugin-AnsiEsc" }
		use { 'jakewvincent/mkdnflow.nvim',
			config = function()
				require('plugins.mkdnflow')
			end,
			disable = false }
		use { 'godlygeek/tabular' }
		use { 'preservim/vim-markdown' }
		use { -- show startup time
			'dstein64/vim-startuptime',
			commit = commits.startuptime,
			cmd = "StartupTime"
		}


		use { -- escape with jk, jj, kk or kj
			"max397574/better-escape.nvim",
			config = function()
				require("better_escape").setup()
			end,
		}
		use {
			"karb94/neoscroll.nvim",
			config = function()
				require("neoscroll").setup({
				})
			end
		}

		use { -- Easily speed up your neovim startup time!. A faster version of filetype.vim
			'nathom/filetype.nvim',
			commit = commits.filetype_nvim,
		}
		-- If you are using Pecker
		use { 'folke/tokyonight.nvim' }
		use { "RRethy/vim-illuminate" }

		use { -- A collection of common configurations for Neovim's built-in language server client
			'neovim/nvim-lspconfig',
			commit = commits.nvim_lspconfig,
			event = 'BufRead',
			requires = {
				{ -- Companion plugin for nvim-lspconfig that allows you to seamlessly install LSP servers locally (inside :echo stdpath("data")).
					'williamboman/mason.nvim',
					commit = commits.mason_nvim,
					requires = {
						{ 'williamboman/mason-lspconfig.nvim', commit = commits.mason_lspconfig_nvim }, -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim
						{ -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
							'jose-elias-alvarez/null-ls.nvim',
							commit = commits.null_ls_nvim,
							after = "mason.nvim"
						}
					},
				},
				{ -- A pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing.
					'folke/trouble.nvim',
					commit = commits.trouble_nvim,
					after = "nvim-lspconfig",
					config = function() require('plugins/trouble_nvim') end
				},
			},
			config = function()
				require('plugins/nvim-lspconfig')
				require('plugins/null-ls_nvim')
			end
		}
		use { --  DAP, Debug Adapter Protocol client implementation for Neovim
			'mfussenegger/nvim-dap',
			requires = {
				{ 'rcarriga/nvim-dap-ui' }, -- A UI for nvim-dap
				{
					'theHamsta/nvim-dap-virtual-text', -- This plugin adds virtual text support to nvim-dap. nvim-treesitter is used to find variable definitions.
					requires = { 'nvim-treesitter/nvim-treesitter' },
				},
				{
					'nvim-telescope/telescope-dap.nvim', --  Integration for nvim-dap with telescope.nvim
					requires = { 'nvim-telescope/telescope.nvim' },
				},
			},
			config = function()
				require("plugins.nvim-dap").setup()
			end
		}

		use { "folke/lua-dev.nvim" }
		use {
			"j-hui/fidget.nvim",
			config = function()
				require("plugins.fidget_nivm")
			end
		}
		use {
			'stevearc/aerial.nvim',
			config = function() require('aerial').setup() end
		}
		use { -- Nvim Treesitter configurations and abstraction layer
			'nvim-treesitter/nvim-treesitter',
			commit = commits.nvim_treesitter,
			run = function() vim.cmd([[TSUpdate]]) end,
			requires = {
				{ -- Treesitter playground integrated into Neovim
					'nvim-treesitter/playground',
					commit = commits.playground,
					after = 'nvim-treesitter'
				},
				{ --  Use treesitter to auto close and auto rename html tag, work with html,tsx,vue,svelte,php.
					"windwp/nvim-ts-autotag",
					commit = commits.nvim_ts_autotag,
					after = 'nvim-treesitter',
					ft = { 'html', 'htmldjango', 'tsx', 'jsx', 'javascriptreact', 'typescriptreact', 'vue', 'svelte', 'php' },
					config = function() require('plugins/nvim-ts-autotag') end
				},
				{ --  Neovim treesitter plugin for setting the commentstring based on the cursor location in a file.
					'JoosepAlviste/nvim-ts-context-commentstring',
					commit = commits.nvim_ts_context_commentstring,
					after = 'nvim-treesitter',
					config = function() require('plugins/nvim-ts-context-commentstring') end
				},
				{
					"p00f/nvim-ts-rainbow",
					after = "nvim-treesitter"

				}
			},
			config = function() require('plugins.nvim-treesitter').setup() end
		}
		use { -- A completion plugin for neovim coded in Lua.
			'hrsh7th/nvim-cmp',
			commit = commits.nvim_cmp,
			event = 'InsertEnter',
			requires = {
				{ -- vscode-like pictograms for neovim lsp completion items Topics
					'onsails/lspkind-nvim',
					after = "nvim-cmp",
					commit = commits.lspkind_nvim,
				},
				{ -- Snippet Engine for Neovim written in Lua.
					'L3MON4D3/LuaSnip',
					commit = commits.LuaSnip,
					module = "luasnip",
					requires = {
						{ 'rafamadriz/friendly-snippets', after = "LuaSnip", commit = commits.friendly_snippets }, -- Snippets collection for a set of different programming languages for faster development.
					},
				},
				{ -- A super powerful autopairs for Neovim. It support multiple character.
					'windwp/nvim-autopairs',
					commit = commits.nvim_autopairs,
					after = "nvim-cmp",
					config = function() require('plugins/nvim-autopairs') end
				},
				{ 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp', commit = commits.cmp_nvim_lsp }, -- nvim-cmp source for neovim builtin LSP client
				{ 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp', commit = commits.cmp_nvim_lua }, -- nvim-cmp source for nvim lua
				{ 'hrsh7th/cmp-buffer', after = 'nvim-cmp', commit = commits.cmp_buffer }, -- nvim-cmp source for buffer words.
				{ 'hrsh7th/cmp-path', after = 'nvim-cmp', commit = commits.cmp_path }, -- nvim-cmp source for filesystem paths.
				{ 'hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp', commit = commits.cmp_nvim_lsp_signature_help }, -- nvim-cmp source for displaying function signatures with the current parameter emphasized:
				{ 'hrsh7th/cmp-emoji', after = 'nvim-cmp', commit = commits.cmp_emoji },
				{ 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp', commit = commits.cmp_luasnip }, -- luasnip completion source for nvim-cmp
			},
			config = function()
				require('plugins/nvim-cmp')
				require('plugins/LuaSnip')
			end
		}
		use {
			"theHamsta/nvim-semantic-tokens",
			config = function()
				require("plugins.semantic").setup()
			end,
		}
		use { -- Find, Filter, Preview, Pick. All lua, all the time.
			'nvim-telescope/telescope.nvim',
			commit = commits.telescope_nvim,
			event = { 'CmdlineEnter', 'CursorHold' },
			keys = { "t", "<C>", "<C-f>", "<C-p>" },
			requires = {
				{ 'nvim-lua/popup.nvim', commit = commits.popup_nvim },
				{ 'nvim-telescope/telescope-fzf-native.nvim', commit = commits.telescope_fzf_native_nvim, run = 'make' }, -- FZF sorter for telescope written in c
				{ 'nvim-telescope/telescope-file-browser.nvim', commit = commits.telescope_file_browser_nvim }, -- File Browser extension for telescope.nvim
				{ 'nvim-telescope/telescope-media-files.nvim', commit = commits.telescope_media_files_nvim }, -- Telescope extension to preview media files using Ueberzug.
				{ 'nvim-telescope/telescope-ui-select.nvim', commit = commits.telescope_ui_select_nvim }, -- It sets vim.ui.select to telescope.
			},
			config = function() require('plugins/telescope_nvim') end
		}

		use {
			'ahmedkhalf/project.nvim',
			event = { 'CmdlineEnter', 'CursorHold' },
			commit = commits.project,
			require = { "nvim-telescope/telescope.nvim" },
			config = function()
				require("plugins/project")
			end
		}
		use { "akinsho/toggleterm.nvim", config = function()
			require("plugins.toggleterm")
		end,
			-- module = { "toggleterm", "toggleterm.terminal" },
		}

		use { -- Maximizes and restores the current window in Vim
			'szw/vim-maximizer',
			commit = commits.vim_maximizer,
			config = function() require('plugins/vim-maximizer') end
		}

		use { -- Smart and powerful comment plugin for neovim. Supports commentstring, dot repeat, left-right/up-down motions, hooks, and more
			'numToStr/Comment.nvim',
			commit = commits.Comment_nvim,
			keys = { "cc", "gc", "gb" },
			config = function() require('plugins/Comment_nvim') end
		}

		use { -- The fastest Neovim colorizer.
			'norcalli/nvim-colorizer.lua',
			commit = commits.nvim_colorizer_lua,
			config = function() require('plugins/nvim-colorizer_lua') end
		}

		use { --  Indent guides for Neovim
			'lukas-reineke/indent-blankline.nvim',
			commit = commits.indent_blankline_nvim,
			after = "nvim-treesitter",
			config = function() require('plugins/indent-blankline_nvim') end
		}

		use { -- Git signs written in pure luapa
			'lewis6991/gitsigns.nvim',
			commit = commits.gitsigns_nvim,
			config = function() require('plugins/gitsigns_nvim') end
		}

		use { -- A snazzy bufferline for Neovim
			'akinsho/nvim-bufferline.lua',
			commit = commits.nvim_bufferline_lua,
			event = "BufWinEnter",
			config = function() require('plugins/nvim-bufferline_lua') end
		}

		use {
			"kazhala/close-buffers.nvim",
			config = function()
				require("close_buffers").setup {}
			end
		}

		use { -- show only cuttent tab's buffers
			"tiagovla/scope.nvim",
			config = function()
				require("scope").setup()
			end
		}

		--[[ use { -- A File Explorer For Neovim Written In Lua
			'kyazdani42/nvim-tree.lua',
			commit = commits.nvim_tree_lua,
			cmd = "NvimTreeToggle",
			disable = true
		} ]]

		use {
			"nvim-neo-tree/neo-tree.nvim",
			branch = "v2.x",
			cmd = "Neotree",
			config = function()
				require('plugins.neo-tree')
			end,
			requires = {
				"nvim-lua/plenary.nvim",
				"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
				"MunifTanjim/nui.nvim",
			}
		}
		-- Packer
		use {
			"sindrets/diffview.nvim",
			config = function()
				require("diffview").setup({})
			end
		}
		use {
			'nvim-lualine/lualine.nvim',
			requires = { 'kyazdani42/nvim-web-devicons', opt = true },
			config = function()
				require("plugins.lualine").setup()
			end
		}
		-- use {
		-- 	"SmiteshP/nvim-navic",
		-- 	requires = "neovim/nvim-lspconfig"
		-- }
		use { --  A simple wrapper around :mksession
			'Shatur/neovim-session-manager',
			commit = commits.neovim_session_manager,
			config = function() require('plugins/neovim-session-manager') end
		}

		use { -- EditorConfig plugin for Neovim
			'gpanders/editorconfig.nvim',
			commit = commits.editorconfig_nvim,
		}
		-- use { "romgrk/todoist.nvim" }
		-- Lua
		use {
			"folke/which-key.nvim",
			config = function()
				require("plugins.whichkey")
			end
		}

		use { --  Neovim motions on speed!
			'phaazon/hop.nvim',
			commit = commits.hop_nvim,
			config = function() require('plugins/hop_nvim') end
		}

		-- ━━━━━━━━━━━━━━━━━❰ DEVELOPMENT ❱━━━━━━━━━━━━━━━━━ --

		use { -- java development
			"mfussenegger/nvim-jdtls"
		}

		-- ━━━━━━━━━━━━━━❰ end of DEVELOPMENT ❱━━━━━━━━━━━━━ --


		-- Automatically set up your configuration after cloning packer.nvim
		-- Put this at the end after all plugins
		if Packer_bootstrap then
			packer.sync()
		end
	end
}

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
-- ━━━━━━━━━━━━━━━━━❰ end configs ❱━━━━━━━━━━━━━━━━━ --
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
