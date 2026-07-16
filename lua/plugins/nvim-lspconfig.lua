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
        opts = {
          signature = { enabled = true },
        },
        dependencies = { "rafamadriz/friendly-snippets" },
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      { "neovim/nvim-lspconfig" },
    },
    opts = {
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup({})
        end,
      },
    },
    init = function()
      require("utils.diagnostics").setup()
    end,
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
