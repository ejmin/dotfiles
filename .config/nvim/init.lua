
-- nvim config


local g = vim.g       -- Global variables
local opt = vim.opt   -- Set options (global/buffer/windows-scoped)
local keymap = vim.keymap 
-----------------------------------------------------------
-- General
-----------------------------------------------------------
g.mapleader = '['
--g.maplocalleader = ' '
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })

opt.mouse = 'a'                       -- Enable mouse support
opt.clipboard = 'unnamedplus'         -- Copy/paste to system clipboard
opt.swapfile = false                  -- Don't use swapfile
opt.completeopt = 'menuone,noinsert,noselect'  -- Autocomplete options

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true           -- Show line number
opt.relativenumber = true   -- rel number
opt.scrolloff = 17
opt.sidescrolloff = 15
opt.showmatch = true        -- Highlight matching parenthesis
opt.foldmethod = 'marker'   -- Enable folding (default 'foldmarker')
opt.colorcolumn = '120'      -- Line lenght marker at 80 columns
opt.splitright = true       -- Vertical split to the right
opt.splitbelow = true       -- Horizontal split to the bottom
opt.ignorecase = true       -- Ignore case letters when search
opt.smartcase = true        -- Ignore lowercase for the whole pattern
opt.linebreak = true        -- Wrap on word boundary
opt.termguicolors = true    -- Enable 24-bit RGB colors
opt.laststatus=3            -- Set global statusline

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true        -- Use spaces instead of tabs
opt.shiftwidth = 4          -- Shift 4 spaces when tab
opt.tabstop = 4             -- 1 tab == 4 spaces
opt.smartindent = true      -- Autoindent new lines

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true           -- Enable background buffers
opt.history = 1000           -- Remember N lines in history
opt.lazyredraw = true       -- Faster scrolling
opt.synmaxcol = 240         -- Max column for syntax highlight
opt.updatetime = 150        -- ms to wait for trigger an event



-- disable nvim intro
opt.shortmess:append "sI"

-- -- Disable builtin plugins
local disabled_built_ins = {
   "2html_plugin",
   "getscript",
   "getscriptPlugin",
   "gzip",
   "logipat",
   "netrw",
   "netrwPlugin",
   "netrwSettings",
   "netrwFileHandlers",
   "matchit",
   "tar",
   "tarPlugin",
   "rrhelper",
   "spellfile_plugin",
   "vimball",
   "vimballPlugin",
   "zip",
   "zipPlugin",
   "tutor",
   "rplugin",
   "synmenu",
   "optwin",
   "compiler",
   "bugreport",
   "ftplugin",
}

-- PLUGINS
--



local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug('preservim/nerdtree', { ['on'] = 'NERDTreeToggle' })
Plug('navarasu/onedark.nvim')
Plug('nvim-treesitter/nvim-treesitter')
Plug('luochen1990/rainbow')

Plug 'stevearc/conform.nvim'

Plug('ibhagwan/fzf-lua', {['branch'] = 'main'})
Plug('nvim-tree/nvim-web-devicons')

Plug('kdheepak/lazygit.nvim')
Plug('vimlab/split-term.vim')
Plug('ms-jpq/coq_nvim', {['branch'] = 'coq'})
Plug('ms-jpq/coq.artifacts', {['branch'] = 'artifacts'})
Plug('ms-jpq/coq.thirdparty', {['branch'] = '3p'})


-- hardtime
--Plug('m4xshen/hardtime.nvim')
--Plug('MunifTanjim/nui.nvim')
--Plug('nvim-lua/plenary.nvim')





vim.call('plug#end')


--
-- END PLUGINS

-- PLUGIN CONFIG
--
-- rainbow
g.rainbow_active = 1

-- fzf

-- treesitter
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
 -- ensure_installed = { "python", "lua", "vim", "vimdoc", "query", "html", "bash" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  --sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  --auto_install = true,

  -- List of parsers to ignore installing (or "all")
  --ignore_install = {  },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: thesee are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

-- Autocomplete
--


-- conform

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    python = { "isort", "black" },
    -- You can customize some of the format options for the filetype (:help conform.format)
    rust = { "rustfmt", lsp_format = "fallback" },
    -- Conform will run the first available formatter
    javascript = { "prettierd", "prettier", stop_after_first = true },
  },
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})


require("conform").setup({
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})

--
--
--
--
-- END PLUGIN CONFIG


-- THEME
--
require('onedark').setup {
    style = 'darker'
}
require('onedark').load()

-- LSP config
--

-- Nerdtree settings
g.NERDTreeShowHidden = 1

-- hardtime
--require("hardtime").setup()


-- SHORTCUTS 
--

keymap.set('n', '<space>f', ':FzfLua files<CR>')
keymap.set('n', '<space>b', ':FzfLua buffers<CR>')
keymap.set('n', '<space>s', ':FzfLua grep_visual<CR>')

keymap.set('n', '<leader>w', ':wall<CR>')

keymap.set('n', '<space>g', ':LazyGit<CR>')

keymap.set('n', '<space>o', ':NERDTreeToggle<CR>')
keymap.set('i', 'jk', '<Esc>')
keymap.set('i', 'kj', '<Esc>')


