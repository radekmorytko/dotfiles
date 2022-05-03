-- meta-accessors: https://github.com/nanotee/nvim-lua-guide#using-meta-accessors
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.scrolloff = 8


vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true -- search will be case-sensitive if it contains an uppercase letter. ignorecase must be enabled
vim.o.hlsearch = false -- disable search highlighting AFTER the search has been performed

vim.o.splitright = true

vim.api.nvim_set_option('enc', 'utf8')

vim.opt.listchars = { trail = "·", tab = "→ " } -- Display trailing space when writing
vim.o.list = true

vim.opt.clipboard:append { "unnamedplus" }

vim.o.showcmd = true -- Display an incomplete command in the lower right corner of the Vim window

vim.g.mapleader = " "

local paq_utils = require('user.bootstrap')
paq_utils.initialize()

vim.opt.completeopt = { 'menuone','noinsert','noselect' }

--" indentation for yaml files
--autocmd Filetype yaml setlocal tabstop=2 shiftwidth=2 expandtab

--" configuration for python files
--autocmd Filetype python setlocal tabstop=4 shiftwidth=4 expandtab softtabstop=4 textwidth=79 colorcolumn=80

--vim.cmd 'autocmd BufRead,BufNewFile *.ex,*.exs,mix.lock set filetype=elixir'

-- Colorscheme settings

vim.g.gruvbox_material_background = "medium"
vim.cmd('colorscheme gruvbox-material')

-- Terraform
vim.g.terraform_align = true
vim.g.terraform_fmt_on_save = true

-- LSP
local lsp_on_attach = function(client, bufnr)
  require('completion').on_attach()

  -- Mappings for LSP
  local opts = { noremap=true, silent=true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'v', 'ga', ':<C-U>lua vim.lsp.buf.range_code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gm', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<c-k>',  '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
end

--require 'lspconfig'.pyright.setup {
    --on_attach=lsp_on_attach
--}

-- tree-sitter
require('nvim-treesitter.configs').setup {
    ensure_installed = { "python", "elixir" },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true
    },
    incremental_selection = {
      enable = true
  }
}

-- Status line (lualine)
-- plugin: lualine
-- https://github.com/hoob3rt/lualine.nvim
-- Steps to install a font that supports icons: 
-- * download a font from https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraMono/Regular/complete/Fura%20Mono%20Regular%20Nerd%20Font%20Complete%20Mono.otf
-- * install the font in OS. In ubuntu: a) move the font to `/usr/share/fonts/opentype/` directory and b) refresh the cache `sudo fc-cache -f -v`
require('lualine').setup {
  options = {
    theme = 'gruvbox-material',
  };
}

-- Telescope configuration
require('telescope').setup {
    defaults = {
        color_devicons = true,

        file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
        grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
        qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = true,
            override_file_sorter = true,
        }
    }
}
require('telescope').load_extension('fzy_native')

-- Mappings for Telescope
vim.api.nvim_set_keymap('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>ag', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>bf', [[<cmd>lua require('telescope.builtin').file_browser()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fw', [[<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.expand('<cword>') })<cr>]], { noremap = true, silent = true})
-- Git
vim.api.nvim_set_keymap('n', '<leader>gf', [[<cmd>lua require('telescope.builtin').git_files()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gc', [[<cmd>lua require('telescope.builtin').git_commits()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gb', [[<cmd>lua require('telescope.builtin').git_branches()<cr>]], { noremap = true, silent = true})


-- Open new line below and above current line
vim.api.nvim_set_keymap('n',  '<leader>o', 'o<esc>', {noremap=true})
vim.api.nvim_set_keymap('n',  '<leader>O', 'O<esc>', {noremap=true})

-- Fugitive
vim.api.nvim_set_keymap('n',  '<leader>G', ':G<CR>', {noremap=true})
