vim.lsp.enable("ts_ls")
vim.lsp.enable("lua_ls")
vim.lsp.enable("jsonls")
vim.lsp.enable("nil_ls")
vim.lsp.enable("astro")
vim.lsp.enable("tailwindcss")

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.keymap.set(
      "n",
      "<leader>e",
      "<cmd>lua vim.diagnostic.open_float()<cr>",
      { buffer = args.buf, desc = "Show diagnostics on current line" }
    )
    vim.keymap.set(
      "n",
      "<leader>ca",
      "<cmd>lua vim.lsp.buf.code_action()<cr>",
      { buffer = args.buf, desc = "Code actions for current line" }
    )
  end,
})
