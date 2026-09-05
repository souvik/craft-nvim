local M = {}

M.setup = function()
  vim.diagnostic.config({
    severity_sort = true,
    update_in_insert = false,
    float = {
      border = "rounded",
      source = "if_many",
    },
    ---@return vim.diagnostic.Opts.VirtualText | boolean
    virtual_text = function(_, bufnr)
      if vim.g.diagnostic_virtual_text == false then
        return false
      end
      if vim.b[bufnr].diagnostic_virtual_text == false then
        return false
      end
      return {
        spacing = 2,
        source = "if_many",
        prefix = '●',
      }
    end,
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
