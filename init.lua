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

