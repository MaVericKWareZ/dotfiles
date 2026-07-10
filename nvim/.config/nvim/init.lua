--==============================================================================
-- Neovim Configuration
-- A full IDE setup that mirrors the personal .vimrc experience.
--   lua/config/*   -> options, keymaps, autocmds (ported from ~/.vimrc)
--   lua/plugins/*  -> lazy.nvim plugin specs (LSP, telescope, treesitter, ...)
--==============================================================================

-- Leader must be set before lazy.nvim loads so plugin mappings pick it up.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Bootstrap lazy.nvim, then load every spec under lua/plugins/.
require("config.lazy")
