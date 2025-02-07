return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      sections = {
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
        {
          section = "terminal",
          cmd = "pokemon-colorscripts -r --no-title; sleep .1",
          random = 10,
          pane = 2,
          indent = 8,
          height = 30,
        },
      },
    },
    git = { enabled = true },
    gitbrowse = { enabled = true },
    indent = { enabled = true },
    lazygit = {
      enabled = true,
      configure = true,
    },
    statuscolumn = { enabled = true },
    zen = { enabled = true },
  },
  -- stylua: ignore
  keys = {
    -- Git
    { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
    { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Show git blame for current line" },
    { "<leader>gl", function() Snacks.gitbrowse() end, desc = "Open link to line at git remote" },
    -- Zen Mode
    { "<leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" }
  },
}
