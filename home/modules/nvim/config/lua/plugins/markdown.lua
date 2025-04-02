return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons", "jghauser/follow-md-links.nvim" },
  opts = {
    file_types = { "markdown", "vimwiki" },
    completions = { lsp = { enabled = true } },
    heading = {
      sign = false,
      border = false,
      position = "inline",
    },
  },
}
