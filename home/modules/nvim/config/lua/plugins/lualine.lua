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
      lualine_b = { { "filename", path = 3, color = { gui = "italic" } } },
      lualine_c = {},
      lualine_x = { "diagnostics", "diff" },
      lualine_y = { "branch" },
      lualine_z = { "location", "encoding" },
    },
  },
}
