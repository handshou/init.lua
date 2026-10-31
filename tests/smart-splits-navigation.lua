local plugins = require("lazy.core.config").plugins
assert(plugins["smart-splits.nvim"] ~= nil)
assert(plugins["vim-tmux-navigator"] == nil)
for _, name in ipairs({ "backend-tmux", "smart-splits-backend-herdr", "smart-splits-backend-rex" }) do
	assert(plugins[name] ~= nil, "Missing multiplexer backend: " .. name)
end

for _, key in ipairs({ "<C-h>", "<C-j>", "<C-k>", "<C-l>" }) do
	local mapping = vim.fn.maparg(key, "n", false, true)
	assert(type(mapping.callback) == "function", "Missing smart-splits mapping: " .. key)
end

local navigation = require("smart-splits")
local first = vim.api.nvim_get_current_win()
vim.cmd("rightbelow vsplit")
local second = vim.api.nvim_get_current_win()
assert(first ~= second)
navigation.move_cursor_left()
assert(vim.api.nvim_get_current_win() == first)
navigation.move_cursor_right()
assert(vim.api.nvim_get_current_win() == second)
vim.cmd("only")
vim.cmd("belowright split")
local lower = vim.api.nvim_get_current_win()
navigation.move_cursor_up()
assert(vim.api.nvim_get_current_win() ~= lower)
navigation.move_cursor_down()
assert(vim.api.nvim_get_current_win() == lower)
print("Neovim smart-splits plugin, backend, mappings, and split navigation checks passed")
