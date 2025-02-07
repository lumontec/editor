-- File: lua/plugins/oscyank.lua

return {
  'ojroques/vim-oscyank', -- The plugin
  version = '*',
  config = function()
    -- Map the yank functionality for visual mode
    vim.cmd 'vnoremap ye :OSCYankVisual<CR>'

    -- Function to yank the current file and line
    function YankFileLine()
      local file = vim.fn.expand '%' -- Current file path
      local line = vim.fn.line '.' -- Current line number
      local fileline = file .. ':' .. line -- Combine file and line

      -- Optionally, copy to a specific register (e.g., @0)
      vim.fn.setreg('0', fileline)

      -- Yank the content to the OSCYank register (clipboard)
      vim.cmd 'OSCYankRegister 0'
    end

    -- Map F5 to yank the file and line number and copy to OSCYank register
    vim.cmd 'noremap <F5> :lua YankFileLine()<CR>:OSCYankRegister 0<CR>'
  end,
}
