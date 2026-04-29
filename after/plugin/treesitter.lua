-- Treesitter configuration for Neovim 0.11+

-- Ensure parsers are installed
vim.treesitter.language.register('markdown', 'mdx')

-- Basic highlight settings (treesitter highlight is enabled by default in 0.11+)
vim.api.nvim_create_autocmd('FileType', {
    callback = function()
        pcall(vim.treesitter.start)
    end,
})

-- Textobjects configuration (if nvim-treesitter-textobjects is installed)
local ok, ts_configs = pcall(require, 'nvim-treesitter.configs')
if ok then
    ts_configs.setup({
        ensure_installed = { "javascript", "typescript", "c", "lua", "python", "rust" },
        sync_install = false,
        auto_install = true,
        highlight = { enable = true },
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ['aa'] = '@parameter.outer',
                    ['ia'] = '@parameter.inner',
                    ['af'] = '@function.outer',
                    ['if'] = '@function.inner',
                    ['ac'] = '@class.outer',
                    ['ic'] = '@class.inner',
                    ['ii'] = '@conditional.inner',
                    ['ai'] = '@conditional.outer',
                    ['il'] = '@loop.inner',
                    ['al'] = '@loop.outer',
                    ['at'] = '@comment.outer',
                },
            },
            move = {
                enable = true,
                set_jumps = true,
                goto_next_start = {
                    [']m'] = '@function.outer',
                    [']]'] = '@class.outer',
                },
                goto_next_end = {
                    [']M'] = '@function.outer',
                    [']['] = '@class.outer',
                },
                goto_previous_start = {
                    ['[m'] = '@function.outer',
                    ['[['] = '@class.outer',
                },
                goto_previous_end = {
                    ['[M'] = '@function.outer',
                    ['[]'] = '@class.outer',
                },
            },
        },
    })
end
