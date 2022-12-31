local ui = {}

ui.tokyonight = function()
  vim.cmd[[colorscheme tokyonight]]
  require("tokyonight").setup({
    style = "storm",
    light_style = "day",
    transparent = false,
    terminal_colors = true,
    styles = {
      comments = { italic = true },
      keywords = { italic = true },
      functions = {},
      variables = {},
      sidebars = "dark",
      floats = "dark",
    },
    sidebars = { "qf", "help" },
    day_brightness = 0.3,
    hide_inactive_statusline = false,
    dim_inactive = false,
    lualine_bold = true,
  })
end

ui.filetype = function()
  require("filetype").setup({
    overrides = {
      extensions = { pn = "potion" },
      literal = { MyBackupFile = "lua" },
      complex = { [".*git/config"] = "gitconfig" },
      function_extensions = {
        ["cpp"] = function() vim.bo.filetype = "cpp"; vim.bo.cinoptions = vim.bo.cinoptions.."L0" end,
        ["pdf"] = function() vim.bo.filetype = "pdf"; vim.fn.jobstart("open -a skim "..'"'..vim.fn.expand("%")..'"') end,
      },
      function_literal = { Brewfile = function() vim.cmd("syntax off") end },
      function_complex = { ["*.math_notes/%w+"] = function() vim.cmd("iabbrev $ $$") end },
      shebang = { dash = "sh" },
    },
  })
end

ui.lualine = function()

  local config = {
    options = {
      icons_enabled = true,
      theme = 'tokyonight',
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

  local modes = require("global").modes
  local sep = require("global").separators

  local function insLeft(component)
    table.insert(config.sections.lualine_c, component)
  end

  local function insRight(component)
    table.insert(config.sections.lualine_x, component)
  end

  insLeft { function()
    local m = vim.api.nvim_get_mode().mode
    local currentMode = "%#" .. modes[m].highlight .. "#" .. modes[m].icon .. string.sub(modes[m].name, 2, -1)
    local modeSep = "%#" .. modes[m].highlight .. "Sep" .. "#" .. sep.right
    return currentMode .. modeSep
  end }

  insLeft { function()
    if rawget(vim, "lsp") then
      for _, client in ipairs(vim.lsp.get_active_clients()) do
        if client.attached_buffers[vim.api.nvim_get_current_buf()] then
          return (vim.o.columns > 100 and "%#CK_lspStatus#" .. " " .. client.name .. " ") or ""
        end
      end
    end
  end,
    padding = 0,
  }

  insLeft { function()
    if not rawget(vim, "lsp") then
      return ""
    end
    local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    local hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    local info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    errors = (errors and errors > 0) and ("%#CK_lspError#" .. "﫝" .. errors .. " ") or ""
    warnings = (warnings and warnings > 0) and ("%#CK_lspWarning#" .. "ﴕ " .. warnings .. " ") or ""
    hints = (hints and hints > 0) and ("%#CK_lspHints#" .. " " .. hints .. " ") or ""
    info = (info and info > 0) and ("%#CK_lspInfo#" .. " " .. info .. " ") or ""
    return errors .. warnings .. hints .. info
  end,
    padding = 0,
  }

  local spotify = require("custom").spotify
  spotify.status:start()

  insLeft { function()
    return "%#CK_spotifyInfo#" .." ".. spotify.info
  end,
  pdding = 0,
  }

  insRight { function()
    if not vim.b.gitsigns_head or vim.b.gitsigns_git_status then
      return ""
    end
    local git_status = vim.b.gitsigns_status_dict
    local added = (git_status.added and git_status.added ~= 0) and ("%#CK_gitAdded#" .. "  " .. git_status.added) or ""
    local changed = (git_status.changed and git_status.changed ~= 0) and ("%#CK_gitChanged#" .. " ⭘ " .. git_status.changed) or ""
    local removed = (git_status.removed and git_status.removed ~= 0) and ("%#CK_gitRemoved#" .. "  " .. git_status.removed) or ""
    local branch_name = " " .. git_status.head

    return "%#CK_gitIcons#" .. branch_name .. added .. changed .. removed .. " "
  end,
    padding = 0,
  }
  insRight { function()
    local icon = " "
    local filename = (vim.fn.expand "%" == "" and "Empty ") or vim.fn.expand "%:t"
    if filename ~= "Empty" then
      local present, devicons = pcall(require, "nvim-web-devicons")
      if present then
        local ftIcon = devicons.get_icon(filename)
        icon = (ftIcon ~= nil and ftIcon .. " ") or icon
      end
      filename = " " .. filename .. " "
    end
    return "%#CK_file_sep#" .. sep.left .. "%#CK_file_icon#" .. icon .. "%#CK_file_info#" .. filename
  end,
    padding = 0,
  }

  insRight {function()
    local leftSep = "%#CK_pos_sep#" .. sep.left .. "%#CK_pos_icon#" .. " "
    local currentLine = vim.fn.line "."
    local totalLine = vim.fn.line "$"
    local text = math.modf((currentLine / totalLine) * 100) .. tostring "%%"
    text = (currentLine == 1 and "Top") or text
    text = (currentLine == totalLine and "Bot") or text
    return leftSep .. "%#CK_pos_text#" .. " " .. text .. " "
  end,
    padding = 0,
  }

  require('lualine').setup(config)
end

return ui
