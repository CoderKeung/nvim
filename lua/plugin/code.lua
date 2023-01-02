local code = {}

code.lsp = function()
  local lspconfig = require "lspconfig"
  vim.diagnostic.config(
    {
      virtual_text = {
        prefix = "●"
      },
      signs = true,
      underline = true,
      update_in_insert = true,
      severity_sort = false,
    }
  )
  local signs = {Error = "﫝", Warn = "ﴕ ", Hint = " ", Info = " "}
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
  end
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
  lspconfig.clangd.setup {
    capabilities = capabilities
  }
  require("neodev").setup({
    library = {
      enabled = true,
      runtime = true,
      types = true,
      plugins = true,
    },
    setup_jsonls = true,
    lspconfig = true,
  })
  lspconfig.sumneko_lua.setup({
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace"
        }
      }
    }
  })
  lspconfig.denols.setup({
    on_attach = on_attach,
    root_dir = require("lspconfig").util.root_pattern("deno.json", "deno.jsonc"),
  })
  lspconfig.tsserver.setup{
    root_dir = require("lspconfig").util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
  }
  lspconfig.emmet_ls.setup{}
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  lspconfig.html.setup {
    capabilities = capabilities,
  }
end

code.cmp = function()
  local cmp = require "cmp"
  local kindIcons = require("global").kindIcons
  local WIDE_HEIGHT = 40
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end
  local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
  end

  cmp.setup(
    {
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(_, vim_item)
          vim_item.kind = string.format("%s %s", kindIcons[vim_item.kind], vim_item.kind)
          local strings = vim.split(vim_item.kind, "%s", { trimempty = true })
          vim_item.kind = " " .. strings[1] .. " "
          return vim_item
        end,
      },
      window = {
        completion = {
          border = "",
          winhighlight = 'Normal:CK_cmpNormal,FloatBorder:CK_cmpBorder,CursorLine:CK_cmpCursor,Search:None',
          scrolloff = 0,
          col_offset = 0,
          side_padding = 0,
          scrollbar = false,
        },
        documentation = {
          max_height = math.floor(WIDE_HEIGHT * (WIDE_HEIGHT / vim.o.lines)),
          max_width = math.floor((WIDE_HEIGHT * 2) * (vim.o.columns / (WIDE_HEIGHT * 2 * 16 / 9))),
          border = "single",
          side_padding = 0,
          winhighlight = 'FloatBorder:CK_cmpDocumentBorder,Normal:CK_cmpDocumentNormal',
        },
      },
      view = {
        entries = {name = 'custom', selection_order = 'near_cursor' }
      },
      snippet = {
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body)
        end
      },
      mapping = {
        ["<Tab>"] = function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif vim.fn["vsnip#available"](1) == 1 then
            feedkey("<Plug>(vsnip-expand-or-jump)", "")
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end,
        ["<S-Tab>"] = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.fn["vsnip#jumpable"](-1) == 1 then
            feedkey("<Plug>(vsnip-jump-prev)", "")
          else
            fallback()
          end
        end,
        ["<CR>"] = cmp.mapping.confirm({select = true})
      },
      sources = cmp.config.sources(
        {
          {name = "nvim_lsp"},
          {name = "vsnip"}
        },
        {
          {name = "buffer"},
          {name = "path"}
        }
      ),
    }
  )
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      {
        name = 'cmdline',
        option = {
          ignore_cmds = { 'Man', '!' }
        }
      }
    })
  })
end

code.mason = function()
  require("mason").setup({
      ui = {
          icons = {
              package_installed = "",
              package_pending = "",
              package_uninstalled = ""
          }
      },
      install_root_dir = vim.fn.stdpath("data") .. "/mason"
  })
end

code.trouble = function()
  require("trouble").setup({
    position = "bottom", -- position of the list can be: bottom, top, left, right
    height = 8, -- height of the trouble list when position is top or bottom
    width = 50, -- width of the list when position is left or right
    icons = true, -- use devicons for filenames
    mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
    fold_open = "", -- icon used for open folds
    fold_closed = "", -- icon used for closed folds
    group = true, -- group results by file
    padding = true, -- add an extra new line on top of the list
    action_keys = { -- key mappings for actions in the trouble list
        -- map to {} to remove a mapping, for example:
        -- close = {},
        close = "q", -- close the list
        cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
        refresh = "r", -- manually refresh
        jump = {"<cr>", "<tab>"}, -- jump to the diagnostic or open / close folds
        open_split = { "<c-x>" }, -- open buffer in new split
        open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
        open_tab = { "<c-t>" }, -- open buffer in new tab
        jump_close = {"o"}, -- jump to the diagnostic and close the list
        toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
        toggle_preview = "P", -- toggle auto_preview
        hover = "K", -- opens a small popup with the full multiline message
        preview = "p", -- preview the diagnostic location
        close_folds = {"zM", "zm"}, -- close all folds
        open_folds = {"zR", "zr"}, -- open all folds
        toggle_fold = {"zA", "za"}, -- toggle fold of current file
        previous = "k", -- previous item
        next = "j" -- next item
    },
    indent_lines = true, -- add an indent guide below the fold icons
    auto_open = false, -- automatically open the list when you have diagnostics
    auto_close = false, -- automatically close the list when you have no diagnostics
    auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
    auto_fold = false, -- automatically fold a file trouble list at creation
    auto_jump = {"lsp_definitions"}, -- for the given modes, automatically jump if there is only a single result
    signs = {
        -- icons / text used for a diagnostic
        error = "﫝",
        warning = "ﴕ",
        hint = "",
        information = " ",
        other = "ﯯ"
    },
    use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
  })
end

code.lspsaga = function()
  require("lspsaga").init_lsp_saga({
    border_style = "bold",
  })
end

code.webtool = function()
  require'web-tools'.setup({
    keymaps = {
      rename = nil,  -- by default use same setup of lspconfig
      repeat_rename = '.', -- . to repeat
    },
  })
end

return code
