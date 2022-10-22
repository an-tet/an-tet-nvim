syntax on
set number
set mouse=a
set numberwidth=1
set clipboard=unnamed
set relativenumber
set showmatch
set encoding=utf-8
set ruler
set sw=2
let mapleader=" "

call plug#begin('~/vimfiles/plugged')
  Plug 'folke/tokyonight.nvim'
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'ntk148v/vim-horizon'
  Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'yamatsum/nvim-cursorline'
  Plug 'numToStr/Comment.nvim'
  Plug 'tpope/vim-surround'
  Plug 'nvim-tree/nvim-tree.lua'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'akinsho/toggleterm.nvim'
  "i dont know how to use it enoght
  Plug 'nvim-treesitter/nvim-treesitter'
  Plug 'nvim-treesitter/nvim-treesitter-textobjects'
  Plug 'wellle/targets.vim'
call plug#end()

colorscheme tokyonight
nnoremap <silent><c-t> <Cmd>exe v:count1. "ToggleTerm"<CR>
nnoremap <silent><C-g> <Cmd>exe "ToggleTermToggleAll"<CR>
lua << END
  local powershell_options = {
    shell = vim.fn.executable "pwsh" and "pwsh" or "powershell",
    shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
    shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
    shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
    shellquote = "",
    shellxquote = "",
  }

  for option, value in pairs(powershell_options) do
    vim.opt[option] = value
  end

  require('toggleterm').setup({
    direction = 'horizontal',
    shade_terminals = true
  })

  local builtin = require('telescope.builtin')
  vim.keymap.set('n', 'ff', builtin.find_files, {})
  vim.keymap.set('n', 'fg', builtin.live_grep, {})
  vim.keymap.set('n', 'fb', builtin.buffers, {})
  vim.keymap.set('n', 'fh', builtin.help_tags, {})

  require('nvim-tree').setup({
    hijack_cursor = false,
    on_attach = function(bufnr)
    local bufmap = function(lhs, rhs, desc)
      vim.keymap.set('n', lhs, rhs, {buffer = bufnr, desc = desc})
    end

    -- See :help nvim-tree.api
    local api = require('nvim-tree.api')
      bufmap('L', api.node.open.edit, 'Expand folder or go to file')
      bufmap('H', api.node.navigate.parent_close, 'Close parent folder')
      bufmap('gh', api.tree.toggle_hidden_filter, 'Toggle hidden files')
    end
  })
  vim.keymap.set('n', '<leader>b', '<cmd>NvimTreeToggle<cr>')

  require('Comment').setup()
  require('nvim-treesitter.configs').setup({
    highlight = {
      enable = true,
    },
    ensure_installed = {
      'javascript',
      'typescript',
      'tsx',
      'css',
      'json',
      'lua',
    },
  })

  require('nvim-cursorline').setup {
    cursorline = {
      enable = true,
      timeout = 0,
      number = false,
    },
    cursorword = {
      enable = true,
      min_length = 3,
      hl = { underline = true },
    }
  }

  vim.opt.list = true,
  require("indent_blankline").setup {
      show_current_context = true,
      show_current_context_start = true,
      show_end_of_line = true,
  }
  require('lualine').setup {
    options = {
      icons_enabled = true,
      theme = 'horizon',
      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = ''},
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = false,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      }
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch', 'diff', 'diagnostics'},
      lualine_c = {'filename'},
      lualine_x = {'encoding', 'fileformat', 'filetype'},
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
    winbar = {},
    inactive_winbar = {},
    extensions = {}
  }
END

" This is example text (with a pair of parentheses).
