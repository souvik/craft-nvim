-- ========================================================
-- Title: Neovim keymaps
-- About: Sets some quality of life keymaps
-- ========================================================

local map = vim.keymap.set
local path = require("utils.path")

-- Replaces selected text without losing what you yanked
map("x", "p", [["_dP]], { desc = "Paste over selection without losing yanked test" })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move Lines
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- location list
map("n", "<leader>xl", function()
  local success, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
  if not success and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = "Location List" })

-- quickfix list
map("n", "<leader>xq", function()
  local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
  if not success and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = "Quickfix List" })
map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- File paths
-- Rebuilds the native <C-g> message. The built-in prints a `~`-relative name
-- and offers no way to change that, so we print the project-relative one.
map("n", "<C-g>", function()
  local file = path.relative()
  if not file then
    return vim.api.nvim_echo({ { "[No Name]" } }, false, {})
  end

  local parts = { ('"%s"'):format(file) }
  if vim.bo.modified then
    table.insert(parts, "[Modified]")
  end
  if vim.bo.readonly then
    table.insert(parts, "[RO]")
  end

  local lines = vim.api.nvim_buf_line_count(0)
  local cursor = vim.api.nvim_win_get_cursor(0)[1]
  table.insert(parts, ("%d line%s --%d%%--"):format(lines, lines == 1 and "" or "s", math.floor(cursor * 100 / lines)))

  vim.api.nvim_echo({ { table.concat(parts, " ") } }, false, {})
end, { desc = "File Info (Project Relative)" })

local function copy(file, title)
  if not file then
    return vim.notify("Buffer has no file", vim.log.levels.WARN)
  end
  vim.fn.setreg("+", file)
  vim.notify(file, vim.log.levels.INFO, { title = title })
end

map("n", "<leader>fp", function()
  copy(path.relative(), "Copied Relative Path")
end, { desc = "Copy Relative Path" })

map("n", "<leader>fP", function()
  copy(path.absolute(), "Copied Absolute Path")
end, { desc = "Copy Absolute Path" })

-- Diagnostics
map("n", "<leader>sd", vim.diagnostic.open_float, { desc = "Line diagnostic" })
-- Clear search highlight on Esc
map("n", "<Esc>", "<cmd>nohlsearch<cr><Esc>", { desc = "Clear search highlight" })
