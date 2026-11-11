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
local term_buf = nil

local function TermJobAlive(buf)
  if not (buf and vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == "terminal") then
    return false
  end
  local job = vim.b[buf].terminal_job_id
  if not job then
    return false
  end
  -- jobwait with a 0ms timeout returns -1 while the job is still running
  local ok, result = pcall(vim.fn.jobwait, { job }, 0)
  return ok and result[1] == -1
end

local function FindTermWin(buf)
  if not (buf and vim.api.nvim_buf_is_valid(buf)) then
    return nil
  end
  -- Search every window, not just the current tab
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == buf then
      return win
    end
  end
  return nil
end

local ToggleTerm

local function OpenTerm()
  vim.cmd("botright 15split | terminal")
  term_buf = vim.api.nvim_get_current_buf()
  vim.b[term_buf].bottom_term = true
  -- Buffer-local so other terminals (agents) still receive <C-j>
  vim.keymap.set("t", "<C-j>", ToggleTerm, { buffer = term_buf, desc = "Toggle terminal (bottom)" })
  vim.cmd("startinsert")
end

function ToggleTerm()
  local win = FindTermWin(term_buf)
  if win then
    if #vim.api.nvim_list_wins() > 1 then
      vim.api.nvim_win_close(win, true)
    else
      vim.cmd("enew")
    end
    return
  end

  -- Re-show the same terminal if its shell is still running
  if TermJobAlive(term_buf) then
    vim.cmd("botright 15split")
    vim.api.nvim_win_set_buf(0, term_buf)
    vim.cmd("startinsert")
    return
  end

  -- The old shell exited; drop its buffer and start a fresh terminal
  if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
    vim.api.nvim_buf_delete(term_buf, { force = true })
    term_buf = nil
  end
  OpenTerm()
end

vim.api.nvim_create_autocmd("BufWipeout", {
  pattern = "*",
  callback = function(args)
    if args.buf == term_buf then
      term_buf = nil
    end
  end,
})

vim.keymap.set("n", "<leader>tt", ToggleTerm, { desc = "Toggle terminal (bottom)" })
vim.keymap.set("n", "<C-j>", ToggleTerm, { desc = "Toggle terminal (bottom)" })

vim.keymap.set("n", "<leader>tv", function()
  vim.cmd("botright vsplit | terminal")
  vim.cmd("startinsert")
end, { desc = "Terminal (right)" })

vim.keymap.set("t", "<C-d>", "<C-\\><C-n><cmd>close<CR>", { desc = "Close terminal window" })
