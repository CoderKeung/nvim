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
