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
    sync_root_with_cwd = true,
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
  local ft_to_parser = require"nvim-treesitter.parsers".filetype_to_parsername
  ft_to_parser.ejs = "html"
  require'nvim-treesitter.configs'.setup {
    ensure_installed = {"help", "vim", "c", "lua", "javascript", "typescript", "html" },
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

tool.diffview = function()
  require "diffview".setup {
    diff_binaries = false, -- Show diffs for binaries
    enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
    use_icons = true, -- Requires nvim-web-devicons
    icons = {
      folder_closed = "",
      folder_open = ""
    },
    signs = {
      fold_closed = "",
      fold_open = ""
    },
    file_panel = {
      position = "left", -- One of 'left', 'right', 'top', 'bottom'
      width = 35, -- Only applies when position is 'left' or 'right'
      height = 10, -- Only applies when position is 'top' or 'bottom'
      listing_style = "tree", -- One of 'list' or 'tree'
      tree_options = {
        flatten_dirs = true, -- Flatten dirs that only contain one single dir
        folder_statuses = "only_folded" -- One of 'never', 'only_folded' or 'always'.
      }
    },
    file_history_panel = {
      position = "bottom",
      width = 35,
      height = 16,
      log_options = {
        max_count = 256, -- Limit the number of commits
        follow = false, -- Follow renames (only for single file)
        all = false, -- Include all refs under 'refs/' including HEAD
        merges = false, -- List only merge commits
        no_merges = false, -- List no merge commits
        reverse = false -- List commits in reverse order
      }
    },
    default_args = {
      DiffviewOpen = {},
      DiffviewFileHistory = {}
    },
    hooks = {}, -- See ':h diffview-config-hooks'
  }
end

return tool
