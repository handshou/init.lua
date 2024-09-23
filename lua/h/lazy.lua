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

vim.g.mapleader = ' '

local plugin = {
   {
	  'nvim-telescope/telescope.nvim', tag = '0.1.4',
	  -- or                            , branch = '0.1.x',
	  dependencies = { {'nvim-lua/plenary.nvim'} }
  },

  {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      config = function()
        -- load the colorscheme here
        vim.cmd([[colorscheme tokyonight]])
      end,
  },

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
		  {'williamboman/mason.nvim',
		  build = function()
			  pcall(vim.cmd, 'MasonUpdate')
		  end,
	  },
	  {'williamboman/mason-lspconfig.nvim'}, -- Optional
	  {'neovim/nvim-lspconfig'},             -- Required

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
      dependencies = "nvim-treesitter/nvim-treesitter",
  },
  {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  {
      'VonHeikemen/fine-cmdline.nvim',
      dependencies = {
          {'MunifTanjim/nui.nvim'},
      },
  },
  {
      "kawre/leetcode.nvim",
      build = ":TSUpdate html",
      dependencies = {
          "nvim-treesitter/nvim-treesitter",
          "nvim-telescope/telescope.nvim",
          "nvim-lua/plenary.nvim", -- required by telescope
          "MunifTanjim/nui.nvim",

          -- optional
          "nvim-tree/nvim-web-devicons",

          -- recommended
          -- "rcarriga/nvim-notify",
      },
      opts = {
          domain = "com", -- For now "com" is the only one supported

          arg = "leetcode.nvim",

          lang = "python3",

          sql = "postgresql",

          ---@type string
          directory = vim.fn.stdpath("data") .. "/leetcode/",

          ---@type boolean
          logging = true,

          console = {
              ---@type boolean
              open_on_runcode = false,

              size = {
                  width = "75%", ---@type string | integer
                  height = "75%", ---@type string | integer
              },
              dir = "row", ---@type "col" | "row"
          },

          description = {
              width = "40%", ---@type string | integer
          },
      },
  }
}

require("lazy").setup(plugin, {})

require("tokyonight").setup({
    on_highlights = function(hl, c)
        local prompt = "#2d3149"
        hl.TelescopeNormal = {
            bg = c.bg_dark,
            fg = c.fg_dark,
        }
        hl.TelescopeBorder = {
            bg = c.bg_dark,
            fg = c.bg_dark,
        }
        hl.TelescopePromptNormal = {
            bg = prompt,
        }
        hl.TelescopePromptBorder = {
            bg = prompt,
            fg = prompt,
        }
        hl.TelescopePromptTitle = {
            bg = prompt,
            fg = prompt,
        }
        hl.TelescopePreviewTitle = {
            bg = c.bg_dark,
            fg = c.bg_dark,
        }
        hl.TelescopeResultsTitle = {
            bg = c.bg_dark,
            fg = c.bg_dark,
        }
    end,
})

vim.cmd.colorscheme("tokyonight")

