return {
  "vimwiki/vimwiki",
  init = function()
    vim.g.vimwiki_list = { { path = "~/notes", syntax = "markdown", ext = "md" } }
    vim.g.vimwiki_global_ext = 0
  end,
}
