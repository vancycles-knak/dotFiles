local M = {}
local trouble = require("trouble.providers.telescope")
local actions = require("telescope.actions")

M.config = function()
    require("telescope").setup {
        defaults = {
            mappings = {
                i = { ["<c-f>"] = trouble.open_with_trouble },
                n = { ["<c-f>"] = trouble.open_with_trouble }
            },
            vimgrep_arguments = {
                "rg",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case"
            },
            prompt_position = "top",
            prompt_prefix = "   ",
            selection_caret = "  ",
            entry_prefix = "  ",
            initial_mode = "insert",
            selection_strategy = "reset",
            sorting_strategy = "descending",
            layout_strategy = "horizontal",
            layout_defaults = {
                horizontal = {
                    mirror = false,
                    preview_width = 0.55
                },
                vertical = {
                    mirror = false
                }
            },
            file_sorter = require "telescope.sorters".get_fuzzy_file,
            file_ignore_patterns = {},
            generic_sorter = require "telescope.sorters".get_generic_fuzzy_sorter,
            shorten_path = true,
            winblend = 0,
            width = 0.75,
            preview_cutoff = 120,
            results_height = 1,
            results_width = 0.8,
            border = {},
            borderchars = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
            color_devicons = true,
            use_less = true,
            set_env = {["COLORTERM"] = "truecolor"}, -- default = nil,
            file_previewer = require "telescope.previewers".vim_buffer_cat.new,
            grep_previewer = require "telescope.previewers".vim_buffer_vimgrep.new,
            qflist_previewer = require "telescope.previewers".vim_buffer_qflist.new,
            -- Developer configurations: Not meant for general override
            buffer_previewer_maker = require "telescope.previewers".buffer_previewer_maker
        },
        extensions = {
            fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = false, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case" -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
            },
            media_files = {
                filetypes = {"png", "webp", "jpg", "jpeg"},
                find_cmd = "rg" -- find command (defaults to `fd`)
            }
        }
    }

    require("telescope").load_extension("fzf")
    require("telescope").load_extension("media_files")
end

return M