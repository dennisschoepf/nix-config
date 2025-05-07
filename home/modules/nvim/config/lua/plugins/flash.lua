return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {},
  -- stylua: ignore
  keys = {
    { "<CR>",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
  },
}
