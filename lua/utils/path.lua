-- ========================================================
-- Title: Path helpers
-- About: Buffer paths rendered relative to the project rather than $HOME.
--        Neovim's built-in messages (<C-g>, :file) run every buffer name
--        through home_replace(), which hardcodes a `~` prefix with no option
--        to disable it. These helpers resolve a project root instead, using
--        the same cwd -> root fallback LazyVim's `pretty_path` uses.
-- ========================================================

local M = {}

-- Directories that mark a project root when no LSP client claims the buffer.
-- `lua` is here so this config repo itself resolves without a git checkout.
local root_patterns = { ".git", "lua" }

---@type table<number, string>
local cache = {}

-- The root can move under a buffer: a language server attaches late, a write
-- creates the marker directory, or the user :cd's. Drop the entry and let the
-- next lookup redo the work.
vim.api.nvim_create_autocmd({ "LspAttach", "BufWritePost", "DirChanged", "BufEnter" }, {
  group = vim.api.nvim_create_augroup("path_root_cache", { clear = true }),
  callback = function(args)
    cache[args.buf] = nil
  end,
})

---@param path string?
---@return string?
local function normalize(path)
  if path == nil or path == "" then
    return nil
  end
  return vim.fs.normalize(path)
end

--- Strips `dir` from the front of `path`, or nil when `path` is not below it.
--- The trailing separator matters: without it `/foo/barbaz` would match a
--- prefix of `/foo/bar` and yield the nonsense remainder `az`.
---@param path string
---@param dir string?
---@return string?
local function strip_prefix(path, dir)
  if not dir then
    return nil
  end
  dir = dir:gsub("/+$", "")
  if path:sub(1, #dir + 1) == dir .. "/" then
    return path:sub(#dir + 2)
  end
end

--- Workspace folders and root dirs of the servers attached to `buf`, keeping
--- only those that actually contain the file. The longest match wins so a
--- nested project beats the monorepo it sits in.
---@param buf number
---@param bufpath string
---@return string?
local function lsp_root(buf, bufpath)
  local roots = {}

  for _, client in pairs(vim.lsp.get_clients({ bufnr = buf })) do
    for _, ws in pairs(client.config.workspace_folders or {}) do
      roots[#roots + 1] = vim.uri_to_fname(ws.uri)
    end
    if client.root_dir then
      roots[#roots + 1] = client.root_dir
    end
  end

  roots = vim.tbl_filter(function(root)
    return strip_prefix(bufpath, root) ~= nil
  end, vim.tbl_map(normalize, roots))

  table.sort(roots, function(a, b)
    return #a > #b
  end)

  return roots[1]
end

--- Nearest ancestor directory containing one of `root_patterns`.
---@param bufpath string
---@return string?
local function pattern_root(bufpath)
  local marker = vim.fs.find(root_patterns, { path = vim.fs.dirname(bufpath), upward = true })[1]
  return marker and normalize(vim.fs.dirname(marker))
end

--- Absolute, normalized path of a buffer. Nil for unnamed and scratch buffers.
---@param buf? number
---@return string?
function M.absolute(buf)
  return normalize(vim.api.nvim_buf_get_name(buf or 0))
end

--- Project root for a buffer: attached LSP servers, then a marker directory,
--- then the cwd as a last resort.
---@param buf? number
---@return string?
function M.root(buf)
  local bufnr = buf or 0
  if bufnr == 0 then
    bufnr = vim.api.nvim_get_current_buf()
  end

  if not cache[bufnr] then
    local bufpath = M.absolute(bufnr)
    cache[bufnr] = (bufpath and (lsp_root(bufnr, bufpath) or pattern_root(bufpath))) or normalize(vim.uv.cwd())
  end

  return cache[bufnr]
end

--- Buffer path relative to the cwd, falling back to the project root when the
--- file sits outside it (nvim launched from elsewhere), and to the absolute
--- path when it belongs to neither.
---@param buf? number
---@return string?
function M.relative(buf)
  local path = M.absolute(buf)
  if not path then
    return nil
  end

  return strip_prefix(path, normalize(vim.uv.cwd())) or strip_prefix(path, M.root(buf)) or path
end

return M
