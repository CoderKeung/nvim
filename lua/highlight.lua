local colors = require("global").colors
local set_hl = vim.api.nvim_set_hl

set_hl(0, "CK_pos_sep", { fg = colors.orange, bg = colors.bg_dark })
set_hl(0, "CK_pos_icon", { fg = colors.bg_dark, bg = colors.orange })
set_hl(0, "CK_pos_text", { fg = colors.orange, bg = colors.bg_dark, bold = true })
set_hl(0, "CK_file_sep", { fg = colors.teal, bg = colors.bg_dark })
set_hl(0, "CK_file_icon", { fg = colors.bg_dark, bg = colors.teal })
set_hl(0, "CK_file_info", { fg = colors.teal, bg = colors.bg_dark, bold = true })
set_hl(0, "CK_NormalMode", { bg = colors.blue1, fg = colors.bg_dark, bold = true })
set_hl(0, "CK_InsertMode", { bg = colors.orange, fg = colors.bg_dark, bold = true })
set_hl(0, "CK_VisualMode", { bg = colors.teal, fg = colors.bg_dark, bold = true })
set_hl(0, "CK_ReplaceMode", { bg = colors.red, fg = colors.bg_dark, bold = true })
set_hl(0, "CK_SelectMode", { bg = colors.yellow, fg = colors.bg_dark, bold = true })
set_hl(0, "CK_CommandMode", { bg = colors.red1, fg = colors.bg_dark, bold = true })
set_hl(0, "CK_ConfirmMode", { bg = colors.blue6, fg = colors.bg_dark, bold = true })
set_hl(0, "CK_TerminalMode", { bg = colors.purple, fg = colors.bg_dark, bold = true })
set_hl(0, "CK_NTerminalMode", { bg = colors.purple, fg = colors.bg_dark, bold = true })
set_hl(0, "CK_NormalModeSep", { bg = colors.bg_dark, fg = colors.blue1, bold = true })
set_hl(0, "CK_InsertModeSep", { bg = colors.bg_dark, fg = colors.orange, bold = true })
set_hl(0, "CK_VisualModeSep", { bg = colors.bg_dark, fg = colors.teal, bold = true })
set_hl(0, "CK_ReplaceModeSep", { bg = colors.bg_dark, fg = colors.red, bold = true })
set_hl(0, "CK_SelectModeSep", { bg = colors.bg_dark, fg = colors.yellow, bold = true })
set_hl(0, "CK_CommandModeSep", { bg = colors.bg_dark, fg = colors.red1, bold = true })
set_hl(0, "CK_ConfirmModeSep", { bg = colors.bg_dark, fg = colors.blue6, bold = true })
set_hl(0, "CK_TerminalModeSep", { bg = colors.bg_dark, fg = colors.purple, bold = true })
set_hl(0, "CK_NTerminalModeSep", { bg = colors.bg_dark, fg = colors.purple, bold = true })
set_hl(0, "CK_lspStatus", { bg = colors.bg_dark, fg = colors.green2, bold = true })
set_hl(0, "CK_lspError", { bg = colors.bg_dark, fg = colors.red })
set_hl(0, "CK_lspWarning", { bg = colors.bg_dark, fg = colors.yellow })
set_hl(0, "CK_lspHints", { bg = colors.bg_dark, fg = colors.green2 })
set_hl(0, "CK_lspInfo", { bg = colors.bg_dark, fg = colors.blue0 })
set_hl(0, "CK_gitAdded", { bg = colors.bg_dark, fg = colors.green })
set_hl(0, "CK_gitChanged", { bg = colors.bg_dark, fg = colors.yellow })
set_hl(0, "CK_gitRemoved", { bg = colors.bg_dark, fg = colors.red })
set_hl(0, "CK_gitIcons", { bg = colors.bg_dark, fg = colors.fg, bold = true })

set_hl(0, "CK_cmpBorder", { bg = colors.bg_dark, fg = colors.fg })
set_hl(0, "CK_cmpNormal", { bg = colors.bg_dark, fg = colors.fg })
set_hl(0, "CK_cmpCursor", { bg = colors.terminal_black, bold = true })
set_hl(0, "CK_cmpDocumentNormal", { bg = colors.bg, fg = colors.fg })
set_hl(0, "CK_cmpDocumentBorder", { bg = colors.bg, fg = colors.fg })

set_hl(0, "CmpItemKindField", { bg = colors.teal, fg = colors.bg_dark })
set_hl(0, "CmpItemKindProperty", { bg = colors.teal, fg = colors.bg_dark })
set_hl(0, "CmpItemKindEvent", { bg = colors.teal, fg = colors.bg_dark })

set_hl(0, "CmpItemKindText", { bg = colors.cyan, fg = colors.bg_dark })
set_hl(0, "CmpItemKindEnum", { bg = colors.cyan, fg = colors.bg_dark })
set_hl(0, "CmpItemKindKeyword", { bg = colors.cyan, fg = colors.bg_dark })

set_hl(0, "CmpItemKindConstant", { bg = colors.blue1, fg = colors.bg_dark })
set_hl(0, "CmpItemKindConstructor", { bg = colors.blue1, fg = colors.bg_dark })
set_hl(0, "CmpItemKindReference", { bg = colors.blue1, fg = colors.bg_dark })

set_hl(0, "CmpItemKindFunction", { bg = colors.purple, fg = colors.bg_dark })
set_hl(0, "CmpItemKindStruct", { bg = colors.purple, fg = colors.bg_dark })
set_hl(0, "CmpItemKindClass", { bg = colors.purple, fg = colors.bg_dark })
set_hl(0, "CmpItemKindModule", { bg = colors.purple, fg = colors.bg_dark })
set_hl(0, "CmpItemKindOperator", { bg = colors.purple, fg = colors.bg_dark })

set_hl(0, "CmpItemKindFile", { bg = colors.red, fg = colors.bg_dark })
set_hl(0, "CmpItemKindVariable", { bg = colors.red, fg = colors.bg_dark })

set_hl(0, "CmpItemKindUnit", { bg = colors.green, fg = colors.bg_dark })
set_hl(0, "CmpItemKindSnippet", { bg = colors.green, fg = colors.bg_dark })
set_hl(0, "CmpItemKindFolder", { bg = colors.green, fg = colors.bg_dark })

set_hl(0, "CmpItemKindMethod", { bg = colors.orange, fg = colors.bg_dark })
set_hl(0, "CmpItemKindValue", { bg = colors.orange, fg = colors.bg_dark })
set_hl(0, "CmpItemKindEnumMember", { bg = colors.orange, fg = colors.bg_dark })

set_hl(0, "CmpItemKindInterface", { bg = colors.green2, fg = colors.bg_dark })
set_hl(0, "CmpItemKindColor", { bg = colors.green2, fg = colors.bg_dark })
set_hl(0, "CmpItemKindTypeParameter", { bg = colors.green2, fg = colors.bg_dark })

set_hl(0, "IndentBlanklineIndent1", { fg = colors.teal })
set_hl(0, "IndentBlanklineIndent2", { fg = colors.orange })
set_hl(0, "IndentBlanklineIndent3", { fg = colors.red })
set_hl(0, "IndentBlanklineIndent4", { fg = colors.cyan })
set_hl(0, "IndentBlanklineIndent5", { fg = colors.cyan })
set_hl(0, "IndentBlanklineIndent6", { fg = colors.purple })

set_hl(0, "TelescopeBorder", { fg = colors.teal, bg = colors.bg })
set_hl(0, "TelescopeNormal", { bg = colors.bg })

set_hl(0, "CK_spotifyInfo", { fg = colors.green1, bg = colors.bg_dark })