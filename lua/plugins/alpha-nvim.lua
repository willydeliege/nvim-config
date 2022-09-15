
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
-- ───────────────────────────────────────────────── --
--   Plugin:    alpha-nvim
--   Github:    github.com/goolord/alpha-nvim
-- ───────────────────────────────────────────────── --
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --





-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
-- ━━━━━━━━━━━━━━━━━━━❰ configs ❱━━━━━━━━━━━━━━━━━━━ --
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --

local alpha_ok, alpha = pcall(require, "alpha")
if not alpha_ok then return end

local dashboard_ok, dashboard = pcall(require, "alpha.themes.dashboard")
if not dashboard_ok then return end



dashboard.section.header.val = {
         [[                               __                ]],
         [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
         [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
         [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
         [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
         [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
}

-- Set menu
local options = {}
dashboard.section.buttons.val = {
	dashboard.button("n", "  > New file", ":ene <BAR> startinsert <CR>", options),
	dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>", options),
	dashboard.button("s", "  > Sessions", ":SessionManager load_session<CR>", options),
         dashboard.button("p", "  > Projects", ":Telescope projects<CR>",options),
	dashboard.button("f", "  > Find file", ":Telescope find_files<CR>", options),
	dashboard.button("S", "  > Settings", ":e ~/.config/nvim/init.lua <CR>", options),
	dashboard.button("q", "  > Quit NVIM", ":qa<CR>", options),
}

local handle = io.popen('fortune')
local fortune = handle:read("*a")
handle:close()
dashboard.section.footer.val = fortune

-- Send config to alpha
alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
-- ━━━━━━━━━━━━━━━━━❰ end configs ❱━━━━━━━━━━━━━━━━━ --
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --

