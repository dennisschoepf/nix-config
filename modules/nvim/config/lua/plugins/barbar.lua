return {
  "romgrk/barbar.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
    "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  opts = {
    animation = false,
    auto_hide = false,
    maximum_length = 35,
    icons = { filetype = { enabled = false }, button = "", modified = { button = "m" } },
    highlight_visible = false,
  },
  version = "^1.0.0", -- optional: only update when a new 1.x version is released
}
