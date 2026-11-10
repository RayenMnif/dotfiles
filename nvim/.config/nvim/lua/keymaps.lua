-- Agents
local function launch_agent(cmd)
  vim.cmd("vsplit | terminal " .. cmd)
  vim.cmd("startinsert")
end
vim.keymap.set("n", "<leader>oc", function() launch_agent("opencode") end, { desc = "OpenCode Agent" })
vim.keymap.set("n", "<leader>cd", function() launch_agent("codex") end, { desc = "Codex Agent" })
vim.keymap.set("t", "<C-\\><C-\\>", "<C-\\><C-n>", { desc = "Leave terminal mode" })

local timer = nil

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    if not timer then
      timer = vim.uv.new_timer()
      -- Polls every 250ms while in terminal mode
      timer:start(0, 250, vim.schedule_wrap(function()
        -- Force check all buffers for disk changes
        vim.cmd("checktime")
      end))
    end
  end,
})

vim.api.nvim_create_autocmd("TermClose", {
  pattern = "*",
  callback = function()
    if timer then
      timer:stop()
      timer:close()
      timer = nil
    end
  end,
})


-- Terminal
local function OpenTerm()
  vim.cmd("botright 15split | terminal")
  vim.cmd("startinsert")
end
vim.keymap.set("n", "<leader>tt", OpenTerm, { desc = "Terminal (bottom)" })
vim.keymap.set("n", "<C-j>", OpenTerm, { desc = "Terminal (bottom)" })

vim.keymap.set("n", "<leader>tv", function()
  vim.cmd("botright vsplit | terminal")
  vim.cmd("startinsert")
end, { desc = "Terminal (right)" })

vim.keymap.set("t", "<C-d>", "<C-\\><C-n><cmd>close<CR>", { desc = "Close terminal window" })
