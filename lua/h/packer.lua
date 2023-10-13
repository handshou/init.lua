local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
   'wbthomason/packer.nvim',

   {
	  'nvim-telescope/telescope.nvim', tag = '0.1.1',
	  -- or                            , branch = '0.1.x',
	  dependencies = { {'nvim-lua/plenary.nvim'} }
  },

  'folke/tokyonight.nvim',

  'nvim-treesitter/nvim-treesitter', build = ':TSUpdate',
  'nvim-treesitter/playground',
  'theprimeagen/harpoon',
  'mbbill/undotree',
  'tpope/vim-fugitive',
  "nvim-treesitter/nvim-treesitter-context",

   {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v1.x',
	  dependencies = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},             -- Required
		  {'williamboman/mason.nvim',
		  build = function()
			  pcall(vim.cmd, 'MasonUpdate')
		  end,
	  },
	  {'williamboman/mason-lspconfig.nvim'}, -- Optional

	  -- Autocompletion
	  {'hrsh7th/nvim-cmp'},         -- Required
	  {'hrsh7th/cmp-nvim-lsp'},     -- Required
	  {'hrsh7th/cmp-buffer'},       -- Optional
	  {'hrsh7th/cmp-path'},         -- Optional
	  {'saadparwaiz1/cmp_luasnip'}, -- Optional
	  {'hrsh7th/cmp-nvim-lua'},     -- Optional

	  -- Snippets
      {'L3MON4D3/LuaSnip'},             -- Required
	  {'rafamadriz/friendly-snippets'}, -- Optional
    },
  },

  'folke/zen-mode.nvim',
  'laytan/cloak.nvim',
  {
      "nvim-treesitter/nvim-treesitter-textobjects",
      after = "nvim-treesitter",
      dependencies = "nvim-treesitter/nvim-treesitter",
  },
   {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons', opt = true }
  },
}

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").init(plugins, {})
