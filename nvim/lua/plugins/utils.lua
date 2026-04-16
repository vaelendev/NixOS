return {
  { "lewis6991/gitsigns.nvim", config = true },
  { "numToStr/Comment.nvim", config = true },
  { "windwp/nvim-autopairs", config = true },
  { "folke/which-key.nvim", config = true },
  {
    "vyfor/cord.nvim",
    build = ":Cord update",
    event = "VeryLazy",
    opts = {
      log_level = "error",
      editor = { client = "neovim", tooltip = "The Superior Text Editor" },
      display = { show_time = true, show_repository = true, theme = "catppuccin", flavor = "dark" },
      idle = { enable = true, timeout = 300000, text = "Idle", tooltip = "💤" },
      text = {
        viewing = function(opts) return "Viewing " .. opts.filename end,
        editing = function(opts) return "Editing " .. opts.filename end,
      },
    },
  },
}
