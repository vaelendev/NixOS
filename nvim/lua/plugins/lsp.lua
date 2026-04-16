return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "j-hui/fidget.nvim",
  },
  config = function()
    require("mason").setup()
    require("fidget").setup({})
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local opts = { buffer = args.buf }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, opts)
      end,
    })

    -- Rust
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "rust",
      callback = function()
        vim.lsp.start({
          name = "rust-analyzer",
          cmd = { "rust-analyzer" },
          root_dir = vim.fs.root(0, { "Cargo.toml" }),
          capabilities = capabilities,
          settings = {
            ["rust-analyzer"] = {
              cargo = { allFeatures = true },
              check = { command = "clippy" },
            },
          },
        })
      end,
    })

    -- C/C++
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "c", "cpp" },
      callback = function()
        vim.lsp.start({
          name = "clangd",
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--completion-style=detailed",
            "--header-insertion=iwyu",
          },
          root_dir = vim.fs.root(0, { "compile_commands.json", ".git" }),
          capabilities = capabilities,
        })
      end,
    })

    -- Zig
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "zig",
      callback = function()
        vim.lsp.start({
          name = "zls",
          cmd = { "/home/vaelen/.zig/zls/zig-out/bin/zls" },
          root_dir = vim.fs.root(0, { "build.zig", ".git" }),
          capabilities = capabilities,
        })
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
    pattern = { "glsl", "vert", "frag" },
    callback = function()
        vim.lsp.start({
            name = "glsl_analyzer",
            cmd = { "glsl_analyzer" },
            root_dir = vim.fs.root(0, { ".git" }),
            capabilities = capabilities,
        })
        end,
    })
  end,
}
