local UTILS = {}

function UTILS.setOption(tab)
  for optionName, optionValue in pairs(tab) do
    vim.opt[optionName] = optionValue
  end
end

function UTILS.setKeymap(tab)
  for _, tabValue in pairs(tab) do
    vim.api.nvim_set_keymap(tabValue[1], tabValue[2], tabValue[3], tabValue[4])
  end
end

function UTILS.setGlobalVar(tab)
  for variableName, variableValue in pairs(tab) do
    vim.g[variableName] = variableValue
  end
end

return UTILS
