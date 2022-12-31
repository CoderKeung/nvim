local CORE = {}

local config = require("config")
local utils = require("utils")

function CORE.main()
  utils.installLazy()
  utils.loadLazy(config.plugins)
  utils.setGlobalVar(config.globalVar)
  utils.setOption(config.options)
  utils.setKeymap(config.keymaps)
  require("highlight")
end

return CORE.main()
