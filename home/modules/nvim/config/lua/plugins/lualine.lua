return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      icons_enabled = false,
      -- globalstatus = true
      component_separators = { left = "|", right = "|" },
      section_separators = { left = "", right = "" },
    },
    winbar = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = { { "filename", path = 3, color = { fg = "darkgray", gui = "italic" } } },
      lualine_y = {},
      lualine_z = { "branch" },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = {},
      lualine_c = { "diff", "diagnostics" },
      lualine_x = { "filetype", "encoding" },
      lualine_y = {},
      lualine_z = { "location" },
    },
  },
}
