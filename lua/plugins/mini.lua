return {
  {
    "nvim-mini/mini.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons", opts = {} },
    },
    version = "*",
    config = function()
      require("mini.ai").setup({})
      require("mini.pairs").setup({})
      require("mini.diff").setup({})
      require("mini.git").setup({})
      require("mini.icons").setup({})
      require("mini.statusline").setup({})
    end,
  },
}
