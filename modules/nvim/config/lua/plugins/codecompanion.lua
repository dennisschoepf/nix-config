return {
  "olimorris/codecompanion.nvim",
  config = function()
    require("codecompanion").setup({
      strategies = {
        chat = {
          adapter = "anthropic",
        },
        inline = {
          adapter = "anthropic",
        },
      },
    })

    vim.cmd([[cab cc CodeCompanion]])
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    { "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Open companion chat", mode = "n" },
    { "<leader>ca", "<cmd>CodeCompanionActions<cr>", desc = "Open companion actions", mode = "n" },
    { "ga", "<cmd>CodeCompanionChat Add<cr>", desc = "Add selection", mode = "v" },
  },
}
