return {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets" },
  version = "1.*",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = "enter",
      ["<Tab>"] = { "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "fallback" },
      ["<C-k>"] = { "show_documentation", "hide_documentation" },
    },
    appearance = {
      nerd_font_variant = "mono",
    },
    -- (Default) Only show the documentation popup when manually triggered
    -- C-k: Toggle signature help (if signature.enabled = true)
    completion = {
      documentation = { auto_show = false },
      list = {
        selection = {
          preselect = false,
          auto_insert = true,
        },
      },
    },
    signature = {
      enabled = true,
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      per_filetype = { sql = { "dadbod" } },
      providers = {
        dadbod = { module = "vim_dadbod_completion.blink" },
      },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    cmdline = {
      completion = { menu = { auto_show = true } },
    },
  },
  opts_extend = { "sources.default" },
}
