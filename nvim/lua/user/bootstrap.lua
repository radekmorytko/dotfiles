local function safely_clone()
  local path = vim.fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'
  if vim.fn.empty(vim.fn.glob(path)) > 0 then
    vim.fn.system {
      'git',
      'clone',
      '--depth=1',
      'https://github.com/savq/paq-nvim.git',
      path
    }
  end
end

local function initialize()
  safely_clone()
  vim.cmd('packadd paq-nvim')

  local paq = require('paq')
  local packages = require('user.packages')
  paq(packages)

  return paq
end

local function bootstrap()
  local paq = initialize()

  -- Exit nvim after installing plugins
  vim.cmd('autocmd User PaqDoneInstall quit')

  paq.install()
end

return {
    bootstrap = bootstrap,
    initialize = initialize,
    safely_clone = safely_clone
}
