return {
  ---@type lspconfig.settings.lua_ls
  settings = {
    Lua = {
      workspace = {
        library = {
          "$VIMRUNTIME/lua",
          "$VIMRUNTIME/lua/vim/lsp",
          "$VIMRUNTIME/lua/vim/treesitter",
          vim.fn.stdpath("data") .. "/lazy/snacks.nvim",
          vim.fn.stdpath("data") .. "/lazy/nvim-lspconfig",
        },
        checkThirdParty = false,
      },
      diagnostics = {
        globals = { "vim", "Snacks" }
      },
    },
  },
}
