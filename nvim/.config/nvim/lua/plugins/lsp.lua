return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      {
        "mason-org/mason-lspconfig.nvim",
        opts = {
          -- change these to the languages you actually use
          ensure_installed = { "lua_ls", "pyright" },
        },
      },
      "saghen/blink.cmp",
    },
    config = function()
      -- give every server completion support
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })

      -- stop lua_ls complaining about the `vim` global
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = { diagnostics = { globals = { "vim" } } },
        },
      })

      vim.diagnostic.config({ virtual_text = true })
    end,
  },
}
