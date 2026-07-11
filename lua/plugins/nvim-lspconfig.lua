return {
  { "mason-org/mason.nvim", opts = {} },
  { "neovim/nvim-lspconfig" },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      { "neovim/nvim-lspconfig" },
    },
    init = function()
      require("utils.diagnostics").setup()
    end,
    opts = {},
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
    },
    opts = {
      ensure_installed = {
        "luacheck",
        "lua_ls",
        "stylua",
        "ruby_lsp",
        "ts_ls",
        "eslint",
        "prettier",
        "html",
        "css-lsp",
        "yamlls",
        "jsonls",
      },
    },
  },
}
