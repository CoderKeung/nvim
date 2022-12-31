local CONFIG = {}

CONFIG.options = {
  completeopt    = "menuone,noinsert,noselect",
  sw             = 2,
  tabstop        = 2,
  softtabstop    = 2,
  shiftwidth     = 2,
  expandtab      = true,
  number         = true,
  relativenumber = true,
  termguicolors  = true,
  clipboard      = "unnamedplus",
  showmode       = false,
  updatetime     = 300,
  undofile       = true,
  fillchars      = "vert:▏",
  cmdheight      = 0,
  laststatus     = 2,
  guifont        = "FiraCode Nerd Font:h15",
}

CONFIG.keymaps  = {
  {"n", "E", "<cmd>q!<CR>", {noremap = true, silent = true}},
  {"n", "Q", "<cmd>wq!<CR>", {noremap = true, silent = true}},
  {"n", "S", "<cmd>w!<CR>", {noremap = true, silent = true}},
  {"n", "<Tab>", "<C-w>w", {noremap = true, silent = true}},
  {"n", "<C-h>", "<C-w><", {noremap = true, silent = true}},
  {"n", "<C-l>", "<C-w>>", {noremap = true, silent = true}},
  {"n", "<C-k>", "<C-w>+", {noremap = true, silent = true}},
  {"n", "<C-j>", "<C-w>-", {noremap = true, silent = true}},
  {"n", "K", "<C-b>", {noremap = true, silent = true}},
  {"n", "J", "<C-f>", {noremap = true, silent = true}},
  {"n", "t", "<cmd>NvimTreeToggle<CR>", {noremap = true, silent = true}},
  {"n", "<C-f>", "<cmd>Telescope find_files<CR>", {noremap = true, silent = true}},
  {"n", "F", "<cmd>lua require('custom').findPackage()<CR>", {noremap = true, silent = true}},
  {"n", "<M-p>", "<cmd>ToggleTerm<CR>", {noremap = true, silent = true}},
  {"t", "<M-p>", "<cmd>ToggleTerm<CR>", {noremap = true, silent = true}},
}

CONFIG.globalVar = {
  loaded_gzip              = 1,
  loaded_tar               = 1,
  loaded_tarPlugin         = 1,
  loaded_zip               = 1,
  loaded_zipPlugin         = 1,
  loaded_getscript         = 1,
  loaded_getscriptPlugin   = 1,
  loaded_vimball           = 1,
  loaded_vimballPlugin     = 1,
  loaded_matchit           = 1,
  loaded_matchparen        = 1,
  loaded_2html_plugin      = 1,
  loaded_logiPat           = 1,
  loaded_rrhelper          = 1,
  loaded_netrw             = 1,
  loaded_netrwPlugin       = 1,
  loaded_netrwSettings     = 1,
  loaded_netrwFileHandlers = 1,
  python_host_skip_check   = 1,
  python3_host_skip_check  = 1,
  python_host_prog         = "/usr/local/bin/python",
  python3_host_prog        = "/usr/local/bin/python3",
  did_load_filetypes       = 1,
  neovide_cursor_animation_length = 0.05,
  neovide_cursor_antialiasing = true,
  neovide_cursor_vfx_mode = "railgun",
  neovide_cursor_vfx_particle_density = 20.0,
  indent_blankline_char = "┃",
  vsnip_snippet_dir = vim.fn.stdpath("config") .. "/vsnip",
  neovide_input_macos_alt_is_meta = true,
}

CONFIG.plugins = {
  ["nathom/filetype.nvim"] = {
    config = function() require("plugin.ui").filetype() end
  },
  ["nvim-tree/nvim-web-devicons"] = {
    module = "nvim-web-devicons"
  },
  ["nvim-lua/plenary.nvim"] = {
    module = "plenary"
  },
  ["folke/tokyonight.nvim"] = {
    config = function() require("plugin.ui").tokyonight() end
  },
  ["nvim-lualine/lualine.nvim"] = {
    config = function() require("plugin.ui").lualine() end
  },
  ["nvim-tree/nvim-tree.lua"] = {
    cmd = {"NvimTreeToggle", "NvimTreeOpen"},
    config = function() require("plugin.tool").nvimTree() end,
  },
  ["lukas-reineke/indent-blankline.nvim"] = {
    event = {"BufRead"},
    config =  function() require("plugin.tool").indent() end,
  },
  ["nvim-treesitter/nvim-treesitter"] = {
    run = ":TSUpdate",
    event = "BufRead",
    config = function() require("plugin.tool").treeSitter() end,
  },
  ["norcalli/nvim-colorizer.lua"] = {
    cmd = "ColorizerToggle",
    config = function() require("plugin.tool").colorizer() end,
  },
  ["lewis6991/gitsigns.nvim"] = {
    event = {"BufRead", "BufNewFile"},
    config = function() require("plugin.tool").gitsigns() end
  },
  ["folke/neodev.nvim"] = {
    module = "neodev"
  },
  ["neovim/nvim-lspconfig"] = {
  dependencies = {
      {"hrsh7th/cmp-nvim-lsp", module = "cmp_nvim_lsp"},
      {"hrsh7th/nvim-cmp", event = {"InsertEnter","CmdlineEnter"}, config = function() require("plugin.code").cmp() end },
      {"hrsh7th/cmp-buffer", after = "nvim-cmp"},
      {"hrsh7th/cmp-path", after = "nvim-cmp"},
      {"hrsh7th/cmp-cmdline", after = "nvim-cmp"},
      {"hrsh7th/cmp-vsnip", after = "nvim-cmp", event = "InsertCharPre"},
      {"hrsh7th/vim-vsnip", after = "nvim-cmp", event = "InsertCharPre"},
    },
    event = {"BufReadPre", "BufNewFile"},
    module = "lspconfig",
    config = function() require("plugin.code").lsp() end,
  },
  ["williamboman/mason.nvim"] = {
    cmd = {"Mason", "MasonInstall"},
    config = function() require("plugin.code").mason() end,
  },
  ["folke/trouble.nvim"] = {
    cmd = {"Trouble"},
    config = function() require("plugin.code").trouble() end,
  },
  ["nvim-telescope/telescope.nvim"] = {
    cmd = {"Telescope" },
    module = "telescope",
    config = function() require("plugin.tool").telescope() end
  },
  ["akinsho/toggleterm.nvim"] = {
    module = "toggleterm",
    cmd = {"ToggleTerm"},
    config = function() require("plugin.tool").toggleterm() end
  },
  ["KadoBOT/nvim-spotify"] = {
    config = function() require("plugin.tool").spotify() end,
    build = "make",
  }
}

return CONFIG
