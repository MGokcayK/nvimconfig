-- OverseerRun
vim.keymap.set('n', '<F3>', "<cmd>OverseerRun<cr>", { noremap = true, silent = true })
vim.keymap.set('n', '<F4>', "<cmd>OverseerToggle<cr>", { noremap = true, silent = true })

-- ctags remap
vim.keymap.set('n', '<F12>', "<C-]>", {silent = true})
vim.keymap.set('n', '<F10>', "<C-O>", {silent = true})

-- -- Clangd
vim.keymap.set('n', '<C-F8>', "<Cmd>ClangdSwitchSourceHeader<CR>", {silent = true})
vim.keymap.set('n', '<C-F9>', "<Cmd>ClangdAST<CR>", {silent = true})
vim.keymap.set('n', '<C-F10>', "<Cmd>ClangdTypeHierarchy<CR>", {silent = true})
vim.keymap.set('n', '<C-F11>', "<Cmd>ClangdMemoryUsage<CR>", {silent = true})
vim.keymap.set('n', '<S-F12>', "<Cmd>ClangdSymbolInfo<CR>", {silent = true})

-- quit via ESC key
vim.keymap.set("t", "<Esc>", [[<c-\><c-n>]])

-- nvim-tree open 
vim.keymap.set('n', '<F1>', "<Cmd>NvimTreeOpen<CR>", {silent = true})

-- nvim dap mappings
local dap = require("dap")
vim.keymap.set('n', '<F6>', function() dap.step_over() end)
vim.keymap.set('n', '<F7>', function() dap.step_into() end)
vim.keymap.set('n', '<F8>', function() dap.step_out() end)
vim.keymap.set('n', '<F9>', function() dap.toggle_breakpoint() end)
vim.keymap.set('n', '<F5>', function() dap.continue() end)
vim.keymap.set('n', '<S-F5>', function() dap.close() vim.cmd("DapCloseUI") end)
vim.keymap.set('n', '<S-F6>', function() dap.close() end)