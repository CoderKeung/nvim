local util = require("util")
local check = require("util.check")

local function check_cmdheight()
  if check.has_zero_cmdheight() then
    return {{"CmdlineLeave","*","lua require ('custom.cmd').cmdExit()"}}
  end
  return {}
end

local defintions = {
  packer = {
    {"BufWritePost","*lua","lua require('custom.coderun').packerCompile()"},
  },
  cmd = check_cmdheight(),
  ft = {
    {"FileType","dashboard","set showtabline=0 | autocmd WinLeave <buffer> set showtabline=2"}
  },
  win ={
    {"BufEnter","*","hi VertSplit gui=none guibg=none guifg=none"}
  }
}

util.create_augroups(defintions)
