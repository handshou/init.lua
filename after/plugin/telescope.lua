require('telescope').setup({
    pickers = {
        find_files = {
            theme = "ivy"
        },
        diagnostics = {
            theme = "dropdown"
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
    }
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
vim.keymap.set('n', '<leader>PS', builtin.live_grep, { desc = 'Telescope live grep' })
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
