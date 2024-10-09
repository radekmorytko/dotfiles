-- NOTE this file is loaded automatically

vim.api.nvim_create_user_command(
  "GitPermalink",
  function(opts)
    local permalink = require("git-permalink")
    local result = permalink(
      vim.api.nvim_buf_get_name(0),
      opts.line1,
      opts.line2
    )
    -- copy to clipboard
    vim.fn.setreg("+", result)
  end,
  {
    range = true
  }
)
