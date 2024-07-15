require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")

-- codium
map("i", "<C-g>", function()
  return vim.fn["codeium#Accept"]()
end, { expr = true })

map("n", "<leader>ce", "<cmd>CodeiumEnable<CR>", { desc = "Enable Codeium autocompletion" })
map("n", "<leader>cd", "<cmd>CodeiumDisable<CR>", { desc = "Disable Codeium autocompletion" })
map("n", "<leader>ci", "<cmd>CodeiumInfo<CR>", { desc = "Show Codeium info" })

-- quick file saving via space-w
map("n", "<leader>w", "<cmd> w <cr>", { desc = "Save file" })

-- close all tabs
map("n", "<leader>cx", function()
  require("nvchad.tabufline").closeAllBufs()
end, { desc = "Close All Buffers" })

-- alt-[1-9] switch tab
for i = 1, 9, 1 do
  vim.keymap.set("n", string.format("<A-%s>", i), function()
    vim.api.nvim_set_current_buf(vim.t.bufs[i])
  end)
end

-- vim like window switcher
map({ "n", "v" }, "<c-h>", "<cmd> TmuxNavigateLeft<CR>", { desc = "Windows Left" })
map({ "n", "v" }, "<c-l>", "<cmd> TmuxNavigateRight<CR>", { desc = "Windows Right" })
map({ "n", "v" }, "<c-j>", "<cmd> TmuxNavigateDown<CR>", { desc = "Windows Down" })
map({ "n", "v" }, "<c-k>", "<cmd> TmuxNavigateUp<CR>", { desc = "Windows Up" })

-- home/end
map({ "n", "v" }, "L", "$", { desc = "End of line" })
map({ "n", "v" }, "H", "^", { desc = "Start of line" })

-- disable arrows
map("", "<Up>", "<Nop>")
map("", "<Down>", "<Nop>")
map("", "<Left>", "<Nop>")
map("", "<Right>", "<Nop>")
