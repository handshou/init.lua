require('telescope').setup({
    pickers = {
        find_files = {
            theme = "ivy"
        }
    }
})

local builtin = require('telescope.builtin')
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
vim.keymap.set('n', '<leader>pS', function()
    builtin.grep_string({
        search = vim.fn.input("Grep > "),
        additional_args = function()
            return { "--hidden", "--no-ignore", "--glob=!.git/", "--glob=!node_modules/**" }
        end
    });
end)
