
vim.api.nvim_set_keymap('i', '<C-j>', '<Nop>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('i', '<CR>', 'pumvisible() ? coc#_select_confirm() : "\\<C-g>u\\<CR>\\<c-r>=coc#on_enter()\\<CR>"', { expr = true })


vim.api.nvim_set_keymap('n', '<leader>gg', ':LazyGit<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>tf', ':ToggleTerm direction=float <CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>t', ':ToggleTerm size=15 <CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>nt', ':tabnew<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ct', ':tabnew<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-Tab>', ':tabnext<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>f', ':NvimTreeToggle<CR>', { noremap = true, silent = true })




-- Define your Lua function
function RunBuildProcess()
    vim.cmd('BuildMeStop')
    vim.cmd('tabnew')
    vim.cmd('BuildMe')
end

-- Set up a Vim keybinding to call the Lua function
vim.api.nvim_set_keymap('n', '<Leader><F10>', [[:lua RunBuildProcess()<CR>]], { noremap = true, silent = true })
-- recommended mappings
-- resizing splits
-- these keymaps will also accept a range,
-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
vim.keymap.set('n', '<A-h>', require('smart-splits').resize_left)
vim.keymap.set('n', '<A-j>', require('smart-splits').resize_down)
vim.keymap.set('n', '<A-k>', require('smart-splits').resize_up)
vim.keymap.set('n', '<A-l>', require('smart-splits').resize_right)
-- moving between splits
vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)
-- swapping buffers between windows
vim.keymap.set('n', '<leader><leader>h', require('smart-splits').swap_buf_left)
vim.keymap.set('n', '<leader><leader>j', require('smart-splits').swap_buf_down)
vim.keymap.set('n', '<leader><leader>k', require('smart-splits').swap_buf_up)
vim.keymap.set('n', '<leader><leader>l', require('smart-splits').swap_buf_right)



vim.api.nvim_set_keymap('n', '<leader>..', [[:e <c-r>=expand("%:p:h")<cr>/]], { noremap = true, silent = true })

