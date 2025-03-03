require("noice").setup({
    lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          ["vim.ui.input"] = true,
        },
    },
    -- you can enable a preset for easier configuration
    presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
        command_palette = {
            views = {
            cmdline_popup = {
                position = {
                    row = "50%",
                    col = "50%",
                },
                size = {
                    min_width = 60,
                    width = "auto",
                    height = "auto",
                },
            },
            cmdline_popupmenu = {
                position = {
                    row = "67%",
                    col = "50%",
                },
            },
            popupmenu = {
                relative = "editor",
                position = {
                    row = 23,
                    col = "50%",
                },
                size = {
                    width = 60,
                    height = "auto",
                    max_height = 15,
                },
                border = {
                    style = "rounded",
                    padding = { 0, 1 },
                },
                win_options = {
                    winhighlight = { Normal = "Normal", FloatBorder = "NoiceCmdlinePopupBorder" },
                },
            },
            },
        },

    },
})

local BUILTIN_RENDERERS = {
    DEFAULT = "default",
    MINIMAL = "minimal",
  }
  
  local BUILTIN_STAGES = {
    FADE = "fade",
    SLIDE = "slide",
    SLIDE_OUT = "slide_out",
    FADE_IN_SLIDE_OUT = "fade_in_slide_out",
    STATIC = "static",
  }

local notify_config = {
    level = vim.log.levels.INFO,
    timeout = 5000,
    max_width = nil,
    max_height = nil,
    stages = BUILTIN_STAGES.FADE_IN_SLIDE_OUT,
    render = BUILTIN_RENDERERS.DEFAULT,
    background_colour = "NotifyBackground",
    on_open = nil,
    on_close = nil,
    minimum_width = 50,
    fps = 30,
    top_down = false,
    merge_duplicates = true,
    time_formats = {
      notification_history = "%FT%T",
      notification = "%T",
    },
    icons = {
      ERROR = "",
      WARN = "",
      INFO = "",
      DEBUG = "",
      TRACE = "✎",
    },
}

require("notify").setup(notify_config)
