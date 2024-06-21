require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- add yours here

map({"n", "v"}, "<c-h>", "<cmd> TmuxNavigateLeft<CR>", { desc = "Windows Left"})
map({"n", "v"}, "<c-l>", "<cmd> TmuxNavigateRight<CR>", { desc = "Windows Right"})
map({"n", "v"}, "<c-j>", "<cmd> TmuxNavigateDown<CR>", { desc = "Windows Down"})
map({"n", "v"}, "<c-k>", "<cmd> TmuxNavigateUp<CR>", { desc = "Windows Up"})
