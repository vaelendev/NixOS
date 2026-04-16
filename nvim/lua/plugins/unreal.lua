return {
  "taku25/UnrealDev.nvim",
  dependencies = {
    { "taku25/UNL.nvim", build = "cargo build --release --manifest-path scanner/Cargo.toml", lazy = false },
    "taku25/UEP.nvim",
    "taku25/UEA.nvim",
    "taku25/UBT.nvim",
    "taku25/UCM.nvim",
    "taku25/ULG.nvim",
    "taku25/USH.nvim",
    "taku25/UNX.nvim",
    "MunifTanjim/nui.nvim",
    "taku25/UDB.nvim",
    { "taku25/USX.nvim", lazy = false },
    "nvim-telescope/telescope.nvim",
    "j-hui/fidget.nvim",
  },
  opts = {
    setup_modules = {
      UBT = true, UEP = true, ULG = true,
      USH = true, UCM = true, UEA = true, UNX = true,
    },
  },
  config = function(_, opts)
    require("UnrealDev").setup(opts)
    local api = require("UnrealDev.api")
    vim.keymap.set("n", "<leader>ub", function() if api.build then api.build({}) end end, { desc = "UE: Build" })
    vim.keymap.set("n", "<leader>udb", function() vim.cmd("UDEV gencompiledb") end, { desc = "UE: compile_commands.json" })
    vim.keymap.set("n", "<leader>un", function() if api.new_class then api.new_class({}) end end, { desc = "UE: Nouvelle classe" })
    vim.keymap.set("n", "<leader>oo", function()
      if api.switch_file then api.switch_file({ current_file_path = vim.api.nvim_buf_get_name(0) }) end
    end, { desc = "UE: Basculer H/CPP" })
    vim.keymap.set("n", "<leader>uf", function() if api.files then api.files({}) end end, { desc = "UE: Explorer fichiers" })
    vim.keymap.set("n", "<leader>ul", function() vim.cmd("UDEV start_log") end, { desc = "UE: Output Log" })
    vim.keymap.set("n", "<leader>ut", function() vim.cmd("UDEV tree") end, { desc = "UE: Vue projet" })
    vim.keymap.set("n", "<leader>ur", function() vim.cmd("UDEV refresh") end, { desc = "UE: Rescanner" })
  end,
}
