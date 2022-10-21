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

call plug#begin('~/vimfiles/plugged')
  Plug 'folke/tokyonight.nvim'
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'ntk148v/vim-horizon'
  Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'yamatsum/nvim-cursorline'
  Plug 'numToStr/Comment.nvim'
  Plug 'tpope/vim-surround'
  "i dont know how to use it enoght
  Plug 'nvim-treesitter/nvim-treesitter'
  Plug 'nvim-treesitter/nvim-treesitter-textobjects'
  Plug 'wellle/targets.vim'
call plug#end()

colorscheme tokyonight


lua << END
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
