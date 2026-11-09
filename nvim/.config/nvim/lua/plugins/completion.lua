return {
  "saghen/blink.cmp",
  dependencies = { "saghen/blink.lib" },
  build = function()
    require("blink.cmp").build():pwait()
  end,
  event = "InsertEnter",
  opts = {
    keymap = {
        preset = "enter",
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    },
    sources = { default = { "lsp", "path", "snippets", "buffer" } },
  },
}
