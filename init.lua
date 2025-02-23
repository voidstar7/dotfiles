-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup leaders before loading lazy.nvim
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
-- plugin files are in ~/.local/share/nvim/lazy
require('lazy').setup({
  { "junegunn/goyo.vim" },
  { 
		"vimwiki/vimwiki",
		config = function() 
			vim.g.vimwiki_list = {{ path = '~/vimwiki/', syntax = 'markdown', ext = '.md' }} 
		end 
	},
  { 
    "junegunn/fzf", 
    build = function() 
      vim.fn['fzf#install']()
    end 
  },
  { "junegunn/fzf.vim" },
  { "michal-h21/vim-zettel" },
  { "mattn/calendar-vim" },
  { 
    "preservim/nerdtree", 
    config = function()
      vim.g.NERDTreeShowHidden = 1
    end
  },
  { "airblade/vim-gitgutter" },
  { "salsifis/vim-qfmanip" },
  { "farconics/victionary" },
  { 
		"prettier/vim-prettier", 
		config = function() 
			vim.fn['system']('yarn install --frozen-lockfile --production') 
		end 
	},
  { "jiangmiao/auto-pairs" },
  { "tpope/vim-surround" },
  { "alvan/vim-closetag" },
  { "tpope/vim-liquid" },
})

-- Basic Neovim settings
vim.cmd('syntax on')
vim.opt.termguicolors = false
vim.cmd('colorscheme vim')  -- Adjust to your preferred colorscheme

-- Terminal colors for tmux/screen if not using GUI
if not vim.fn.has('gui_running') and vim.o.term:match('^\\%(screen\\|tmux\\)') then
  vim.o.t_8f = "\\<Esc>[38;2;%lu;%lu;%lum"
  vim.o.t_8b = "\\<Esc>[48;2;%lu;%lu;%lum"
end

-- General settings
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.fillchars:append({ vert = ' ' })
vim.opt.laststatus = 2
vim.opt.statusline = "%<%f %h%m%r%=%-14.(%l,%c%) %P"
vim.opt.confirm = true
vim.opt.foldenable = false
vim.opt.foldlevelstart = 20
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.bg = "light"
vim.opt.hlsearch = false
vim.opt.foldmethod = "syntax"
vim.opt.cursorline = true

-- Highlighting settings without 'term'
vim.api.nvim_set_hl(0, "LineNr", { ctermfg = 250 })
vim.api.nvim_set_hl(0, "Conceal", { ctermbg = "none" })
vim.api.nvim_set_hl(0, "ErrorMsg", { ctermfg = 231, ctermbg = 9 })
vim.api.nvim_set_hl(0, "Error", { ctermfg = 231, ctermbg = 9 })
vim.api.nvim_set_hl(0, "SpellBad", { ctermfg = 231, ctermbg = 9 })
vim.api.nvim_set_hl(0, "MatchParen", { ctermfg = 0, ctermbg = 11 })
vim.api.nvim_set_hl(0, "Visual", { ctermbg = 254 })
vim.api.nvim_set_hl(0, "Folded", { ctermbg = 255 })
vim.api.nvim_set_hl(0, "VertSplit", { ctermbg = 16 })
vim.api.nvim_set_hl(0, "StatusLineNC", { ctermbg = 254 })
vim.api.nvim_set_hl(0, "CursorLine", { ctermbg = 255 })
vim.api.nvim_set_hl(0, "CursorColumn", { ctermbg = 255 })
vim.api.nvim_set_hl(0, "CursorLineNr", { ctermfg = 245, ctermbg = 255 })

-- Key Mappings
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<F1>', ':NERDTree<CR>', opts)
map('n', '<F2>', ':VimwikiUISelect<CR>', opts)
map('n', '<F3>', ':Calendar<CR>', opts)
map('n', '<F4>', ':VimwikiDiaryGenerateLinks<CR>', opts)
map('n', '<F5>', ':Goyo<CR>', opts)
map('n', '<F6>', ':Goyo!<CR>', opts)
map('n', '<F7>', ':VimwikiRebuildTags<CR>', opts)
map('n', '<F10>', ':so ~/.vimrc<CR>', opts)
map('n', '<leader>o', ':ZettelOpen<CR>', opts)
map('n', '<leader>i', ':ZettelSearch<CR>', opts)
map('n', '<leader>n', ':ZettelNew<CR>', opts)
map('n', '<C-z>', '<nop>', opts)
map('n', '<leader>f', "<Esc>:cd %:p:h<CR><Esc>:Ag<CR>", opts)
map('n', '<leader>F', "<Esc>:cd %:p:h<CR><Esc>:Files<CR>", opts)
map('n', '<leader>b', "<Esc>:Buffers<CR>", opts)
map('n', '<Down>', '<C-d>', opts)
map('n', '<Up>', '<C-u>', opts)
map('n', '<S-j>', '<C-e>', opts)
map('n', '<S-k>', '<C-y>', opts)
map('n', '<C-h>', ':tabp<CR>', opts)
map('n', '<C-l>', ':tabn<CR>', opts)
map('n', '<Space>', ':', opts)
map('n', '<M-h>', '<C-w>h', opts)
map('n', '<M-l>', '<C-w>l', opts)
map('n', '<M-k>', '<C-w>k', opts)
map('n', '<M-j>', '<C-w>j', opts)
map('n', '<M-S-j>', '<C-w>+', opts)
map('n', '<M-S-k>', '<C-w>-', opts)
map('n', '<M-S-h>', '<C-w><', opts)
map('n', '<M-S-l>', '<C-w>>', opts)
map('i', '<Left>', '<C-o><C-w>h<Esc>', opts)
map('i', '<Right>', '<C-o><C-w>l<Esc>', opts)
map('i', '<Up>', '<C-o><C-w>k<Esc>', opts)
map('i', '<Down>', '<C-o><C-w>j<Esc>', opts)
map('i', '<C-f>', '<esc>f>a', opts)
