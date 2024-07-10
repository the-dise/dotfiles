require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- quick file saving via ctrl+s
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- vim like window switcher
map({ "n", "v" }, "<c-h>", "<cmd> TmuxNavigateLeft<CR>", { desc = "Windows Left" })
map({ "n", "v" }, "<c-l>", "<cmd> TmuxNavigateRight<CR>", { desc = "Windows Right" })
map({ "n", "v" }, "<c-j>", "<cmd> TmuxNavigateDown<CR>", { desc = "Windows Down" })
map({ "n", "v" }, "<c-k>", "<cmd> TmuxNavigateUp<CR>", { desc = "Windows Up" })

-- home/end
map({ "n", "v" }, "L", "$", { desc = "End of line" })
map({ "n", "v" }, "H", "^", { desc = "Start of line" })

