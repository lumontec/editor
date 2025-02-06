-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- 'nvim-tree/nvim-web-devicons', -- Not required if avoiding fonts
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '<C-t>', ':Neotree toggle<CR>', desc = 'Toggle NeoTree', silent = true, noremap = true },
  },
  opts = {
    filesystem = {
      filtered_items = {
        visible = false, -- Set to true to show hidden files by default
        hide_dotfiles = true,
        hide_gitignored = true,
      },
      follow_current_file = true, -- Auto-focus current file in Neo-tree
      hijack_netrw_behavior = 'open_default', -- Replace netrw with Neo-tree
      window = {
        width = 30,
        mappings = {
          ['\\'] = 'close_window',
          ['l'] = 'open', -- Use `l` to open directories
          ['h'] = 'close_node', -- Use `h` to close
          ['.'] = 'toggle_hidden', -- Toggle hidden files
        },
      },
    },
    default_component_configs = {
      icon = {
        folder_closed = '[+]',
        folder_open = '[-]',
        folder_empty = '[ ]',
        default = '*',
      },
      git_status = {
        symbols = {
          added = '(+)',
          modified = '(~)',
          deleted = '(-)',
          renamed = '(>)',
          untracked = '(?)',
          ignored = '(x)',
        },
      },
    },
  },
}

-- Original plugin configuration
--return {
--  'nvim-neo-tree/neo-tree.nvim',
--  version = '*',
--  dependencies = {
--    'nvim-lua/plenary.nvim',
--    --'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
--    'MunifTanjim/nui.nvim',
--  },
--  cmd = 'Neotree',
--  keys = {
--    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
--  },
--  opts = {
--    filesystem = {
--      window = {
--        mappings = {
--          ['\\'] = 'close_window',
--        },
--      },
--    },
--  },
--}
