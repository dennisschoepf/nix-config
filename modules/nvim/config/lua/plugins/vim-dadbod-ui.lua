return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    "pbogut/vim-dadbod-ssh",
    { "tpope/vim-dadbod", lazy = true },
    { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
  },
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.dbs = {
      { name = "freed_dev", url = "sqlite:./freed.db" },
    }
  end,
}
