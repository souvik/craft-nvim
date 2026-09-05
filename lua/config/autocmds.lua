-- ========================================================
-- Title: Neovim autocmds
-- About: Editor autocommands
-- ========================================================

-- Format on save using the attached LSP (only if it supports formatting).
-- For Ruby this runs standardrb via ruby-lsp; other filetypes use their server.
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client or not client:supports_method("textDocument/formatting") then
      return
    end

    -- Per-buffer group so re-attaching clients don't stack duplicate autocmds;
    -- the last formatting-capable client wins for this buffer.
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("lsp_format_on_save_" .. args.buf, { clear = true }),
      buffer = args.buf,
      callback = function()
        if vim.b[args.buf].disable_autoformat or vim.g.disable_autoformat then
          return
        end
        vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 2000 })
      end,
    })
  end,
})

-- Commands to toggle LSP format-on-save. Pass a bang (!) to affect only the
-- current buffer; without it the change is global.
vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, { bang = true, desc = "Disable format on save (! = current buffer only)" })

vim.api.nvim_create_user_command("FormatEnable", function(args)
  if args.bang then
    vim.b.disable_autoformat = false
  else
    vim.g.disable_autoformat = false
    vim.b.disable_autoformat = false
  end
end, { bang = true, desc = "Re-enable format on save (! = current buffer only)" })

-- Commands to hide diagnostic virtual text (e.g. when a file has too many
-- diagnostics). Pass a bang (!) to affect only the current buffer; without it
-- the change is global. M.diagnostic.show() forces an immediate redraw so the
-- change applies without moving the cursor.
local function redraw_virtual_text()
  vim.diagnostic.show()
end

vim.api.nvim_create_user_command("VirtualTextDisable", function(args)
  if args.bang then
    vim.b.diagnostic_virtual_text = false
  else
    vim.g.diagnostic_virtual_text = false
  end
  redraw_virtual_text()
end, { bang = true, desc = "Hide diagnostic virtual text (! = current buffer only)" })

vim.api.nvim_create_user_command("VirtualTextEnable", function(args)
  if args.bang then
    vim.b.diagnostic_virtual_text = nil
  else
    vim.g.diagnostic_virtual_text = nil
    vim.b.diagnostic_virtual_text = nil
  end
  redraw_virtual_text()
end, { bang = true, desc = "Show diagnostic virtual text (! = current buffer only)" })
