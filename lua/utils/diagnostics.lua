local M = {}

M.setup = function()
  vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Line diagnostics" })

  vim.diagnostic.config({
    signs = {
      active = true,
      text = {
        [vim.diagnostic.severity.ERROR] = " ",
        [vim.diagnostic.severity.WARN] = " ",
        [vim.diagnostic.severity.INFO] = " ",
        [vim.diagnostic.severity.HINT] = " ",
      },
    },
  })
end

return M
