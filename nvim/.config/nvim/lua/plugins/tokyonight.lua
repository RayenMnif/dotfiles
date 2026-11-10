return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000, -- Load colorscheme early on startup
  opts = {
    transparent = true, -- Enable transparent background
    styles = {
      sidebars = "transparent", -- Keep sidebars (NvimTree, Neo-tree, etc.) transparent
      floats = "transparent",   -- Keep floating windows transparent
    },
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd("colorscheme tokyonight")
  end,
}
