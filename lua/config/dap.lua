local utils = require("utils")
local codelldb_path = ""
if utils.executable("codelldb") then
    if vim.g.is_win then
        codelldb_path = vim.fn.substitute(vim.fn.exepath("codelldb"), ".exe$", "", "g")
    else
        codelldb_path = vim.fn.exepath("codelldb")
    end
else
    vim.api.nvim_err_writeln("codelldb executable not found! You must install codelldb and set its PATH correctly!")
    return
end

require("dap-python").setup(vim.g.python3_host_prog)

local dap = require('dap')
local dapui = require("dapui")
dapui.setup()

dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'codelldb',
    request = 'launch',
    program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
}

dap.adapters.codelldb = {
    type = "executable",
    command = codelldb_path, -- or if not in $PATH: "/absolute/path/to/codelldb"
    -- On windows you may have to uncomment this:
    -- detached = false,
}

-- open Dap UI automatically when debug starts 
dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end

-- close dapui
vim.api.nvim_create_user_command("DapCloseUI", function()
    require("dapui").close()
end, {})

-- use <Alt-e> to eval expressions
vim.keymap.set({ 'n', 'v' }, '<M-e>', function() require('dapui').eval() end)

local sign = vim.fn.sign_define

sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
sign('DapStopped', { text = '', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })

-- Define your color table
local C = {
    grey = "#505050", -- Replace with your desired grey color
}

-- Set the highlight group
vim.api.nvim_set_hl(0, 'DapStopped', { bg = C.grey })