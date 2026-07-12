return {
  -- Snacks Explorer keymaps
  { "<leader>e", function() Snacks.explorer() end, desc = "File explorer" },
  { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command history" },
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
  -- LSP
  { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
  { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
  { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
  { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
  { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
  { "gai", function() Snacks.picker.lsp_incoming_calls() end, desc = "C[a]lls Incoming" },
  { "gao", function() Snacks.picker.lsp_outgoing_calls() end, desc = "C[a]lls Outgoing" },
  { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
  { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
}
