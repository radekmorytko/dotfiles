-- meta-accessors: https://github.com/nanotee/nvim-lua-guide#using-meta-accessors
vim.g.mapleader = " "

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.scrolloff = 8

vim.opt.colorcolumn = "100" -- show a vertical ruler at the specified column

vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true -- search will be case-sensitive if it contains an uppercase letter. ignorecase must be enabled
vim.o.hlsearch = false -- disable search highlighting AFTER the search has been performed

vim.o.splitright = true

vim.api.nvim_set_option('enc', 'utf8')

vim.opt.listchars = { trail = "·", tab = "→ ", leadmultispace = "   ·"} -- Display trailing space when writing
vim.o.list = true

vim.opt.clipboard:append { "unnamedplus" }

vim.o.showcmd = true -- Display an incomplete command in the lower right corner of the Vim window


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

-- tree-sitter
require('nvim-treesitter.configs').setup {
  ensure_installed = { "python", "elixir", "lua" },
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true
  },
  autopairs = {
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
  pickers = {
    buffers = {
      mappings = {
        i = {
          ['<C-d>'] = require('telescope.actions').delete_buffer
        },
        n = {
          ['<C-d>'] = require('telescope.actions').delete_buffer
        },
      }
    }
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = true,
      override_file_sorter = true,
    }
  }
}
require('telescope').load_extension('fzy_native')

-- MAPPINGS

-- Modes:
-- "n" - normal
-- "i" - insert
-- "v" - visual
-- "x" - visual block
-- "t" - term
-- "c" - command

-- Terminal
vim.keymap.set('t', '<esc>', '<C-\\><C-n>')


-- Telescope
--
-- find files
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files)

local set_keymap_if_env_var = function(env_name, mapping, f)
  if os.getenv(env_name) then
    vim.keymap.set(
      'n',
      mapping,
      f
    )
  end
end

local find_files_in_matching_env_var = function(env_name, mapping)
  local f = function()
    require('telescope.builtin').find_files({ search_dirs = {os.getenv(env_name)} })
  end
  return set_keymap_if_env_var(env_name, mapping, f)
end

local grep_files_in_matching_env_var = function(env_name, mapping)
  local f = function()
    require('telescope.builtin').live_grep({ search_dirs = {os.getenv(env_name)} })
  end
  return set_keymap_if_env_var(env_name, mapping, f)
end

local grep_word_in_matching_env_var = function(env_name, mapping)
  local f = function()
    require('telescope.builtin').grep_string({
      search = vim.fn.expand('<cword>'),
      search_dirs = {os.getenv(env_name)}
    })
  end
  return set_keymap_if_env_var(env_name, mapping, f)
end


-- find in sources
find_files_in_matching_env_var('NVIM_SRC_DIR', '<leader>fs')
-- find in tests
find_files_in_matching_env_var('NVIM_TEST_DIR', '<leader>ft')

-- grep in sources
grep_files_in_matching_env_var('NVIM_SRC_DIR', '<leader>gs')
-- grep in tests
grep_files_in_matching_env_var('NVIM_TEST_DIR', '<leader>gt')

-- grep everywhere
vim.keymap.set('n', '<leader>gg', require('telescope.builtin').live_grep)

-- grep word under the cursor everywhere
--vim.keymap.set('n', '<leader>ggw',
--  function()
--    require('telescope.builtin').grep_string({
--      search = vim.fn.expand('<cword>')
--    })
--  end
--)

-- grep word (under cursor) in sources
grep_word_in_matching_env_var('NVIM_SRC_DIR', '<leader>gws')
grep_word_in_matching_env_var('NVIM_TEST_DIR', '<leader>gwt')


-- find buffers
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers)

-- Open new line below and above current line
vim.keymap.set('n', '<leader>o', 'o<esc>')
vim.keymap.set('n', '<leader>O', 'O<esc>')

-- Fugitive
vim.keymap.set('n', '<leader>Gg', ':G<CR>')
vim.keymap.set('n', '<leader>Gs', require('telescope.builtin').git_status)

-- LSP
--vim.lsp.set_log_level("info")

local lsp_on_attach = function(client, bufnr)
  local nmap = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end
  nmap('<leader>rn', vim.lsp.buf.rename, '[r]e[n]ame')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

  -- Mappings for LSP
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', ':lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K',  ':lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', ':lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gm', ':lua vim.lsp.buf.implementation()<CR>', opts)

  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ga', ':lua vim.lsp.buf.code_action()<CR>', opts)

  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>vd', ':lua vim.diagnostic.open_float()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', ':lua vim.diagnostic.goto_prev({border="rounded"})<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', ':lua vim.diagnostic.goto_next({border="rounded"})<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'v', 'ga', ':<C-U>lua vim.lsp.buf.range_code_action()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<c-k>',  '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
end

local servers = {
  pyright = {
    cmd = { "pyright-langserver", "--stdio", "--verbose" },
    settings = {
      python = {
        pythonPath = '.venv/bin/python'
      }
    }
  },
  elixirls = {},
  lua_ls = {},
}

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'
mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

local capabilities = require('cmp_nvim_lsp').default_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      on_attach = lsp_on_attach,
      cmd = servers[server_name]['cmd'],
      settings = servers[server_name]['settings'],
      capabilities = capabilities,
    }
  end,
  ["elixirls"] = function()
    require('lspconfig').elixirls.setup {}
  end,
}


-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- nvim-tree
require("nvim-tree").setup()
