vim.keymap.set({ "i", "v", "n" }, "²", "<Esc>", { desc = "Escape" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "s", "<Nop>")

vim.keymap.set("n", "<M-v>", "<cmd>Oil<CR>", { desc = "File explorer" })

vim.keymap.set("n", "<leader>w", "<cmd>w<CR>",    { desc = "Save" })
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>",    { desc = "Quit" })
vim.keymap.set("n", "<leader>m", "<cmd>make<CR>", { desc = "Make" })

vim.keymap.set("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "Split vertical" })
vim.keymap.set("n", "<leader>sh", "<cmd>split<CR>",  { desc = "Split horizontal" })

vim.keymap.set("n", "<leader>bn", "<cmd>bnext<CR>",     { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Prev buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>",   { desc = "Close buffer" })

vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next,  { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev,  { desc = "Prev diagnostic" })
vim.keymap.set("n", "<leader>e",  vim.diagnostic.open_float, { desc = "Diagnostic float" })
vim.diagnostic.config({ virtual_text = true })
