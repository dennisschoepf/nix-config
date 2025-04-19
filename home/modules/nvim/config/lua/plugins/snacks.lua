---@module 'snacks'
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      enabled = false,
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
    picker = {
      enabled = true,
      prompt = "λ ",
      preset = "ivy",
      layout = { position = "bottom" },
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
    { "<leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
    -- Picker
    { "<leader>",  function() end, desc = "" },
    { "<leader>.",  function() Snacks.picker.files() end, desc = "" },
    { "<leader><leader>",  function() Snacks.picker.git_files() end, desc = "Git files" },
    -- Find
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
    { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
    -- Search
    { "<leader>ss",  function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
    { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
    -- Diagnostics
    { "<leader>td", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
    { "<leader>ta", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    -- LSP
    { "gd", function() Snacks.picker.lsp_definitions({ filter = { paths = { ["react/ts5.0"] = false } } }) end, desc = "Goto Definition" },
    { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
    { "grr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
    { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
    { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
  },
}
