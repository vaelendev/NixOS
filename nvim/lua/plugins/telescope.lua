return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<C-f>", builtin.find_files, { desc = "Find files" })
    vim.keymap.set("n", "<C-t>", builtin.live_grep,  { desc = "Live grep" })
    vim.keymap.set("n", "<C-b>", builtin.buffers,    { desc = "Find buffers" })
    vim.keymap.set("n", "<C-h>", builtin.help_tags,  { desc = "Help tags" }) 
  end,
}
