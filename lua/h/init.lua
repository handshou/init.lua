require('h.lazy')
require('h.remap')
require('h.set')

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_liststyle = 3
vim.g.codeium_enabled = true

-- Define the function in Lua
local function netrw_highlight_file()
    if vim.g.netrw_cursor_restore then
        vim.fn.search("^" .. vim.g.netrw_cursor_restore .. "$", "wc")
        vim.g.netrw_cursor_restore = nil
    end
end

-- Create the augroup
local netrw_highlight = vim.api.nvim_create_augroup("netrw_highlight", { clear = true })

-- Create the autocmd
vim.api.nvim_create_autocmd("FileType", {
    group = netrw_highlight,
    pattern = "netrw",
    callback = netrw_highlight_file,
})

