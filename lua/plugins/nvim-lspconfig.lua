return {
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "saghen/blink.cmp",
        version = "1.*",
        dependencies = { "L3MON4D3/LuaSnip" },
        ---@module "blink.cmp"
        ---@type blink.cmp.Config
        opts = require("config.blink"),
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      { "neovim/nvim-lspconfig" },
    },
    opts = {},
    init = function()
      require("utils.diagnostics").setup()
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "VeryLazy",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
    },
    opts = {
      ensure_installed = {
        "luacheck",
        "lua_ls",
        "stylua",
        "ruby_lsp",
        "standardrb",
        "ts_ls",
        "eslint",
        "prettier",
        "html",
        "cssls",
        "yamlls",
        "jsonls",
      },
    },
  },
}
