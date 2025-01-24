return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  event = {
    "BufReadPre /home/dennis/notes/**.md",
    "BufNewFile /home/dennis/notes/**.md",
  },
  opts = {
    workspaces = {
      {
        name = "notes",
        path = "~/notes",
      },
    },
    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      folder = "~/notes/001_dailies",
      -- Optional, if you want to change the date format for the ID of daily notes.
      date_format = "%Y-%m-%d",
      -- Optional, if you want to change the date format of the default alias of daily notes.
      alias_format = "%B %-d, %Y",
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = nil,
    },
  },
}
