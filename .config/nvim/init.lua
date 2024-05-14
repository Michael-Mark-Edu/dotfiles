vim.cmd([[
" Put vimscript commands in here

" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Declare the list of plugins.
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'prabirshrestha/async.vim'
" Plug 'prabirshrestha/vim-lsp'
" Plug 'mattn/vim-lsp-settings'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'github/copilot.vim'
Plug 'numToStr/Comment.nvim'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" " This is needed for lsp to work with C(++)
" if executable('clangd')
"     augroup lsp_clangd
"         autocmd!
"         autocmd User lsp_setup call lsp#register_server({
"                     \ 'name': 'clangd',
"                     \ 'cmd': {server_info->['clangd']},
"                     \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
"                     \ })
"         autocmd FileType c setlocal omnifunc=lsp#complete
"         autocmd FileType cpp setlocal omnifunc=lsp#complete
"         autocmd FileType objc setlocal omnifunc=lsp#complete
"         autocmd FileType objcpp setlocal omnifunc=lsp#complete
"     augroup end
" endif

" Tabs and numbers
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
set number
]])

-- Put lua commands out here

-- Single-line requires
require('gitsigns').setup()
require('Comment').setup()
require('lualine')

-- Telescope binds
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Lsp config
require('lspconfig').clangd.setup{}
require('lspconfig').lua_ls.setup{
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
}

-- Nvim-tree config
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup()

-- Lualine config
local lualine = require('lualine')

lualine.setup {
    options = {
        theme = 'auto',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        always_divide_middle = false
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'filename', 'searchcount', 'selectioncount', 'diff', {
            'diagnostics',
            sources = {'nvim_lsp'},
            always_visible = false
        }},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {'location', 'filesize', 'filetype'},
        lualine_z = {}
    },
    tabline = {
        lualine_a = {},
        lualine_b = {{
            'buffers',
            max_length = vim.o.columns,
            buffers_color = {
                active = {fg = '#000000', bg = '#839496'},
                inactive = {fg = '#839496', bg = '#000000'}
            },
            symbols = {
                alternate_file = ''
            }
        }},
        lualine_c = {},
        lualine_X = {},
        lualine_y = {},
        lualine_z = {}
    },
}

lualine.refresh()

local cmp = require('cmp')
cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })

-- My binds
vim.g.mapleader = ' '
vim.keymap.set('n', '<Tab>', ":bnext<CR>", {})
vim.keymap.set('n', '<S-Tab>', ":bprev<CR>", {})
vim.keymap.set('n', '<leader>q', ":q<CR>", {})
vim.keymap.set('n', '<leader>w', ":w<CR>", {})
vim.keymap.set('n', '<leader>x', ":x<CR>", {})
vim.keymap.set('n', '<leader>qq', ":qa<CR>", {})
vim.keymap.set('n', '<leader>ww', ":wa<CR>", {})
vim.keymap.set('n', '<leader>xx', ":xa<CR>", {})
vim.keymap.set('n', '<leader>b', ":bd<CR>", {})
vim.keymap.set('n', '<leader><S-Tab>', ":bd<CR>", {})
vim.keymap.set('n', '<leader><Tab>', ":tabe<CR>:edit ", {})
vim.keymap.set('n', '<leader>n', ":tabe<CR>", {})
vim.keymap.set('n', '<leader>\\', ":wa!<CR>:source ~/dotfiles/.config/nvim/init.lua<CR>", {})
vim.keymap.set('n', '/<esc>', ":nohlsearch<CR>", {})

vim.keymap.set('i', '<C-S-right>', function()
    vim.fn['copilot#Accept']("")
    local bar = vim.fn['copilot#TextQueuedForInsertion']()
    return bar:sub(1, 1)
end, {expr = true, remap = false})

vim.keymap.set('i', '<C-right>', function()
    vim.fn['copilot#Accept']("")
    local bar = vim.fn['copilot#TextQueuedForInsertion']()
    return vim.fn.split(bar,  [[[ .\(\)\<\>]\zs]])[1]
end, {expr = true, remap = false})

