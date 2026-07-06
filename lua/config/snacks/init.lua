return vim.tbl_deep_extend("force",
  require("config.snacks.enabled"),
  {
    dashboard = require("config.snacks.dashboard"),
    explorer = require("config.snacks.explorer"),
    notifier = require("config.snacks.notifier"),
  }
)
