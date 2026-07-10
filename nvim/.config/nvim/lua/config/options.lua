--------------------------------------------------------------------------------
-- Options — ported from ~/.vimrc, plus neovim-native productivity defaults.
--------------------------------------------------------------------------------
local opt = vim.opt

-- General ---------------------------------------------------------------------
-- syntax/filetype/nocompatible are on by default in neovim.
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- UI --------------------------------------------------------------------------
opt.number = true             -- show line numbers
opt.relativenumber = true     -- relative line numbers
opt.cursorline = true         -- highlight current line
opt.showmatch = true          -- highlight matching brackets
opt.showcmd = true            -- show partial command in the last line
opt.showmode = false          -- mode shown in the statusline instead
opt.laststatus = 3            -- single global statusline (lualine)
opt.ruler = true
opt.wildmenu = true
opt.wildmode = "longest:full,full"
opt.signcolumn = "yes"        -- always show sign column (avoids text shift)
opt.termguicolors = true      -- true colors (matches tmux catppuccin)
opt.background = "dark"

-- Indentation -----------------------------------------------------------------
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Search ----------------------------------------------------------------------
opt.incsearch = true
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Editing ---------------------------------------------------------------------
opt.backspace = { "indent", "eol", "start" }
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = true
opt.linebreak = true          -- wrap at word boundaries
opt.clipboard = "unnamedplus" -- share yanks with the system clipboard
opt.mouse = "a"               -- mouse in all modes
opt.splitright = true         -- vertical splits open to the right
opt.splitbelow = true         -- horizontal splits open below
opt.completeopt = { "menu", "menuone", "noselect" }
opt.confirm = true            -- prompt instead of failing on unsaved quit
opt.inccommand = "split"      -- live preview of :substitute

-- Performance -----------------------------------------------------------------
opt.updatetime = 300
opt.timeoutlen = 500

-- Files & backup --------------------------------------------------------------
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.autoread = true
opt.hidden = true
opt.undofile = true           -- persistent undo across sessions
opt.undolevels = 10000
