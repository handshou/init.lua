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
    lualine_b = {
      "diagnostics",
    },
    lualine_c = {
      {
        'filename',
        file_status = true,
        path = 4,
        shorting_target = 90,
        symbols = {
          unnamed = ''
        }
      }
    },
    lualine_x = {
      "filetype",
    },
  },
}
