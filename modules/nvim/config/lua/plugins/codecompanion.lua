return {
  "olimorris/codecompanion.nvim",
  opts = {
    strategies = {
      chat = {
        adapter = "anthropic",
      },
      inline = {
        adapter = "anthropic",
      },
    },
  },
  config = function()
    vim.cmd([[cab cc CodeCompanion]])
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Open companion chat", mode = "n" },
    { "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "Open companion actions", mode = "n" },
    { "ga", "<cmd>CodeCompanionChat Add<cr>", desc = "Add selection to chat", mode = "v" },
  },
}
