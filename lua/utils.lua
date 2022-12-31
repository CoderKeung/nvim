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

function UTILS.installLazy()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "--single-branch",
      "https://github.com/folke/lazy.nvim.git",
      lazypath,
    })
  end
  vim.opt.runtimepath:prepend(lazypath)
end

function UTILS.loadLazy(tab)
  local lazyPlugins = {}
  for repoName, _ in pairs(tab) do
    tab[repoName][1] = repoName
    lazyPlugins[#lazyPlugins + 1] = tab[repoName]
  end
  require("lazy").setup(lazyPlugins)
end

return UTILS
