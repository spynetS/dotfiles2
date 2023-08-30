
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup(require("plugins"), {})

vim.o.relativenumber = true
vim.cmd('command! Refresh lua refresh_config()')
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- plugin setup
require("plugins/telescope")
require("plugins/treesitter")
require("plugins/lsp")
require("plugins/nvim-cmp")
require("plugins/colorizer")
require("plugins/pretty-fold")
require("plugins/nvim-tree")
require("plugins/smart-split")

require("keybindings")

require('cmp').setup({
  sources = {
    { name = 'buffer' },
  },
})

require'cmp'.setup {
  sources = {
    { name = 'path' }
  }
}


vim.opt.termguicolors = true


vim.g.neovide_scale_factor = 1.0
local change_scale_factor = function(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end
vim.keymap.set("n", "<C-=>", function()
  change_scale_factor(1.1)
end)
vim.keymap.set("n", "<C-->", function()
  change_scale_factor(1/1.1)
end)

local set = vim.opt -- set options
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4

------ compiling ------

local compiling = false
function MyLuaFunction()

  if compiling == true then
    vim.cmd('BuildMeStop')
    vim.cmd('tabnew')
    vim.cmd('BuildMe')
    compiling = false
  end
end

function BuildMeOpenEdit()
    vim.cmd('belowright split')
    vim.cmd('resize 5')
    vim.cmd('edit .buildme.sh')
    compiling = true
end

vim.cmd[[
    augroup RunCommandAutocmd
        autocmd!
        autocmd BufEnter * lua MyLuaFunction()
    augroup END
]]

vim.api.nvim_set_keymap('n', '<leader>cc', ':lua BuildMeOpenEdit()<CR>', { noremap = true, silent = true })

