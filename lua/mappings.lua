-- OverseerRun
vim.keymap.set('n', '<F3>', "<cmd>OverseerRun<cr>", { noremap = true, silent = true })
vim.keymap.set('n', '<F4>', "<cmd>OverseerToggle<cr>", { noremap = true, silent = true })

-- ctags remap
vim.keymap.set('n', '<F12>', "<C-]>", {silent = true})
vim.keymap.set('n', '<F10>', "<C-O>", {silent = true})

-- Clangd
vim.keymap.set('n', '<C-F8>', "<Cmd>ClangdSwitchSourceHeader<CR>", {silent = true})
vim.keymap.set('n', '<C-F9>', "<Cmd>ClangdAST<CR>", {silent = true})
vim.keymap.set('n', '<C-F10>', "<Cmd>ClangdTypeHierarchy<CR>", {silent = true})
vim.keymap.set('n', '<C-F11>', "<Cmd>ClangdMemoryUsage<CR>", {silent = true})
vim.keymap.set('n', '<C-F12>', "<Cmd>ClangdSymbolInfo<CR>", {silent = true})

-- quit via ESC key
vim.keymap.set("t", "<Esc>", [[<c-\><c-n>]])

-- nvim dap mappings
local dap = require("dap")
vim.keymap.set('n', '<F6>', function() dap.step_over() end)
vim.keymap.set('n', '<F7>', function() dap.step_into() end)
vim.keymap.set('n', '<F8>', function() dap.step_out() end)
vim.keymap.set('n', '<F9>', function() dap.toggle_breakpoint() end)
vim.keymap.set('n', '<F5>', function() dap.continue() end)
vim.keymap.set('n', '<S-F5>', function() dap.close() vim.cmd("DapCloseUI") end)
vim.keymap.set('n', '<S-F6>', function() dap.close() end)

-- telescope mapping
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<F1>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<F2>', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<C-F>', builtin.grep_string, { desc = 'Telescope grep string' })
vim.keymap.set('n', '<C-F1>', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<C-F2>', builtin.help_tags, { desc = 'Telescope help tags' })

-- window mapping
vim.keymap.set('n', '<Space>6', "<C-W>5>", { noremap = true, desc = 'resize window to right with 5 steps' })
vim.keymap.set('n', '<Space>4', "<C-W>5<", { noremap = true, desc = 'resize window to left with 5 steps' })
vim.keymap.set('n', '<Space>2', "<C-W>5+", { noremap = true, desc = 'resize window to up with 5 steps' })
vim.keymap.set('n', '<Space>8', "<C-W>5-", { noremap = true, desc = 'resize window to down with 5 steps' })
vim.keymap.set('n', '<Space>5', "<Cmd>:vsplit<CR>", { noremap = true, desc = 'vertical split window' })
vim.keymap.set('n', '<Space>0', "<Cmd>:split<CR>", { noremap = true, desc = 'horizontal split window' })
vim.keymap.set('n', '<Space><UP>', "<C-W><UP>", { noremap = true, desc = 'move cursor to above window' })
vim.keymap.set('n', '<Space><DOWN>', "<C-W><DOWN>", { noremap = true, desc = 'move cursor to below window' })
vim.keymap.set('n', '<Space><LEFT>', "<C-W><LEFT>", { noremap = true, desc = 'move cursor to left window' })
vim.keymap.set('n', '<Space><RIGHT>', "<C-W><RIGHT>", { noremap = true, desc = 'move cursor to right window' })
