local MAIN = {}
local config = require("config")
local options = config.options
local keymaps = config.keymaps
local globalVar = config.globalVar
local setOption = require("utils").setOption
local setKeymap = require("utils").setKeymap
local setGlobalVar = require("utils").setGlobalVar


function MAIN.main()
  require("packers")
  setGlobalVar(globalVar)
  setOption(options)
  setKeymap(keymaps)
end

return MAIN.main()
