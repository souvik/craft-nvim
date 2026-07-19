-- Resolve the correct ruby-lsp for whatever Ruby the current project uses.
--
-- We deliberately avoid Mason's ruby-lsp: Mason installs it into an isolated
-- GEM_HOME that Bundler 4 refuses to launch from inside ruby-lsp's composed
-- bundle ("bundler: command not found: ruby-lsp"), so indexing never runs and
-- go-to-definition returns no results.
--
-- Instead we read the project's .ruby-version and launch the matching RVM
-- wrapper (~/.rvm/wrappers/ruby-<version>/ruby-lsp), which self-sources that
-- Ruby's environment and works regardless of how Neovim was launched. If no
-- wrapper is found (e.g. a non-RVM machine) we fall back to `ruby-lsp` on PATH.
--
-- Per-project requirement: `rvm use <version> && gem install ruby-lsp` once per
-- Ruby version you work with, so a real ruby-lsp gem + wrapper exists for it.
local function project_root()
  return vim.fs.root(0, { ".ruby-version", "Gemfile", ".git" }) or vim.fn.getcwd()
end

local function ruby_lsp_bin(root)
  local version_file = root .. "/.ruby-version"
  if vim.fn.filereadable(version_file) == 1 then
    local version = vim.trim(vim.fn.readfile(version_file)[1] or "")
    version = version:gsub("^ruby%-", ""):gsub("@.*$", "") -- "ruby-3.4.8@gs" -> "3.4.8"
    if version ~= "" then
      local wrapper = vim.fn.expand("~/.rvm/wrappers/ruby-" .. version .. "/ruby-lsp")
      if vim.fn.executable(wrapper) == 1 then
        return { wrapper }
      end
    end
  end
  return { "ruby-lsp" } -- fallback: rely on the active Ruby on PATH
end

return {
  -- Function form re-resolves per server start, so opening projects on
  -- different Ruby versions in one session each get the right ruby-lsp.
  --
  -- We force the spawn `cwd` to the project root: ruby-lsp locates the bundle
  -- (and thus what to index) from its working directory, and Neovim otherwise
  -- launches the server with whatever directory `nvim` was started from. Without
  -- this, starting nvim outside the project root leaves the index empty, so
  -- go-to-definition silently returns nothing even though the server is running.
  cmd = function(dispatchers)
    local root = project_root()
    return vim.lsp.rpc.start(ruby_lsp_bin(root), dispatchers, { cwd = root })
  end,
  ---@type lspconfig.settings.ruby_lsp
  init_options = {
    formatter = "standardrb",
    linters = { "standardrb" },
  },
}
