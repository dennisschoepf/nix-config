local dnscUtils = require("dnsc.utils")

return {
  init_options = { hostInfo = "neovim" },
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  root_dir = dnscUtils.root_pattern("tsconfig.json", "jsconfig.json", "package.json", ".git"),
  init_options = {
    preferences = {
      importModuleSpecifierPreference = "relative",
      importModuleSpecifierEnding = "minimal",
    },
  },
  handlers = {
    ["textDocument/definition"] = function(err, result, method, ...)
      if vim.tbl_islist(result) and #result > 1 then
        local filtered_result = dnscUtils.filter(result, dnscUtils.filterReactDTS)
        return vim.lsp.handlers["textDocument/definition"](err, filtered_result, method, ...)
      end

      vim.lsp.handlers["textDocument/definition"](err, result, method, ...)
    end,
  },
  single_file_support = true,
}
