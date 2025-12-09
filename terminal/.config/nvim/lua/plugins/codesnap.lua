return {
  "mistricky/codesnap.nvim",
  tag = "v2.0.0-beta.17",
  build = "make",
  lazy = true,
  cmd = { "CodeSnap", "CodeSnapSave", "CodeSnapHighlight", "CodeSnapHighlightSave", "CodeSnapSaveTo", "CodeSnapHighlightSaveTo" },
  config = function()
    require("codesnap").setup({})

    local function get_save_path()
      local env_dir = os.getenv("CODE_SNAP_DIR")
      local save_dir = env_dir

      if not save_dir or vim.fn.isdirectory(save_dir) == 0 then
        save_dir = os.getenv("HOME") .. "/Downloads"
      end

      -- Ensure no trailing slash before appending
      if save_dir:sub(-1) == "/" then
        save_dir = save_dir:sub(1, -2)
      end

      local timestamp = os.date("%Y%m%d%H%M")
      return string.format("%s/%s.png", save_dir, timestamp)
    end

    vim.api.nvim_create_user_command("CodeSnapSaveTo", function()
      local path = get_save_path()
      vim.cmd("CodeSnapSave " .. path)
      print("CodeSnap saved to " .. path)
    end, {})

    vim.api.nvim_create_user_command("CodeSnapHighlightSaveTo", function(opts)
      local path = get_save_path()
      if opts.range ~= 0 then
        vim.cmd(opts.line1 .. "," .. opts.line2 .. "CodeSnapHighlightSave " .. path)
      else
        vim.cmd("CodeSnapHighlightSave " .. path)
      end
      print("CodeSnap highlight saved to " .. path)
    end, { range = true })
  end,
}
