vim.api.nvim_create_user_command('Open', require('peek').open, {})
vim.api.nvim_create_user_command('Close', require('peek').close, {})
