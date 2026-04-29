vim.keymap.set("n", "<leader>gs", vim.cmd.Git);
vim.keymap.set("n", "<leader>gv", "<cmd>Gvdiffsplit!<CR>")

-- Dotfiles bare repo commands (~/.cfg)
local cfg_git = 'git --git-dir=$HOME/.cfg --work-tree=$HOME '

vim.keymap.set("n", "<leader>gS", function()
  vim.cmd('!' .. cfg_git .. 'status')
end, { desc = "Config status" })

vim.keymap.set("n", "<leader>gD", function()
  vim.cmd('!' .. cfg_git .. 'diff')
end, { desc = "Config diff" })

vim.api.nvim_create_user_command('Config', function(opts)
  local args = opts.args ~= '' and opts.args or 'status'
  vim.cmd('!' .. cfg_git .. args)
end, { nargs = '*' })

local ThePrimeagen_Fugitive = vim.api.nvim_create_augroup("ThePrimeagen_Fugitive", {})

local autocmd = vim.api.nvim_create_autocmd
autocmd("BufWinEnter", {
    group = ThePrimeagen_Fugitive,
    pattern = "*",
    callback = function()
        if vim.bo.ft ~= "fugitive" then
            return
        end

        local bufnr = vim.api.nvim_get_current_buf()
        local opts = { buffer = bufnr, remap = false }
        vim.keymap.set("n", "<leader>p", function()
            vim.cmd.Git('push')
        end, opts)

        -- rebase always
        vim.keymap.set("n", "<leader>P", function()
            vim.cmd.Git('pull --rebase')
        end, opts)

        -- NOTE: It allows me to easily set the branch i am pushing and any tracking
        -- needed if i did not set the branch up correctly
        vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts);
    end,
})

vim.keymap.set("n", "gf", "<cmd>diffget //2<CR>")
vim.keymap.set("n", "gj", "<cmd>diffget //3<CR>")
