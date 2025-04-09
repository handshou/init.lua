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

vim.g.mapleader = " "

local plugin = {
    {
        "nvimdev/indentmini.nvim",
        config = function()
            require("indentmini").setup() -- use default config
        end,
    },
    {
        "nvimtools/none-ls.nvim",
        event = { "BufEnter", "BufReadPre" },
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.diagnostics.flake8,
                },
            })
        end
    },
    {
        'Exafunction/codeium.nvim',
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
        },
    },
    {
        'jinh0/eyeliner.nvim',
        config = function()
            require 'eyeliner'.setup {
                -- show highlights only after keypress
                highlight_on_key = true,

                -- dim all other characters if set to true (recommended!)
                dim = false,

                -- set the maximum number of characters eyeliner.nvim will check from
                -- your current cursor position; this is useful if you are dealing with
                -- large files: see https://github.com/jinh0/eyeliner.nvim/issues/41
                max_length = 9999,

                -- filetypes for which eyeliner should be disabled;
                -- e.g., to disable on help files:
                -- disabled_filetypes = {"help"}
                disabled_filetypes = {},

                -- buftypes for which eyeliner should be disabled
                -- e.g., disabled_buftypes = {"nofile"}
                disabled_buftypes = {},

                -- add eyeliner to f/F/t/T keymaps;
                -- see section on advanced configuration for more information
                default_keymaps = true,
            }
        end
    },
    {
        "folke/trouble.nvim",
        opts = {
            use_diagnostic_signs = true,
        },
        cmd = "Trouble",
        keys = {
            {
                "<leader>tt",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>tT",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },
    {
        "nvim-telescope/telescope-media-files.nvim"
    },
    {
        "sphamba/smear-cursor.nvim",

        opts = {
            -- Smear cursor color. Defaults to Cursor GUI color if not set.
            -- Set to "none" to match the text color at the target cursor position.
            cursor_color = "#d3cdc3",

            -- Background color. Defaults to Normal GUI background color if not set.
            normal_bg = "#282828",

            -- Smear cursor when switching buffers or windows.
            smear_between_buffers = true,

            -- Smear cursor when moving within line or to neighbor lines.
            smear_between_neighbor_lines = true,

            -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
            -- Smears will blend better on all backgrounds.
            legacy_computing_symbols_support = false,
        },
    },
    {
        "toppair/peek.nvim",
        event = { "VeryLazy" },
        build = "deno task --quiet build:fast",
        config = function()
            require("peek").setup()
            vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
            vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
        end,
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig

        opts = {},
    },
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                ["astro"] = { "biome-check" },
                ["javascript"] = { "biome-check" },
                ["javascriptreact"] = { "biome-check" },
                ["typescript"] = { "biome-check" },
                ["typescriptreact"] = { "biome-check" },
                ["json"] = { "biome-check" },
                ["css"] = { "biome-check" },
                python = { "black", "isort" },
            },
            formatters = {
                ["biome-check"] = {},
                isort = {
                    command = ".venv/bin/isort",
                },
                black = {
                    -- Use relative path so it's always correct for current project
                    command = ".venv/bin/black",
                    args = { "-" },
                    stdin = true,
                },
            },
        }
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope.nvim" },
        },
    },
    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
        },
        keys = {
            { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
        lazy = false,
    },
    {
        "nvim-telescope/telescope.nvim",
        opts = function(_, opts)
            local actions = require("telescope.actions")
            opts.defaults = {
                mappings = {
                    i = {
                        ["<c-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                    },
                },
            }
        end,
        -- tag = "0.1.4",
        -- or                            , branch = '0.1.x',
        dependencies = { { "nvim-lua/plenary.nvim" }, { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' } },
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

    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    "nvim-treesitter/playground",
    "mbbill/undotree",
    "tpope/vim-fugitive",
    "nvim-treesitter/nvim-treesitter-context",

    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v1.x",
        dependencies = {
            -- LSP Support
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" }, -- Optional
            { "neovim/nvim-lspconfig" },             -- Required

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },         -- Required
            { "hrsh7th/cmp-nvim-lsp" },     -- Required
            { "hrsh7th/cmp-buffer" },       -- Optional
            { "hrsh7th/cmp-path" },         -- Optional
            { "saadparwaiz1/cmp_luasnip" }, -- Optional
            { "hrsh7th/cmp-nvim-lua" },     -- Optional

            -- Snippets
            { "L3MON4D3/LuaSnip" },             -- Required
            { "rafamadriz/friendly-snippets" }, -- Optional
        },

        config = function()
            -- Configure Mason and LSP handlers
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = { "biome" },
            })

            require("mason-lspconfig").setup_handlers({
                ["biome"] = function()
                    require("lspconfig").biome.setup({
                        cmd = { "biome", "lsp-proxy" },
                        filetypes = { "javascript", "typescript", "json", "css", "scss", "html", "markdown", "yaml" },
                        root_dir = require("lspconfig.util").root_pattern(".biomeconfig.json", "package.json"),
                    })
                end,
            })
        end,
    },

    "folke/zen-mode.nvim",
    "laytan/cloak.nvim",
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = "nvim-treesitter/nvim-treesitter",
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "VonHeikemen/fine-cmdline.nvim",
        dependencies = {
            { "MunifTanjim/nui.nvim" },
        },
    },
    {
        "davidmh/mdx.nvim",
        config = true,
        dependencies = { "nvim-treesitter/nvim-treesitter" },
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

            lang = "javascript",

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
    },
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
