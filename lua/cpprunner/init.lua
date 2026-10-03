local M = {}

-- Default plugin options
M.opts = {
  keymap = "<F11>",
  compiler = "g++",
  std = "c++17",
  extra_flags = "-Wall",
  split_height = 15,
}

local term_buf = nil

function M.compile_and_run()
  vim.cmd("silent write")

  local file = vim.fn.expand("%:p")
  local file_dir = vim.fn.expand("%:p:h")
  local filename_no_ext = vim.fn.expand("%:t:r")

  local is_windows = vim.fn.has("win32") == 1
  local binary_ext = is_windows and ".exe" or ""
  local output_bin = file_dir .. "/" .. filename_no_ext .. binary_ext

  local compile_cmd = string.format(
    "%s -std=%s %s %s -o %s",
    M.opts.compiler,
    M.opts.std,
    M.opts.extra_flags,
    vim.fn.shellescape(file),
    vim.fn.shellescape(output_bin)
  )

  vim.fn.jobstart(compile_cmd, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_exit = function(_, code, _)
      if code ~= 0 then
        vim.notify("Compilation failed!", vim.log.levels.ERROR)
        return
      end

      if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
        vim.api.nvim_buf_delete(term_buf, { force = true })
      end

      vim.cmd(string.format("botright split | resize %d | terminal %s", M.opts.split_height, vim.fn.shellescape(output_bin)))
      term_buf = vim.api.nvim_get_current_buf()
      vim.cmd("startinsert")
    end,
  })
end

function M.setup(user_opts)
  M.opts = vim.tbl_deep_extend("force", M.opts, user_opts or {})

  if M.opts.keymap then
    vim.keymap.set("n", M.opts.keymap, M.compile_and_run, { desc = "Compile and Run C++" })
  end

  vim.api.nvim_create_user_command("CppRunner", M.compile_and_run, { desc = "Compile and Run C++ file" })
end

return M
