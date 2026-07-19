return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    version = false,
    build = ":TSUpdate",
    config = function()
      local ensure_installed = {
        "ruby", "embedded_template", "rust", "python",
        "typescript", "tsx", "javascript", "json",
        "html", "css", "scss", "bash", "dockerfile",
        "yaml", "zsh"
      }
      local treesitter = require("nvim-treesitter")

      treesitter.setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
      })

      treesitter.install(ensure_installed)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function(args)
          local buf = args.buf
          local ft = vim.bo[buf].filetype

          local lang = vim.treesitter.language.get_lang(ft)
          if not lang then
            return
          end

          local ok_add = pcall(vim.treesitter.language.add, lang)
          if not ok_add then
            return
          end

          pcall(vim.treesitter.start, buf, lang)
        end,
      })
    end
  },
}
