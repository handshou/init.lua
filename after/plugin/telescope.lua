require('telescope').setup({
    pickers = {
        find_files = {
            theme = "ivy"
        }
    },
    extensions = {
        fzf = {}
    }
})

require('telescope').load_extension('fzf')

local builtin = require('telescope.builtin')
vim.keymap.set("n", "<leader>pd", builtin.diagnostics, {})
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>pF', function()
    builtin.find_files({
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
