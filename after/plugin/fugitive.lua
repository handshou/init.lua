vim.keymap.set("n", "<leader>gs", vim.cmd.Git);
vim.keymap.set("n", "<leader>gv", "<cmd>Gvdiffsplit!<CR>")

-- diff current file against merge-base with main (matches <leader>pg picker)
vim.keymap.set("n", "<leader>gV", function()
  local base = vim.fn.systemlist("git merge-base main HEAD")[1]
  vim.cmd("Gvdiffsplit " .. base)
end, { desc = "Vertical diff vs merge-base main" })

-- true when a fugitive git-blob window is open (i.e. we're in a diff review)
local function find_fugitive_win()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win)):match("^fugitive://") then
      return win
    end
  end
end

-- navigate quickfix; while reviewing a diff, rebuild it fresh on each entry
local function qf_diff_nav(motion)
  -- not reviewing a diff -> plain quickfix nav
  if not find_fugitive_win() then
    vim.cmd(motion)
    return
  end

  local base = vim.fn.systemlist("git merge-base main HEAD")[1]
  if vim.v.shell_error ~= 0 then
    vim.cmd(motion) -- not a git repo with `main`; just move
    return
  end

  vim.cmd("diffoff!") -- unpair the current diff
  local blob = find_fugitive_win() -- close the stale git-blob window
  if blob then
    pcall(vim.api.nvim_win_close, blob, true)
  end
  -- land in a real file window (not quickfix, not blob) before jumping
  if vim.bo.buftype ~= "" then
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
      if vim.bo[vim.api.nvim_win_get_buf(win)].buftype == "" then
        vim.api.nvim_set_current_win(win)
        break
      end
    end
  end

  vim.cmd(motion) -- cnext / cprev loads the next file into this window
  vim.cmd("Gvdiffsplit " .. base)
  vim.cmd("normal! zRzz") -- open folds so changes show, then center
end

vim.keymap.set("n", "\u{AA}", function() qf_diff_nav("cnext") end, { desc = "QF next (+ rebuild diff in review)" })
vim.keymap.set("n", "\u{AB}", function() qf_diff_nav("cprev") end, { desc = "QF prev (+ rebuild diff in review)" })

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
