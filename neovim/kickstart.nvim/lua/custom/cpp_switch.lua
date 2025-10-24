-- ~/.config/nvim/lua/custom/cpp_switch.lua
local function switch_source_header()
  local file = vim.fn.expand('%:p')
  local basename = vim.fn.expand('%:r')
  local ext = vim.fn.expand('%:e')

  local candidates = {}
  if ext == 'c' or ext == 'C' or ext == 'cc' or ext == 'cpp' then
    candidates = { basename .. '.h', basename .. '.H', basename .. '.hpp', basename .. '.hh' }
  elseif ext == 'h' or ext == 'H' or ext == 'hpp' or ext == 'hh' then
    candidates = { basename .. '.c', basename .. '.C', basename .. '.cc', basename .. '.cpp' }
  else
    vim.notify('Not a C/C++ source or header file', vim.log.levels.WARN)
    return
  end

  for _, candidate in ipairs(candidates) do
    if vim.fn.filereadable(candidate) == 1 then
      vim.cmd('edit ' .. candidate)
      return
    end
  end

  vim.notify('No corresponding file found', vim.log.levels.INFO)
end

vim.keymap.set('n', '<leader>oh', switch_source_header, { desc = 'Open header/source counterpart' })

