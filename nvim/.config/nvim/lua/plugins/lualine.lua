return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      globalstatus = true,
      icons_enabled = true,
      section_separators = "",
      component_separators = "│",
      theme = "tomorrow_night",
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch" },
      lualine_c = { { "filename", path = 1 } },
      lualine_x = { "diagnostics" },
      lualine_y = { "filetype" },
      lualine_z = { "location" },
    },
  },
}
