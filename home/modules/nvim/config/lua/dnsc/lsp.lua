vim.lsp.enable("ts_ls")
vim.lsp.enable("lua_ls")
vim.lsp.enable("eslint")
vim.lsp.enable("jsonls")

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { buffer = args.buf }

    vim.keymap.set("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
    vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
  end,
})
