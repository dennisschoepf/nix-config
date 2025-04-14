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

    vim.keymap.set("n", "<C-Space>", "<C-x><C-o>", opts)
    vim.keymap.set("n", "<Space>e", "vim.diagnostic.open_float()", opts)
    vim.keymap.set("n", "<Space>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
  end,
})
