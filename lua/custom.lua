local M = {}

function M.findPackage()
  require("telescope.builtin").find_files {
    cwd = "~/Documents",
    prompt_title = "DOCUMENTS",
    layout_options = {
      preview_width = 0.75,
    },
  }
end

local spotify = {
  status = {},
  info = "",
}

local getContent = function(str)
  str = str:sub(string.find(str, ":") + 1, -1):gsub("%s+", "")
  return str
end

function spotify.status:start()
  local timer = vim.loop.new_timer()
  timer:start(1000, 10000, vim.schedule_wrap(function()
    local cmd = "spotify info"
    vim.fn.jobstart(cmd, { on_stdout = self.event, stdout_buffered = true })
  end))
end

function spotify.status:event(data)
  spotify.info = getContent(data[3]) .. "-" .. getContent(data[2])
end

local term = {}

term.lazygit = function()
  local Term = require('toggleterm.terminal').Terminal
  Term:new({
    cmd = "lazygit",
    dir = "git_dir",
    direction = "float",
    float_opts = {
      border = {"┏", "━", "┓", "┃", "┛", "━", "┗", "┃"},
      width = 150,
      height = 20,
      winblend = 0,
      highlights = {
        border = "Normal",
        background = "Normal"
      }
    },
    count = 1,
  }):toggle()
end

term.jless = function()
  local Term = require('toggleterm.terminal').Terminal
  Term:new({
    cmd = "jless".." "..vim.fn.expand("%"),
    direction = "horizontal",
    count = 2,
  }):toggle(vim.o.lines * 0.5)
end

return { M = M, spotify = spotify, term = term }
