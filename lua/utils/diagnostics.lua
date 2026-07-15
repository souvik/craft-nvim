local M = {}

M.setup = function()
  vim.diagnostic.config({
    severity_sort = true,
    update_in_insert = false,
    float = {
      border = "rounded",
      source = "if_many",
    },
    virtual_text = {
      spacing = 2,
      source = "if_many",
      prefix = '●',
    },
    signs = {
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
