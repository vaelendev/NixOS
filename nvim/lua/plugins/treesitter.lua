return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local parsers = require("nvim-treesitter.parsers")
    parsers.get_parser_configs().cpp = {
      install_info = {
        url = "https://github.com/taku25/tree-sitter-unreal-cpp",
        revision = "7bbb85f1fcc6e109c90cea2167e88a5a472910d3",
        files = { "src/parser.c", "src/scanner.c" },
      },
      filetype = "cpp",
    }
    parsers.get_parser_configs().ushader = {
      install_info = {
        url = "https://github.com/taku25/tree-sitter-unreal-shader",
        revision = "26f0617475bb5d5accb4d55bd4cc5facbca81bbd",
        files = { "src/parser.c" },
      },
      filetype = "ushader",
    }
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "rust", "lua", "vim", "vimdoc", "markdown", "zig", "json", "cpp", "ushader", "glsl" },
      sync_install = false,
      auto_install = true,
      highlight = { enable = true, additional_vim_regex_highlighting = false },
      indent = { enable = true },
    })
  end,
}
