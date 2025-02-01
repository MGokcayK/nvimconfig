-- OverseerRun
vim.keymap.set('n', '<F5>', "<cmd>OverseerRun<cr>", { noremap = true, silent = true })
vim.keymap.set('n', '<F6>', "<cmd>OverseerToggle<cr>", { noremap = true, silent = true })

-- Clangd
vim.keymap.set('n', '<F12>', "<Cmd>ClangdSwitchSourceHeader<CR>", {silent = true})
vim.keymap.set('n', '<F10>', "<Cmd>ClangdSymbolInfo<CR>", {silent = true})
vim.keymap.set('n', '<F9>', "<Cmd>ClangdAST<CR>", {silent = true})
vim.keymap.set('n', '<F8>', "<Cmd>ClangdTypeHierarchy<CR>", {silent = true})
vim.keymap.set('n', '<F7>', "<Cmd>ClangdMemoryUsage<CR>", {silent = true})

-- quit via ESC key
vim.keymap.set("t", "<Esc>", [[<c-\><c-n>]])

-- nvim-tree open 
vim.keymap.set('n', '<F1>', "<Cmd>NvimTreeOpen<CR>", {silent = true})
