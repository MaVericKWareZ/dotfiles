"===============================================================================
" Vim Configuration
" A minimal, approachable vim setup for quick edits
"===============================================================================

"-------------------------------------------------------------------------------
" General Settings
"-------------------------------------------------------------------------------
set nocompatible              " Disable vi compatibility
syntax enable                 " Enable syntax highlighting
filetype plugin indent on     " Enable filetype detection

set encoding=utf-8            " UTF-8 encoding
set fileencoding=utf-8        " File encoding

"-------------------------------------------------------------------------------
" UI Settings
"-------------------------------------------------------------------------------
set number                    " Show line numbers
set relativenumber            " Relative line numbers
set cursorline                " Highlight current line
set showmatch                 " Highlight matching brackets
set showcmd                   " Show command in bottom bar
set showmode                  " Show current mode
set laststatus=2              " Always show status line
set ruler                     " Show cursor position
set wildmenu                  " Visual autocomplete for command menu
set wildmode=longest:full,full

" Colors
set background=dark
set termguicolors             " Enable true colors if supported
colorscheme default

"-------------------------------------------------------------------------------
" Indentation
"-------------------------------------------------------------------------------
set tabstop=2                 " Tabs are 2 spaces
set shiftwidth=2              " Indent with 2 spaces
set softtabstop=2             " Backspace removes 2 spaces
set expandtab                 " Use spaces instead of tabs
set autoindent                " Auto-indent new lines
set smartindent               " Smart indentation

"-------------------------------------------------------------------------------
" Search
"-------------------------------------------------------------------------------
set incsearch                 " Search as you type
set hlsearch                  " Highlight search results
set ignorecase                " Case-insensitive search
set smartcase                 " Case-sensitive if uppercase present

" Clear search highlighting with Escape
nnoremap <Esc> :nohlsearch<CR>

"-------------------------------------------------------------------------------
" Editing
"-------------------------------------------------------------------------------
set backspace=indent,eol,start " Allow backspace over everything
set scrolloff=8               " Keep 8 lines visible when scrolling
set sidescrolloff=8           " Keep 8 columns visible
set wrap                      " Wrap long lines
set linebreak                 " Break at word boundaries

"-------------------------------------------------------------------------------
" Performance
"-------------------------------------------------------------------------------
set lazyredraw                " Don't redraw during macros
set updatetime=300            " Faster updates
set timeoutlen=500            " Faster key sequence completion

"-------------------------------------------------------------------------------
" Files and Backup
"-------------------------------------------------------------------------------
set nobackup                  " No backup files
set nowritebackup             " No backup before overwriting
set noswapfile                " No swap files
set autoread                  " Auto-reload changed files
set hidden                    " Allow hidden buffers

"-------------------------------------------------------------------------------
" Key Mappings
"-------------------------------------------------------------------------------
" Leader key
let mapleader = " "

" Quick save
nnoremap <leader>w :w<CR>

" Quick quit
nnoremap <leader>q :q<CR>

" Move between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Move lines up/down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Better indenting in visual mode
vnoremap < <gv
vnoremap > >gv

" Yank to end of line (consistent with D, C)
nnoremap Y y$

" Center cursor after jumps
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

"-------------------------------------------------------------------------------
" Status Line (simple, no plugin)
"-------------------------------------------------------------------------------
set statusline=
set statusline+=\ %f                " File path
set statusline+=\ %m                " Modified flag
set statusline+=\ %r                " Readonly flag
set statusline+=%=                  " Right align
set statusline+=\ %y                " File type
set statusline+=\ %l:%c             " Line:Column
set statusline+=\ %p%%              " Percentage through file
set statusline+=\ 

"-------------------------------------------------------------------------------
" File Type Specific
"-------------------------------------------------------------------------------
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType go setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab
autocmd FileType make setlocal noexpandtab
autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2

" Trim trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

"-------------------------------------------------------------------------------
" Notes
"-------------------------------------------------------------------------------
" This is a minimal vim config for quick terminal edits.
" For a full editing experience, use VS Code or IntelliJ.
"
" To extend this config, consider:
" - vim-plug for plugin management
" - fzf.vim for fuzzy finding
" - vim-gitgutter for git changes
" - coc.nvim for LSP support
"-------------------------------------------------------------------------------
