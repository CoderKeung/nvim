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
  status = {
    progreess = true,
    text = true,
    flow = true,
  },
  icons = {played = "%#CK_spotifyProgreePlayed#ﱢ", now = "%#CK_spotifyProgreeNow#﮸", noplay = "%#CK_spotifyProgreeNoplay#ﱡ", playing = "", paused = ""},
  flowIcons = {"▁", "▂", "▃", "▄", "▅", "▆", "▇", "█"},
  flowNumber = {8217, 8726, 1821, 6381, 1872, 2873, 3847},
  step = 1,
  spotifyc = vim.fn.stdpath("config").."/tools/spotify",
  info = {
    text = "",
    status = "",
    total = 0,
    now = 0,
    flowString = "",
    progress = "",
  },
}

local drawProgress = function(totalTime, nowTime)
  local progress = ""
  nowTime = math.ceil(nowTime / totalTime * 10)
  totalTime = 10
  while totalTime > 0 do
    if (totalTime == nowTime) then
      progress = spotify.icons.now .. progress
    elseif (totalTime > nowTime) then
      progress = spotify.icons.noplay .. progress
    else
      progress = spotify.icons.played .. progress
    end
    totalTime = totalTime - 1
  end
  return progress
end

local spotifyStatus = function(str)
  if (str == "playing") then
    return spotify.icons.playing
  else
    return spotify.icons.paused
  end
end

local getContent = function(str)
  str = str:sub(string.find(str, ":") + 1, -1):gsub("%s+", "")
  return str
end

local getFlowNumer = function(num) 
  local flowNumber = {}
  local step = 1000
  for i = 1, 4, 1 do
    flowNumber[i] = math.floor(num/step) % 10
    step = step / 10
  end
  return flowNumber
end
local setFlowString = function(flowNumber)
  local flowString = ""
  for _, v in pairs(flowNumber) do
    flowString = flowString .. spotify.flowIcons[v]
  end
  return " "..flowString.." "
end

function spotify.status:info()
  local cmd = spotify.spotifyc.." ".."info"
  vim.fn.jobstart(cmd, { on_stdout = spotify.status.event, stdout_buffered = true })
end

function spotify.status:event(data)
  spotify.info.text = getContent(data[2]) .. "-" .. getContent(data[3])
  spotify.info.status = spotifyStatus(getContent(data[8]))
end

function spotify.status:progreeEvent(data)
  local total = getContent(data[6])
  local now = getContent(data[7])
  spotify.info.total = total:sub(0, total:find("m") - 1) * 60 + total:sub(total:find("n") + 1, total:find("s") - 1)
  spotify.info.now = now:sub(0, now:find("m") - 1) * 60 + now:sub(now:find("n") + 1, now:find("s") - 1)
  spotify.info.progress = drawProgress(spotify.info.total, spotify.info.now)
end

function spotify.status:start()
  if spotify.status.progress then
    local progressTimer = vim.loop.new_timer()
    progressTimer:start(1000, 1000, vim.schedule_wrap(function()
      local cmd = spotify.spotifyc.." ".."info"
      vim.fn.jobstart(cmd, { on_stdout = spotify.status.progreeEvent, stdout_buffered = true })
    end))
  end
  if spotify.status.flow then
    local flowTimer = vim.loop.new_timer()
    flowTimer:start(1000, 100, vim.schedule_wrap(function()
      spotify.info.flowString = setFlowString(getFlowNumer(spotify.flowNumber[spotify.step]))
      if spotify.info.status == spotify.icons.playing then
        spotify.step = spotify.step + 1
      end
      if spotify.step == #spotify.flowNumber then
        spotify.step = 1
      end
    end))
  end
  if spotify.status.text then
    local timer = vim.loop.new_timer()
    timer:start(1000, 10000, vim.schedule_wrap(function()spotify.status:info()end))
  end
end

function spotify.status:listen(...)
  local str = "%#CK_spotifyInfo#" .." 玲"..spotify.info.status.." 怜"
  for _, v in pairs({...}) do
    str = str..spotify.info[v]
  end
  return str
end

function spotify.status:next()
  local cmd = spotify.spotifyc.." ".."next"
  vim.fn.jobstart(cmd, { on_stdout = spotify.status.info, stdout_buffered = true })
end
function spotify.status:prev()
  local cmd = spotify.spotifyc.." ".."prev"
  vim.fn.jobstart(cmd, { on_stdout = spotify.status.info, stdout_buffered = true })
end
function spotify.status:stop()
  local cmd = spotify.spotifyc.." ".."stop"
  vim.fn.jobstart(cmd, { on_stdout = spotify.status.info, stdout_buffered = true })
end
function spotify.status:play()
  local cmd = spotify.spotifyc.." ".."play"
  vim.fn.jobstart(cmd, { on_stdout = spotify.status.info, stdout_buffered = true })
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
