-- nord light theme
return {
  'lumontec/nord-vim-light', -- The Nord Light theme plugin
  version = '*',
  config = function()
    -- Set the Nord Light theme
    vim.cmd 'colorscheme nordlight' -- This applies the colorscheme
  end,
}

-- nord dark theme
--
--return {
--  'shaunsingh/nord.nvim', -- The Nord Light theme plugin
--  version = '*',
--  config = function()
--    -- Customizing Nord Light Theme
--    vim.g.nord_contrast = true -- Enable contrast (makes the colors brighter)
--    vim.g.nord_borders = true -- Enable borders
--    vim.g.nord_uniform_diff_background = true -- Make diff background uniform
--    vim.g.nord_italic = true -- Enable italic fonts for comments and keywords
--    vim.g.nord_italic_comments = true -- Enable italic for comments
--    vim.g.nord_italic_keywords = true -- Enable italic for keywords
--    vim.g.nord_uniform_status_lines = true -- Uniform status line colors
--    vim.g.nord_bold = true -- Enable bold text
--    vim.g.nord_disable_background = false -- Set to true if you want to disable background
--
--    -- Set Nord Light theme
--    vim.cmd 'colorscheme nord'
--  end,
--}
