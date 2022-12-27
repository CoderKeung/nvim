local config = {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = {},
    section_separators = {},
    disabled_filetypes = {
      statusline = {"NvimTree"},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

local sep = {
  left = "",
  right = "",
}

local colors = {
  none = "NONE",
  bg_dark = "#1f2335",
  bg = "#24283b",
  bg_highlight = "#292e42",
  terminal_black = "#414868",
  fg = "#c0caf5",
  fg_dark = "#a9b1d6",
  fg_gutter = "#3b4261",
  dark3 = "#545c7e",
  comment = "#565f89",
  dark5 = "#737aa2",
  blue0 = "#3d59a1",
  blue = "#7aa2f7",
  cyan = "#7dcfff",
  blue1 = "#2ac3de",
  blue2 = "#0db9d7",
  blue5 = "#89ddff",
  blue6 = "#b4f9f8",
  blue7 = "#394b70",
  magenta = "#bb9af7",
  magenta2 = "#ff007c",
  purple = "#9d7cd8",
  orange = "#ff9e64",
  yellow = "#e0af68",
  green = "#9ece6a",
  green1 = "#73daca",
  green2 = "#41a6b5",
  teal = "#1abc9c",
  red = "#f7768e",
  red1 = "#db4b4b",
  git = { change = "#6183bb", add = "#449dab", delete = "#914c54" },
  gitSigns = {
    add = "#266d6a",
    change = "#536c9e",
    delete = "#b2555b",
  },
}

local mode_icon = {
  c = "𝓒",
  i = "𝓘",
  n = "𝓝",
  R = "𝓡",
  r = "𝓡",
  s = "𝓢",
  t = "𝓣",
  v = "𝓥",
}
local mode_color = {
  n = colors.red1,
  i = colors.teal,
  v = colors.blue1,
  [''] = colors.blue2,
  V = colors.blue3,
  c = colors.orange,
  no = colors.red,
  s = colors.green,
  S = colors.green1,
  [''] = colors.green2,
  ic = colors.yellow,
  R = colors.purple,
  Rv = colors.purple,
  cv = colors.red,
  ce = colors.red,
  r = colors.cyan,
  rm = colors.cyan,
  ['r?'] = colors.cyan,
  ['!'] = colors.red,
  t = colors.magenta2,
}

local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_left {
  function()
    return mode_icon[vim.fn.mode()]
  end,
  color = function() return { fg = colors.bg_dark,bg = mode_color[vim.fn.mode()], gui = "bold" } end,
  padding = { left = 2, right = 2 }
}

ins_left {
  function()
    return sep["right"]
  end,
  color = function() return { fg = mode_color[vim.fn.mode()], gui = "bold" } end,
  padding = 0,
}

ins_left {function()
  if not vim.b.gitsigns_head or vim.b.gitsigns_git_status then
    return ""
  end

  local git_status = vim.b.gitsigns_status_dict

  local added = (git_status.added and git_status.added ~= 0) and ("  " .. git_status.added) or ""
  local changed = (git_status.changed and git_status.changed ~= 0) and ("  " .. git_status.changed) or ""
  local removed = (git_status.removed and git_status.removed ~= 0) and ("  " .. git_status.removed) or ""
  local branch_name = "   " .. git_status.head .. " "

  return branch_name .. added .. changed .. removed
end
}

ins_right {function()
  return sep["left"]
end,
  color = { bg = colors.bg_dark, fg = colors.teal, gui = "bold" },
  padding = 0,
}
ins_right {function()
  local icon = ""
  local filename = (vim.fn.expand "%" == "" and "Empty ") or vim.fn.expand "%:t"

  if filename ~= "Empty " then
    local devicons_present, devicons = pcall(require, "nvim-web-devicons")

    if devicons_present then
      local ft_icon = devicons.get_icon(filename)
      icon = (ft_icon ~= nil and ft_icon) or ""
    end
  end
  return icon
end,
  color = { fg = colors.bg_dark, bg = colors.teal, gui = "bold" },
  padding = { right = 1 },
}
ins_right {function()
  local filename = (vim.fn.expand "%" == "" and "Empty ") or vim.fn.expand "%:t"
  return filename
end,
  color = function() return { bg = colors.bg_dark, fg = colors.fg, gui = "bold" } end,
}

ins_right {function()
  return sep["left"]
end,
  color = { bg = colors.bg_dark, fg = colors.orange, gui = "bold" },
  padding = 0,
}
ins_right {function()
  return " "
end,
  color = { fg = colors.bg_dark, bg = colors.orange, gui = "bold" },
  padding = 0,
}
ins_right {function()
  local current_line = vim.fn.line "."
  local total_line = vim.fn.line "$"
  local text = math.modf((current_line / total_line) * 100) .. tostring "%%"

  text = (current_line == 1 and "Top") or text
  text = (current_line == total_line and "Bot") or text

  return text .. " "
end,
  color = { fg = colors.fg, bg = colors.bg_dark, gui = "bold" } ,
  padding = { left  = 1, right = 1 },
}

require('lualine').setup(config)
