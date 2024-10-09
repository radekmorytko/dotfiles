local M = {}

---@param input string
---@param n integer
local function remove_trailing_chars(input, n)
  assert(n > 0, "n must be positive")
  assert(#input > 1 and n <= #input, "input must contain at least one character")
  return string.sub(input, 1, -1 - n)
end

---@param input string
local function remove_last_character(input)
  assert(#input > 1, "input must contain at least one character")
  return remove_trailing_chars(input, 1)
end

---@param file_path string
M.relative_path = function(file_path)
  -- result :: table
  -- { code = 0, signal = 0, stdout = 'hello', stderr = '' }
  local result = vim.system(
    {"git", "ls-files", file_path},
    { text = true }
  ):wait()
  if result.code ~= 0 then
    error("Git command error: " .. result.stderr)
  end
  return remove_last_character(result.stdout)
end

---@param file_path string
M.latest_commit_that_modified = function(file_path)
  -- result :: table
  -- { code = 0, signal = 0, stdout = 'hello', stderr = '' }
  local result = vim.system(
    {"git", "log", "-n", "1", "--format=%H", file_path},
    { text = true }
  ):wait()
  if result.code ~= 0 then
    error("Git command error: " .. result.stderr)
  end
  -- `result.stdout` contains a trailing newline
  return remove_last_character(result.stdout)
end

-- assumption: we are in the git repo
-- example return value: "git@github.com:radekmorytko/dotfiles.git"
M.remote_origin_url = function()
  local result = vim.system(
    {"git", "config", "--get", "remote.origin.url"},
    { text = true }
  ):wait()
  if result.code ~= 0 then
    error("Git command error: " .. result.stderr)
  end
  return result.stdout
end

M.github_repo_url = function()
  local origin_url = M.remote_origin_url()
  local origin_url_without_dot_git_suffix = string.sub(
    origin_url,
    1,
    -1 - 5 -- get rid of '.git' suffix
  )
  local origin_url_without_leading_github_prefix = string.sub(
    origin_url_without_dot_git_suffix,
    1 + 15, -- get rid of 'git@github.com:'
    -1
  )
  return "https://github.com/" .. origin_url_without_leading_github_prefix
end

return M
