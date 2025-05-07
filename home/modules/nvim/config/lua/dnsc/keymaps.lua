local opts = { noremap = true, silent = true, expr = true }

-- Non-leader general keybindings
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", opts)
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", opts)
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move up" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Move to next occurence" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Move to next occurence" })
vim.keymap.set("n", "<C-f>", "<Nop>")