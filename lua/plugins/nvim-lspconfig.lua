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
    config = function()
      vim.lsp.enable("tsc")
    end,
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
        "eslint",
        "prettier",
        "typescript-language-server",
        "html",
        "cssls",
        "yamlls",
        "jsonls",
        "helm-ls",
        "kube-linter",
      },
    },
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        "~/.config/nvim",
      },
      enabled = function()
        return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
      end,
    },
    {
      "qvalentin/helm-ls.nvim",
      ft = "helm",
      opts = {
        -- leave empty or see below
      },
    },
  },
}
