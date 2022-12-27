vim.cmd [[packadd packer.nvim]]

local packer = require("packer")
local utils = require("packer.util")

return packer.startup({function(use)
  use {"wbthomason/packer.nvim"}
  use {
    "nathom/filetype.nvim",
    config = function() require("packers.filetype") end
  }
  use {
    "nvim-tree/nvim-tree.lua",
    cmd = {"NvimTreeToggle", "NvimTreeOpen"},
    config = function() require("packers.tree") end,
  }
  use {
    "nvim-tree/nvim-web-devicons",
    module = "nvim-web-devicons"
  }
  use {
    "folke/tokyonight.nvim",
    config = function() require("packers.tokyonight") end
  }
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    event = "BufRead",
    config = function() require("packers.treesitter") end
  }
  use {
    "lukas-reineke/indent-blankline.nvim",
    event = {"BufRead"},
    config = function() require("packers.indent") end
  }
  use {
    "nvim-lualine/lualine.nvim",
    config = function() require("packers.lualine") end
  }
  use {
    "norcalli/nvim-colorizer.lua",
    cmd = "ColorizerToggle",
    config = function() require("colorizer").setup() end
  }
  end,
  config = {
      display = {
        open_fn = function()
          return utils.float({ border = {"┏", "━", "┓", "┃", "┛", "━", "┗", "┃"} })
        end,
        title = "Packer"
      },
      compile_path = utils.join_paths(vim.fn.stdpath("data"), "site","plugin","packer_compiled.lua")
    }
})
