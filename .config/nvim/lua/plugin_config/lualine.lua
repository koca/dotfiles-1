local gps = require("nvim-gps")

-- Display an indicator of tag generation progress
local function gutenTagsProgress()
  return vim.fn['gutentags#statusline']('[', ']')
end

require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    -- Left
    lualine_a = {'mode'},
    lualine_b = {
      'branch',
      'diff',
      {
        'diagnostics',
        sources = {"nvim_diagnostic"},
        -- Same as the sign colors of diagnostics
        diagnostics_color = {
          error = { fg = '#fb4934' },
          warn = { fg = '#fabd2f' },
          info = { fg = '#83a598' },
          hint = { fg = '#8ec07c' },
        },
      }
    },
    lualine_c = {'filename'},

    -- Right
    lualine_x = {
      { gps.get_location, cond = gps.is_available },
      gutenTagsProgress,
      'encoding',
      'fileformat',
      'filetype'
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {'quickfix', 'fugitive', 'nvim-tree', 'aerial'}
}

