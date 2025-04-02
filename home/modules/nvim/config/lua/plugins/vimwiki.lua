return {
  "vimwiki/vimwiki",
  init = function()
    vim.g.vimwiki_list = { { path = "~/notes", syntax = "markdown", ext = ".md", links_space_char = "-" } }
    vim.g.vimwiki_ext2syntax = { [".md"] = "markdown" }
    vim.g.vimwiki_map_prefix = "<Leader>o"
    vim.g.vimwiki_global_ext = 1
  end,
}
