return {
  "nvim-orgmode/orgmode",
  dependencies = {
    "akinsho/org-bullets.nvim",
  },
  event = "VeryLazy",
  ft = { "org" },
  config = function()
    require("orgmode").setup({
      org_agenda_files = "~/orgnzr/**/*",
      org_default_notes_file = "~/orgnzr/inbox.org",
      org_todo_keywords = { "PROJECT(p)", "TODO(t)", "NEXT(n)", "|", "DONE(d)" },
      win_split_mode = "auto",
      org_startup_indented = true,
      org_indent_mode_turns_off_org_adapt_indentation = true,
      org_hide_leading_stars = true,
      org_blank_before_new_entry = { heading = false, plain_list_item = false },
      org_startup_folded = "content",
      org_ellipsis = "  ",
      org_capture_templates = {
        t = { description = "(t)odo", template = "* TODO %?\n" },
        a = { description = "Todo (a)t line", template = "* TODO %?\nat: %a" },
        l = { description = "(l)ink", template = "* %x%?" },
        j = {
          description = "(j)ournal entry",
          template = "\n** %?",
          datetree = {
            tree_type = "custom",
            tree = {
              {
                format = "%Y-%m-%d",
                pattern = "^(%d%d%d%d)-(%d%d)-(%d%d)$",
                order = { 1 },
              },
            },
          },
          target = "~/orgnzr/journal.org",
        },
      },
    })

    require("org-bullets").setup()

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "org",
      callback = function()
        vim.keymap.set("i", "<S-CR>", '<cmd>lua require("orgmode").action("org_mappings.meta_return")<CR>', {
          silent = true,
          buffer = true,
        })
      end,
    })
  end,
}
