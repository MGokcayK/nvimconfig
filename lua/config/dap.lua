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

config = {
    icons = { expanded = "", collapsed = "", current_frame = "" },
    mappings = {
      -- Use a table to apply multiple mappings
      expand = { "<CR>", "<2-LeftMouse>" },
      open = "o",
      remove = "d",
      edit = "e",
      repl = "r",
      toggle = "t",
    },
    element_mappings = {},
    expand_lines = vim.fn.has("nvim-0.7") == 1,
    force_buffers = true,
    layouts = {
      {
        -- You can change the order of elements in the sidebar
        elements = {
          -- Provide IDs as strings or tables with "id" and "size" keys
          {
            id = "scopes",
            size = 0.50, -- Can be float or integer > 1
          },
          { id = "watches", size = 0.30 },
          { id = "stacks", size = 0.10 },
          { id = "breakpoints", size = 0.10 },
        },
        size = 40,
        position = "left", -- Can be "left" or "right"
    },
    {
        elements = {
            { id = "console", size = 0.70 },
            { id = "repl", size = 0.30 },
        },
        size = 20,
        position = "bottom", -- Can be "bottom" or "top"
      },
    },
    floating = {
      max_height = nil,
      max_width = nil,
      border = "single",
      mappings = {
        ["close"] = { "q", "<Esc>" },
      },
    },
    controls = {
      enabled = vim.fn.exists("+winbar") == 1,
      element = "repl",
      icons = {
        pause = "",
        play = "",
        step_into = "",
        step_over = "",
        step_out = "",
        step_back = "",
        run_last = "",
        terminate = "",
        disconnect = "",
      },
    },
    render = {
      max_type_length = nil, -- Can be integer or nil.
      max_value_lines = 100, -- Can be integer or nil.
      indent = 1,
    },
}

dapui.setup(config)

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
    --console = "externalTerminal",
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
dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
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