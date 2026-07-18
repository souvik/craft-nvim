return {
  {
    "nvim-mini/mini.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons", opts = {} },
    },
    version = "*",
    config = function()
      require("mini.ai").setup()
      require("mini.surround").setup()
      require("mini.pairs").setup()
      require("mini.icons").setup()
    end,
  },
}
