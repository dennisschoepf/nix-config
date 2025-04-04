local utils = require("dnsc.utils")

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    icons = { mappings = false },
  },
  keys = {
    { "<leader>.", "<cmd>FzfLua files<cr>", desc = "Find file in dir", mode = "n" },
    { "<leader><leader>", "<cmd>FzfLua git_files<cr>", desc = "Find git file", mode = "n" },
    { "<leader>B", "<cmd>FzfLua buffers<cr>", desc = "Opens buffers", mode = "n" },
    { "<leader>b", group = "buffer", mode = "n" },
    { "<leader>bb", "<cmd>FzfLua buffers<cr>", desc = "Switches buffers", mode = "n" },
    { "<leader>b,", "<Cmd>BufferMovePrevious<CR>", desc = "Move buffer back", mode = "n" },
    {
      "<leader>b.",
      "<Cmd>BufferMoveNext<CR>",
      desc = "Move buffer forward",
      mode = "n",
    },
    {
      "<leader>bD",
      "<cmd>BufferCloseAllButCurrent<cr>",
      desc = "Delete all buffers but current",
      mode = "n",
    },
    {
      "<leader>bd",
      "<Cmd>BufferClose<CR>",
      desc = "Delete current buffer",
      mode = "n",
    },
    {
      "<leader>bh",
      "<Cmd>BufferPrevious<CR>",
      desc = "Go to previous buffer",
      mode = "n",
    },
    {
      "<leader>bl",
      "<Cmd>BufferNext<CR>",
      desc = "Go to next buffer",
      mode = "n",
    },
    { "<leader>bp", "<cmd>BufferPick<cr>", desc = "Pick a buffer", mode = "n" },
    {
      "<leader>bx",
      "<cmd>BufferCloseAllButPinned<cr>",
      desc = "Delete all buffers",
      mode = "n",
    },
    { "<leader>c", group = "code/compile", mode = "n" },
    {
      "<leader>cr",
      function()
        utils.compile_project()
      end,
      desc = "Run current project",
      mode = "n",
    },
    { "<leader>ca", "<cmd>FzfLua lsp_code_actions<cr>", desc = "Code actions", mode = "n" },
    { "<leader>cd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Show diagnostics", mode = "n" },
    {
      "<leader>cf",
      "<cmd>FzfLua lsp_references<cr>",
      desc = "Show references",
      mode = "n",
    },
    {
      "<leader>q",
      "<cmd>wq<cr>",
      desc = "Close window and buffer",
      mode = "n",
    },
    { "<leader>f", group = "file", mode = "n" },
    {
      "<leader>fn",
      "<cmd>enew<cr>",
      desc = "Create a new file",
      mode = "n",
    },
    { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Open Recent File", mode = "n" },
    {
      "<leader>fs",
      "<cmd>w<cr>",
      desc = "Save currently opened file",
      mode = "n",
    },
    { "<leader>q", "<cmd>qa!<cr>", desc = "Leave neovim", mode = "n" },
    { "<leader>s", group = "search", mode = "n" },
    { "<leader>ss", "<cmd>FzfLua live_grep_native<CR>", desc = "Live Grep", mode = "n" },
    { "<leader>sp", "<cmd>FzfLua grep_project<CR>", desc = "Grep in project", mode = "n" },
    {
      "<leader>sw",
      "<cmd>FzfLua grep_cword<cr>",
      desc = "Search current word",
      mode = "n",
    },
    { "<leader>o", group = "org", mode = "n" },
    { "<leader>t", group = "diagnostics (lsp)", mode = "n" },
    {
      "<leader>td",
      "<cmd>FzfLua diagnostics_document<cr>",
      desc = "Show LSP diagnostics",
      mode = "n",
    },
    { "<leader>ta", "<cmd>TodoQuickFix<cr>", desc = "Show all todo comments", mode = "n" },
    { "<leader>w", group = "window", mode = "n" },
    {
      "<leader>w+",
      ":vertical resize +4<CR>",
      desc = "Increase window size",
      mode = "n",
    },
    {
      "<leader>w-",
      ":vertical resize -4<CR>",
      desc = "Decrease window size",
      mode = "n",
    },
    {
      "<leader>wx",
      "<C-W>q",
      desc = "Close active window",
      mode = "n",
    },
    {
      "<leader>wx",
      ":bd<CR>",
      desc = "Kill active window and buffer",
      mode = "n",
    },
    {
      "<leader>wh",
      "<C-W>h",
      desc = "Move to window on left",
      mode = "n",
    },
    {
      "<leader>wj",
      "<C-W>j",
      desc = "Move to window on bottom",
      mode = "n",
    },
    {
      "<leader>wk",
      "<C-W>k",
      desc = "Move to window on top",
      mode = "n",
    },
    {
      "<leader>wl",
      "<C-W>l",
      desc = "Move to window on right",
      mode = "n",
    },
    {
      "<leader>ws",
      "<cmd>sp<cr>",
      desc = "Split windows horizontally",
      mode = "n",
    },
    {
      "<leader>wv",
      "<cmd>vsp<cr>",
      desc = "Split windows vertically",
      mode = "n",
    },
    {
      "<leader>wd",
      "<cmd>bd<cr>",
      desc = "Delete buffer and window",
      mode = "n",
    },
    { "<leader>x", group = "config", mode = "n" },
    {
      "<leader>xn",
      "<cmd>set number relativenumber<cr>",
      desc = "Show relative numbers",
      mode = "n",
    },
    { "<leader>xr", "<cmd>source $MYVIMRC<cr>", desc = "Reload config", mode = "n" },
  },
}
