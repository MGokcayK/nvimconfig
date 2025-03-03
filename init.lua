-- This is my personal Nvim configuration based on https://github.com/jdhao/nvim-config
vim.loader.enable()

-- install packages
require("packages")

--- load utils module
local utils = require("utils")

--- check version
local expected_version = "0.10.3"
utils.is_compatible_version(expected_version)

--- get config directory
local config_dir = vim.fn.stdpath("config")
---@cast config_dir string

-- global settings
require("globals")

-- setting options in nvim
vim.cmd("source " .. vim.fs.joinpath(config_dir, "vims/options.vim"))

-- lsp 
require("config.lsp")

-- overseer
require("config.overseer")

-- nvim-dap
require("config.dap")

-- telescope
require('telescope').setup({ 
    defaults = { 
        vimgrep_arguments = { 
            'rg', '--hidden', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case' 
        }
    },
    pickers = {
        find_files = {
            hidden = true,
            -- needed to exclude some files & dirs from general search
            -- when not included or specified in .gitignore
            find_command = {
                "rg",
                "--files",
                "--hidden",
                "--glob=!**/.git/*",
                "--glob=!**/.idea/*",
                "--glob=!**/.vscode/*",
                "--glob=!**/dist/*",
                "--glob=!**/yarn.lock",
                "--glob=!**/package-lock.json",
            },
        },
    },
})
require("telescope").load_extension "file_browser"

-- mappings 
require("mappings")

-- noice and notify
require("config.noice_notify")