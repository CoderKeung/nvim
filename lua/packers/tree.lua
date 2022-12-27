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
      list = {
      },
    },
   float = {
     enable = false,
     quit_on_focus_loss = true,
     open_win_config = {
      relative = "editor",
      border = {"┏", "━", "┓", "┃", "┛", "━", "┗", "┃"},
      width = 20,
      height = 20,
      row = 1,
      col = 1,
     },
   },     
  },
})
