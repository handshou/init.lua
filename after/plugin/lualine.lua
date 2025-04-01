vim.cmd [[highlight WinSeparator guifg=#4e545c guibg=None]]
require('lualine').setup {
    options = {
        theme = "tokyonight",
        icons_enabled = true,
        globalstatus = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "█", right = "█" },
    },
    sections = {
        lualine_a = {
            'mode',
        },
        lualine_b = {
            'diagnostics',
        },
        lualine_c = {
            {
                'filename',
                file_status = true,
                path = 4,
                shorting_target = 20,
                symbols = {
                    unnamed = ''
                },
            }
        },
        lualine_x = {
            { function() return vim.fn['codeium#GetStatusString']() end, color = { fg = '#ff9e64' } }
        },
        lualine_y = {
        },
        lualine_z = {
            'location'
        },
    },
    tabline = {
        lualine_a = {
        },
        lualine_b = {
        },
        lualine_c = {
            {
                'filename',
                file_status = true,
                path = 1,
                shorting_target = 30,
                symbols = {
                    unnamed = ''
                },
            }
        },
        lualine_x = {
            -- 'filetype'
        },
        lualine_y = {
        },
        lualine_z = {
        }
    }
}
