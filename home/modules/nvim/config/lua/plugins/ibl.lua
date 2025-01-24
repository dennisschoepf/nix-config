return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  ---@module "ibl"
  ---@type ibl.config
  opts = {
    indent = {
      smart_indent_cap = false,
      char = "╎",
    },
    scope = {
      show_start = false,
      show_end = false,
    },
  },
}
