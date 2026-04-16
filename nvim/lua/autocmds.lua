vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    local ue_extensions = { "h", "cpp", "hpp" }
    local ext = vim.fn.expand("%:e")
    local is_ue_project = vim.fs.root(0, { "compile_commands.json", "*.uproject" }) ~= nil
    if is_ue_project and vim.tbl_contains(ue_extensions, ext) then
      return
    end
  end,
})
