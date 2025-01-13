require('telescope').setup({
    pickers = {
        find_files = {
            theme = "ivy"
        },
        diagnostics = {
            theme = "dropdown",
            layout_config = {
                width = 0.65,
                height = 20
            }
        },
        live_grep = {
            theme = "dropdown"
        },
        git_files = {
            theme = "ivy"
        },
        grep_string = {
            theme = "ivy"
        },
    },
    extensions = {
        fzf = {},
        media_files = {
            -- filetypes whitelist
            -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
            filetypes = { "png", "webp", "jpg", "jpeg", "mp4", "ttf", "webm", "pdf" },

            -- find command (defaults to `fd`)
            find_cmd = "rg"
        }
    },
})
require('telescope').load_extension('fzf')

require('telescope').load_extension('media_files')
vim.keymap.set("n", "<leader>pm", function()
    require('telescope').extensions.media_files.media_files(
        require('telescope.themes').get_dropdown()
    )
end, {})

local builtin = require('telescope.builtin')
vim.keymap.set("n", "<leader>pd", builtin.diagnostics, {})
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>pF', function()
    builtin.find_files(
        require('telescope.themes').get_dropdown(),
        {
            hidden = true,
            no_ignore = true,
            file_ignore_patterns = {
                "node_modules/.*",
                ".git/*",
            }
        })
end, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({
        search = vim.fn.input("Grep > ")
    });
end)
vim.keymap.set('n', '<leader>pws', function()
    local word = vim.fn.expand("<cword>")
    builtin.grep_string({ search = word })
end)
vim.keymap.set('n', '<leader>pWs', function()
    local word = vim.fn.expand("<cWORD>")
    builtin.grep_string({ search = word })
end)
vim.keymap.set('n', '<leader>PS', function()
    builtin.live_grep({
        additional_args = function()
            return { "--pcre2" } --enables search pattern capability
        end
    })
end, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>pS', function()
    builtin.grep_string({
        search = vim.fn.input("Grep > "),
        additional_args = function()
            return { "--hidden", "--no-ignore", "--glob=!.git/", "--glob=!node_modules/**" }
        end
    });
end)
vim.keymap.set('n', '<leader>en', function()
    builtin.find_files({
        cwd = vim.fn.stdpath('config')
    })
end, {})
vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
