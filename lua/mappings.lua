-- OverseerRun
vim.keymap.set('n', '<F3>', "<cmd>OverseerGRun<cr>", { noremap = true, silent = true })
vim.keymap.set('n', '<F4>', "<cmd>OverseerToggle<cr>", { noremap = true, silent = true })

-- ctags remap
vim.keymap.set('n', '<F12>', "<C-]>", {silent = true})
vim.keymap.set('n', '<S-F12>', "<C-W>v<C-]>", {silent = true})
vim.keymap.set('n', '<F10>', "<C-O>", {silent = true})

-- Clangd
vim.keymap.set('n', '<C-F8>', "<Cmd>ClangdSwitchSourceHeader<CR>", {silent = true})
vim.keymap.set('n', '<C-F9>', "<Cmd>ClangdAST<CR>", {silent = true})
vim.keymap.set('n', '<C-F10>', "<Cmd>ClangdTypeHierarchy<CR>", {silent = true})
vim.keymap.set('n', '<C-F11>', "<Cmd>ClangdMemoryUsage<CR>", {silent = true})
vim.keymap.set('n', '<C-F12>', "<Cmd>ClangdSymbolInfo<CR>", {silent = true})

vim.keymap.set("n", "<C-K>", function() 
        vim.lsp.buf.format({ async = true })
        vim.notify("Whole document is formatted", "info")
    end, { desc = "Format with Clang" })
vim.keymap.set("v", "<C-L>", function()
        -- Get the selected range
        local start_line = vim.fn.line("'<") - 1  -- Convert to 0-based index
        local end_line = vim.fn.line("'>")        -- 1-based index (exclusive in set_lines)
    
        -- Get the selected text
        local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line, false)
        if #lines == 0 then
            vim.notify("No lines selected.", "error")
            return
        end
    
        -- Detect leading indentation from the first selected line
        local first_line = lines[1]
        local leading_spaces = first_line:match("^(%s*)") or ""
    
        -- Join lines into a single string
        local text = table.concat(lines, "\n")
    
        -- Run clang-format on the selection
        local formatted_text = vim.fn.system("clang-format ", text)
    
        if formatted_text and formatted_text ~= "" then
            -- Split the formatted output into lines
            local formatted_lines = vim.split(formatted_text, "\n", { trimempty = false })

            -- Reapply the original indentation to each line
            for i = 1, #formatted_lines do
              formatted_lines[i] = leading_spaces .. formatted_lines[i]
            end

            -- Replace the selected text with the properly indented formatted text
            vim.api.nvim_buf_set_lines(0, start_line, end_line, false, formatted_lines)
        else
            vim.notify("clang-format returned empty output.", "error")
        end
        vim.notify("Selected block is formatted successfully", "info")
    end, { desc = "Format selection with Clang using Ctrl+L" })
  
  

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
vim.keymap.set("n", "<S-F1>", function() require("telescope").extensions.file_browser.file_browser() end)

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

-- multicursor
vim.keymap.set("n", "<C-A-Up>", function() require("multicursor-nvim").lineAddCursor(-1) end)
vim.keymap.set("n", "<C-A-Down>", function() require("multicursor-nvim").lineAddCursor(1) end)
vim.keymap.set("n", "<C-A-Left>", function() require("multicursor-nvim").lineSkipCursor(-1) end)
vim.keymap.set("n", "<C-A-Right>", function() require("multicursor-nvim").lineSkipCursor(1) end)
vim.keymap.set("n", "<C-S-A-Up>", function() require("multicursor-nvim").matchAddCursor(-1) end)
vim.keymap.set("n", "<C-S-A-Down>", function() require("multicursor-nvim").matchAddCursor(1) end)
vim.keymap.set("n", "<C-S-A-Left>", function() require("multicursor-nvim").matchSkipCursor(-1) end)
vim.keymap.set("n", "<C-S-A-Right>", function() require("multicursor-nvim").matchSkipCursor(1) end)
vim.keymap.set("n", "<C-A-End>", function() 
    if require("multicursor-nvim").hasCursors() then
        vim.notify("Cursors removed", "info")
        require("multicursor-nvim").clearCursors()
    end
end)

-- lsp
vim.keymap.set("i", "<C-K>", function() require("noice.lsp").scroll(1) end)
vim.keymap.set("i", "<C-J>", function() require("noice.lsp").scroll(-1) end)