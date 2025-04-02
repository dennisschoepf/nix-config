return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      icons_enabled = false,
      -- globalstatus = true
      component_separators = { left = "|", right = "|" },
      section_separators = { left = "", right = "" },
    },
    winbar = {},
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch" },
      lualine_c = { "diff" },
      lualine_x = { "diagnostics" },
      lualine_y = { "location" },
      lualine_z = { "filetype" },
    },
  },
}
