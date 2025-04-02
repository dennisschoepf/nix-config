return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons", "jghauser/follow-md-links.nvim" },
  opts = {
    ft = { "markdown" },
    completions = { lsp = { enabled = true } },
  },
}
