local lspconfig = require('lspconfig')

-- setup cmp 
local cmp = require('cmp')
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local types = require('cmp.types')

cmp.setup {
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    window = {
        complation = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping =  cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ['<CR>'] = cmp.mapping.confirm({ select = true })
    }),
    sources = {
        {name = 'nvim_lsp'},
        {name = 'vsnip'},
        {name = "buffer"},
    },
}

-- Python
lspconfig.pylsp.setup{
    capabilites = capabilities,   
}

-- Clangd
lspconfig.clangd.setup{
    filetypes = {"h", "hpp", "c", "cpp", "cuh", "cu", "objc", "objcpp", "proto"},
    capabilites = capabilities,
    cmd = {
        'clangd', '--background-index', '--clang-tidy', '--log=verbose'
    },
    init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
        clangdSemanticHighlighting = true
    },
}

-- LSP signature
require("lsp_signature").setup({
    bind = true,
    handler_opts = {
      border = "rounded"
    }
})
