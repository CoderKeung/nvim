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

return { M = M, spotify = spotify}
