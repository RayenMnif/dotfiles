return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Telescope",   -- only loads when you run :Telescope
  keys = {
    { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find files" },
    { "<leader>fg", function() require("telescope.builtin").live_grep() end,  desc = "Live grep" },
    { "<leader>fb", function() require("telescope.builtin").buffers() end,    desc = "Buffers" },
    { "<leader>fh", function() require("telescope.builtin").help_tags() end,  desc = "Help tags" },
    -- optional extras
    { "<leader>fr", function() require("telescope.builtin").oldfiles() end,     desc = "Recent files" },
    { "<leader>fd", function() require("telescope.builtin").diagnostics() end,  desc = "Diagnostics" },
    { "<leader>/",  function() require("telescope.builtin").current_buffer_fuzzy_find() end, desc = "Search in buffer" },
},
  opts = {
    defaults = {
      layout_config = { prompt_position = "top" },
      sorting_strategy = "ascending",
      file_ignore_patterns = { "node_modules", "%.git/" },
    },
  },
}
