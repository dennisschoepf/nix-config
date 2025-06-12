return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      typescriptreact = { "prettierd" },
      astro = { "prettierd" },
      typescript = { "prettierd" },
      javascript = { "prettierd" },
      javascriptreact = { "prettierd" },
      html = { "prettierd" },
      css = { "prettierd" },
      yaml = { "prettierd" },
      markdown = { "prettierd" },
      json = { "prettierd" },
      lua = { "stylua" },
    },
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
}
