local tool = {}

tool.nvimTree = function()
  require("nvim-tree").setup({
    view = {
      adaptive_size = true,
      centralize_selection = true,
      width = 30,
      hide_root_folder = true,
      side = "left",
      preserve_window_proportions = true,
      mappings = {
        custom_only = false,
        list = {},
      },
    },
  })
end

tool.indent = function()
  require("indent_blankline").setup {
    space_char_blankline = " ",
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6",
    },
  }
end

tool.treeSitter = function()
  require'nvim-treesitter.configs'.setup {
    ensure_installed = {"help", "vim", "c", "lua", "javascript", "typescript" },
    sync_install = false,
    auto_install = true,
    ignore_install = {},
    highlight = {
      enable = true,
      disable = { "c", "rust" },
      additional_vim_regex_highlighting = false,
    },
  }
end

tool.colorizer = function()
  require("colorizer").setup()
end

tool.gitsigns = function()
  require("gitsigns").setup({
  signs = {
    add          = { hl = 'GitSignsAdd'   , text = '┃', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'    },
    change       = { hl = 'GitSignsChange', text = '┃', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
    delete       = { hl = 'GitSignsDelete', text = '', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
    topdelete    = { hl = 'GitSignsDelete', text = '', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
    changedelete = { hl = 'GitSignsChange', text = '', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
    untracked    = { hl = 'GitSignsAdd'   , text = '┇', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'    },
  },
  })
end

tool.telescope = function()
  require('telescope').setup{
    defaults = {
      layout_config = {
        vertical = { width = 0.5 }
      },
    },
    pickers = {
      find_files = {
        theme = "cursor",
        border = true,
        borderchars = {
          prompt = {"━", "┃", " ", "┃", "┏", "┓", "┃", "┃"},
          results = {"━", "┃", "━", "┃", "┣", "┫", "┛", "┗"},
          preview = {"━", "┃", "━", "┃", "┏", "┓", "┛", "┗"}
        },
        mappings = {
          n = {
            ["c"] = function(prompt_bufnr)
              local selection = require("telescope.actions.state").get_selected_entry()
              local dir = vim.fn.fnamemodify(selection.path, ":p:h")
              require("telescope.actions").close(prompt_bufnr)
              vim.cmd(string.format("silent cd %s", dir))
            end
          }
        },
      }
    },
  }
end

tool.toggleterm = function()
  require "toggleterm".setup {
    hide_numbers = true,
    direction = "horizontal",
    shell = vim.o.shell,
  }
end

tool.spotify = function()
  local spotify = require'nvim-spotify'
  spotify.setup {
    status = {
      update_interval = 10000,
      format = '%s %t by %a',
    }
  }
end

return tool
