return vim.tbl_deep_extend("force",
  require("config.snacks.enabled"),
  {
    dashboard = require("config.snacks.dashboard"),
    explorer = require("config.snacks.explorer"),
    input = require("config.snacks.input"),
    notifier = require("config.snacks.notifier"),
  }
)
