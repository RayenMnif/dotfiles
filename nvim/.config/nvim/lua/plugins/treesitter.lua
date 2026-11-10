return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local treesitter = require("nvim-treesitter")
      treesitter.setup({})
      treesitter.install({
        "c",
        "cpp",
        "lua",
        "vim",
        "vimdoc",
        "javascript",
        "python",
      })

      local filetypes = {
        c = true,
        cpp = true,
        lua = true,
        vim = true,
        vimdoc = true,
        javascript = true,
        python = true,
        help = true, -- Neovim maps help to the vimdoc parser
      }

      local augroup = vim.api.nvim_create_augroup("UserTreesitter", { clear = true })

      local function start(buf)
        if not vim.api.nvim_buf_is_loaded(buf) then
          return
        end

        local ft = vim.bo[buf].filetype
        if not filetypes[ft] then
          return
        end

        local lang = vim.treesitter.language.get_lang(ft) or ft
        local ok, err = pcall(vim.treesitter.start, buf, lang)
        if not ok then
          vim.notify(
            ("Tree-sitter could not start for %s (%s): %s"):format(ft, lang, err),
            vim.log.levels.WARN
          )
        end
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = augroup,
        pattern = vim.tbl_keys(filetypes),
        callback = function(args)
          start(args.buf)
        end,
      })

      -- Buffers whose filetype was set before this config loaded may not emit
      -- FileType again when they are eventually displayed; retry on display.
      vim.api.nvim_create_autocmd("BufWinEnter", {
        group = augroup,
        callback = function(args)
          start(args.buf)
        end,
      })

      -- Also start highlighting for buffers that already existed when this
      -- config was loaded (for example, buffers restored before Lazy setup).
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        start(buf)
      end
    end,
  },
}
