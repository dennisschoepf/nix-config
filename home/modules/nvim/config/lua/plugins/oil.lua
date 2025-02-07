return {
  "stevearc/oil.nvim",
  opts = {
    keymaps = {
      ["q"] = "actions.close",
    },
    columns = {
      "icon",
      "permissions",
      "size",
      -- "mtime",
    },
    float = {
      padding = 4,
      border = "rounded",
      preview_split = "auto",
    },
  },
  -- stylua: ignore
  keys = {
    { "<leader>n", "<cmd>Oil --float<cr>", desc = "Open file browser", mode = "n" },
  }
,
}
