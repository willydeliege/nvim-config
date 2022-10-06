
local M = {}

local set_hl = vim.api.nvim_set_hl

function M.setup()
  -- token
  -- https://github.com/nvim-treesitter/nvim-treesitter/blob/master/lua/nvim-treesitter/highlight.lua
  -- set_hl(0, "LspParameter", { fg = "#ef9062" })
  -- set_hl(0, "LspType", { fg = "#619e9d" })
  set_hl(0, "LspParameter", { link = "TSParameter" })
  set_hl(0, "LspType", { link = "TSType" })
  set_hl(0, "LspClass", { link = "TSStorageClass" })
  set_hl(0, "LspComment", { link = "TSComment" })
  set_hl(0, "LspDecorator", { link = "TSAnnotation" })
  set_hl(0, "LspEnum", { link = "TSType" })
  set_hl(0, "LspEnumMember", { link = "TSParameter" })
  set_hl(0, "LspEvent", { link = "TSProperty" })
  set_hl(0, "LspFunction", { link = "TSFunction" })
  set_hl(0, "LspInterface", { link = "TSKeywordFunction" })
  set_hl(0, "LspKeyword", { link = "TSKeyword" })
  set_hl(0, "LspMacro", { link = "TSFuncMacro" })
  set_hl(0, "LspMethod", { link = "TSMethod" })
  set_hl(0, "LspModifier", { link = "TSTypeQualifier" })
  set_hl(0, "LspNamespace", { link = "TSNamespace" })
  set_hl(0, "LspNumber", { link = "TSNumber" })
  set_hl(0, "LspOperator", { link = "TSOperator" })
  set_hl(0, "LspProperty", { link = "TSProperty" })
  set_hl(0, "LspRegexp", { link = "TSStringRegex" })
  set_hl(0, "LspString", { link = "TSString" })
  set_hl(0, "LspStruct", { link = "TSTypeDefinition" })
  set_hl(0, "LspTypeParameter", { link = "TSType" })
  set_hl(0, "LspVariable", { link = "TSVariable" })

  require("nvim-semantic-tokens").setup {
    preset = "default",
    highlighters = { require "nvim-semantic-tokens.table-highlighter" },
  }
end

return M
