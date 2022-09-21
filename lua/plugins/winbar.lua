local M = {}

local colors = require "plugins.colors"
local navic = require "nvim-navic"
local icons = require("plugins.icons")
-- local utils = require "utils"

vim.api.nvim_set_hl(0, "WinBarSeparator", { fg = colors.grey })
vim.api.nvim_set_hl(0, "WinBarFilename", { fg = colors.green, bg = colors.grey })
vim.api.nvim_set_hl(0, "WinBarContext", { fg = colors.green, bg = colors.grey })

M.winbar_filetype_exclude = {
  "help",
  "startify",
  "dashboard",
  "packer",
  "neogitstatus",
  "NvimTree",
  "Trouble",
  "alpha",
  "lir",
  "Outline",
  "spectre_panel",
  "toggleterm",
}

local get_buf_option = function(opt)
  local status_ok, buf_option = pcall(vim.api.nvim_buf_get_option, 0, opt)
  if not status_ok then
    return nil
  else
    return buf_option
  end
end
local function get_modified()
  local mod = icons.git.Mod
  if get_buf_option "mod" then
    return "%#WinBarFilename#" .. mod .. " " .. "%t" .. "%*"
  end
  return "%#WinBarFilename#" .. "%t" .. "%*"
end

local function is_empty(s)
  return s == nil or s == ""
end

local function get_location()
  local location = navic.get_location()
  if not is_empty(location) then
    return "%#WinBarContext#" .. " " .. icons.ui.ChevronRight .. " " .. location .. "%*"
  end
  return ""
end

function M.get_winbar()
  -- Use lualine disable file types
  -- if excludes() then
  --   return ""
  -- end

  if navic.is_available() then
    return "%#WinBarSeparator#"
        .. "%="
        .. ""
        .. "%*"
        .. get_modified()
        .. get_location()
        .. "%#WinBarSeparator#"
        .. ""
        .. "%*"
  else
    return "%#WinBarSeparator#" .. "%=" .. "" .. "%*" .. get_modified() .. "%#WinBarSeparator#" .. "" .. "%*"
  end
end

return M
