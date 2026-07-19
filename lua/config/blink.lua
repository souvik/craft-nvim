return {
  keyword = "full",
  completion = {
    menu = {
      -- Automatically show completion menu
      auto_show = true,

      draw = {
        columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },
        treesitter = { "lsp" },
      }
    },
    trigger = {
      show_on_insert_on_trigger_character = true,
    },
    list = {
      selection = { preselect = false, auto_insert = true },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 500,
    },
  },
  fuzzy = {
    implementation = "prefer_rust_with_warning",
  },
}
