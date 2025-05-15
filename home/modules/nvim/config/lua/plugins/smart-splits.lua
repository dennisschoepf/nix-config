return {
  "mrjones2014/smart-splits.nvim",
  keys = {
    { "<C-h>", "require('smart-splits').move_cursor_left", desc = "Move to left split", mode = "n" },
    { "<C-j>", "require('smart-splits').move_cursor_down", desc = "Move to lower split", mode = "n" },
    { "<C-k>", "require('smart-splits').move_cursor_up", desc = "Move to upper split", mode = "n" },
    { "<C-l>", "require('smart-splits').move_cursor_right", desc = "Move to right split", mode = "n" },

    { "<A-h>", "require('smart-splits').resize_left", desc = "Resize to left", mode = "n" },
    { "<A-j>", "require('smart-splits').resize_down", desc = "Resize lower", mode = "n" },
    { "<A-k>", "require('smart-splits').resize_up", desc = "Resize upper", mode = "n" },
    { "<A-l>", "require('smart-splits').resize_right", desc = "Resize to right", mode = "n" },

    { "<leader>mh", "require('smart-splits').swap_buf_left", desc = "Swap to left" },
    { "<leader>mj", "require('smart-splits').swap_buf_down", desc = "Swap to lower" },
    { "<leader>mk", "require('smart-splits').swap_buf_up", desc = "Swap to upper" },
    { "<leader>ml", "require('smart-splits').swap_buf_right", desc = "Swap to right" },
  },
}
