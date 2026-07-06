return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      width = 60,
      row = nil,
      col = nil,
      preset = {
        ---@type fun(cmd:string, opts:table)|nil
        pick = nil,
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
      },
      formats = {
        header = { "%s", align = "center" },
      },
      sections = {
        { section = "header" },
        { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
        { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { section = "startup" },
      },
    },
    explorer = {
      enabled = true,
      replace_netrw = true,
      auto_close = true,
    },
    indent = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
      width = { min = 40, max = 0.4 },
      height = { min = 1, max = 0.6 },
      margin = { top = 0, right = 1, bottom = 0 },
      padding = true,
      gap = 0,
      sort = { "level", "added" },
      level = vim.log.levels.TRACE,
      icons = {
        error = " ",
        warn = " ",
        info = " ",
        debug = " ",
        trace = " ",
      },
      keep = function(notif)
        return vim.fn.getcmdpos() > 0
      end,
      ---@type snacks.notifier.style
      style = "compact",
      top_down = true,
      date_format = "%R",
      ---@type string|boolean
      more_format = " ↓ %d lines ",
      refresh = 50,
    },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
  keys = {
    -- Lazygit keymaps
    -- Snacks Explorer keymaps
    { "<leader>e", function() Snacks.explorer() end, desc = "File explorer" },
    { "<leader>:", function() Snacks.picker.command_histroy() end, desc = "Command history" },
    -- Snacks Lazygit keymaps
    { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
    { "<leader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit: log view" },
    { "<leader>gL", function() Snacks.lazygit.log_file() end, desc = "Lazygit: current file log" },
    -- Snacks Picker keymaps
    { "<leader>ff", function() Snacks.picker.files() end, desc = "File picker" },
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "File buffer picker" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent file picker" },

    { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
    { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },

    { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
    { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
    { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
    { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
    { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
    { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },

    { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete current buffer" },
    { "<leader>bD", function() Snacks.bufdelete.all() end, desc = "Delete all buffers" },
    { "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete all buffers except current" },
  },
}
