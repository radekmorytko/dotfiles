local git = require("git-permalink.git")

local function permalink(absolute_file_path, line1, line2)
  local commit_sha = git.latest_commit_that_modified(absolute_file_path)
  local line_suffix = line1 == line2 and ("#L" .. line1) or ("#L" .. line1 .. "-L" .. line2)
  return git.github_repo_url()
    .. "/blob/"
    .. commit_sha
    .. "/"
    .. git.relative_path(absolute_file_path)
    .. line_suffix
end

return permalink
